import 'package:flutter/material.dart';
import 'package:news_application/api/api_services.dart';
import 'package:news_application/apptheme.dart';
import 'package:news_application/model/news_response/article.dart';
import 'package:news_application/model/source_respnse/source.dart';
import 'package:news_application/model/source_respnse/source_respnse.dart';
import 'package:news_application/news/news_item.dart';
import 'package:news_application/news/show_details_button.dart';
import 'package:news_application/news/tabBar_item.dart';

class NewsView extends StatefulWidget {
  final String categoryId;
  const NewsView({super.key, required this.categoryId});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;
  late Future<SourceRespnse> getSourceFuture;

  int page = 1;
  int pageSize = 3;
  ScrollController controller = ScrollController();
  bool isLoading = false;
  bool hasMore = true;
  List<News> newsList = [];

  @override
  void initState() {
    super.initState();
    getSourceFuture = ApiServices.getSources(widget.categoryId);

    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent &&
          !isLoading &&
          hasMore) {
        loadingData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSourceFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data?.status != "ok") {
          return Center(child: Text("Error loading sources"));
        } else {
          List<Source> sources = snapshot.data?.sources ?? [];
          if (sources.isEmpty) {
            return Center(child: Text("No sources available"));
          }

          if (newsList.isEmpty && !isLoading) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              loadingData();
            });
          }

          return Column(
            children: [
              DefaultTabController(
                length: sources.length,
                child: TabBar(
                  onTap: (index) {
                    if (currentIndex == index) return;
                    setState(() {
                      currentIndex = index;
                      page = 1;
                      newsList.clear();
                      hasMore = true;
                    });
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      loadingData();
                    });
                  },
                  isScrollable: true,
                  labelPadding: EdgeInsetsDirectional.only(start: 16),
                  tabAlignment: TabAlignment.start,
                  indicatorColor: Apptheme.white,
                  dividerColor: Colors.transparent,
                  tabs: sources
                      .map(
                        (source) => TabbarItem(
                          source: source,
                          isSelect: currentIndex == sources.indexOf(source),
                        ),
                      )
                      .toList(),
                ),
              ),
              SizedBox(height: 16),
              Expanded(
                child: ListView.separated(
                  controller: controller,
                  itemBuilder: (context, index) {
                    if (index < newsList.length) {
                      return InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            isScrollControlled: true,

                            builder: (context) => Container(
                              margin: EdgeInsets.only(
                                bottom:
                                    MediaQuery.sizeOf(context).height * 0.05,
                              ),
                              child: ShowDetailsButton(news: newsList[index]),
                            ),
                          );
                        },
                        child: NewsItem(news: newsList[index]),
                      );
                    } else {
                      if (isLoading) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(child: CircularProgressIndicator()),
                        );
                      } else if (!hasMore) {
                        return Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Center(
                            child: Text(
                              "No more news",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                        );
                      } else {
                        return SizedBox();
                      }
                    }
                  },
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemCount: newsList.length + 1,
                ),
              ),
            ],
          );
        }
      },
    );
  }

  Future loadingData() async {
    if (isLoading) return;

    setState(() => isLoading = true);

    try {
      final sources = (await getSourceFuture).sources ?? [];
      if (sources.isEmpty) return;

      final currentSource = sources[currentIndex];

      final response = await ApiServices.getNews(
        currentSource.id!,
        page,
        pageSize,
      );

      if (response.status == "ok" && response.newsList != null) {
        setState(() {
          if (response.newsList!.isEmpty) {
            hasMore = false;
          } else {
            newsList.addAll(response.newsList!);
            page++;
          }
        });
      }
    } catch (e) {
      print("Error loading data: $e");
    } finally {
      setState(() => isLoading = false);
    }
  }
}
