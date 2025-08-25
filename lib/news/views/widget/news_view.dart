import 'package:flutter/material.dart';
import 'package:news_application/news/view_model/news_view_model_news.dart';
import 'package:news_application/shared/view/widget/apptheme.dart';
import 'package:news_application/shared/view/widget/customed_error_messages.dart';
import 'package:news_application/sources/data/models/source.dart';
import 'package:news_application/news/views/widget/news_item.dart';
import 'package:news_application/news/views/widget/show_details_button.dart';
import 'package:news_application/news/views/widget/tabBar_item.dart';
import 'package:news_application/sources/view_models/source_view_model_sources.dart';
import 'package:provider/provider.dart';

class NewsView extends StatefulWidget {
  final String categoryId;
  const NewsView({super.key, required this.categoryId});

  @override
  State<NewsView> createState() => _NewsViewState();
}

class _NewsViewState extends State<NewsView> {
  int currentIndex = 0;
  int page = 1;
  int pageSize = 3;

  ScrollController controller = ScrollController();
  bool hasMore = true;

  late SourceViewModelSources sourceViewModelSources;
  late NewsViewModelNews newsViewModelNews;

  @override
  void initState() {
    super.initState();
    sourceViewModelSources = SourceViewModelSources();
    newsViewModelNews = NewsViewModelNews();

    sourceViewModelSources.getSources(widget.categoryId).then((_) {
      if (sourceViewModelSources.sources.isNotEmpty) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) loadingData();
        });
      }
    });

    controller.addListener(() {
      if (controller.position.pixels == controller.position.maxScrollExtent &&
          !newsViewModelNews.isLoading &&
          hasMore) {
        loadingData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => sourceViewModelSources),
        ChangeNotifierProvider(create: (_) => newsViewModelNews),
      ],
      child: Consumer<SourceViewModelSources>(
        builder: (_, viewSources, __) {
          if (viewSources.isloading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewSources.errorMessage != null) {
            return CustomedErrorMessages(message: viewSources.errorMessage!);
          } else {
            List<Source> sources = viewSources.sources;
            if (sources.isEmpty) {
              return const Center(child: Text("No sources available"));
            }

            return Column(
              children: [
                DefaultTabController(
                  length: sources.length,
                  child: TabBar(
                    onTap: (index) {
                      if (currentIndex == index) return;
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        if (mounted) {
                          setState(() {
                            currentIndex = index;
                            page = 1;
                            hasMore = true;
                          });
                          newsViewModelNews.clearNews();
                          loadingData();
                        }
                      });
                    },
                    isScrollable: true,
                    labelPadding: const EdgeInsetsDirectional.only(start: 16),
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
                const SizedBox(height: 16),
                Expanded(
                  child: Consumer<NewsViewModelNews>(
                    builder: (_, viewNews, __) {
                      if (viewNews.isLoading && viewNews.newsList.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (viewNews.errorMessage != null &&
                          viewNews.newsList.isEmpty) {
                        return CustomedErrorMessages(
                          message: viewNews.errorMessage!,
                        );
                      }

                      return ListView.separated(
                        controller: controller,
                        itemBuilder: (context, index) {
                          if (index < viewNews.newsList.length) {
                            final news = viewNews.newsList[index];
                            return InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  context: context,
                                  isScrollControlled: true,
                                  builder: (context) => Container(
                                    margin: EdgeInsets.only(
                                      bottom:
                                          MediaQuery.sizeOf(context).height *
                                          0.05,
                                    ),
                                    child: ShowDetailsButton(news: news),
                                  ),
                                );
                              },
                              child: NewsItem(news: news),
                            );
                          } else {
                            if (viewNews.isLoading) {
                              return const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Center(
                                  child: CircularProgressIndicator(),
                                ),
                              );
                            } else if (!hasMore) {
                              return const Padding(
                                padding: EdgeInsets.all(16.0),
                                child: Center(
                                  child: Text(
                                    "No more news",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              );
                            } else {
                              return const SizedBox();
                            }
                          }
                        },
                        separatorBuilder: (context, index) =>
                            const SizedBox(height: 16),
                        itemCount: viewNews.newsList.length + 1,
                      );
                    },
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Future<void> loadingData() async {
    if (newsViewModelNews.isLoading) return;

    final sources = sourceViewModelSources.sources;
    if (sources.isEmpty) return;

    final currentSource = sources[currentIndex];

    await newsViewModelNews.getNews(currentSource.id!, page, pageSize);

    if (newsViewModelNews.errorMessage == null &&
        newsViewModelNews.newsList.isNotEmpty) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() {
            page++;
          });
        }
      });
    } else {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          setState(() => hasMore = false);
        }
      });
    }
  }
}
