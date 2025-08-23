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
  late Future<SourceRespnse> getSourceFuture = ApiServices.getSources(
    widget.categoryId,
  );
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getSourceFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || snapshot.data?.status != "ok") {
          return Center(
            child: Text("error", style: Theme.of(context).textTheme.titleLarge),
          );
        } else {
          List<Source> sources = snapshot.data?.sources ?? [];
          return Column(
            children: [
              DefaultTabController(
                length: sources.length,
                child: TabBar(
                  onTap: (index) {
                    if (currentIndex == index) return;
                    currentIndex = index;
                    setState(() {});
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
                child: FutureBuilder(
                  future: ApiServices.getNews(sources[currentIndex].id!),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError ||
                        snapshot.data?.status != "ok") {
                      return Center(
                        child: Text(
                          "error",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      );
                    } else {
                      List<News> newsList = snapshot.data?.newsList ?? [];
                      return ListView.separated(
                        itemBuilder: (context, index) => InkWell(
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
                                child: ShowDetailsButton(
                                  news: snapshot.data!.newsList![index],
                                ),
                              ),
                            );
                          },

                          child: NewsItem(news: newsList[index]),
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16),
                        itemCount: newsList.length,
                      );
                    }
                  },
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
