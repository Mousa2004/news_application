import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:news_application/news/view_model/news_state.dart';
import 'package:news_application/news/view_model/news_view_model_news.dart';
import 'package:news_application/shared/view/widget/apptheme.dart';
import 'package:news_application/shared/view/widget/customed_error_messages.dart';
import 'package:news_application/shared/view/widget/service_locator.dart';
import 'package:news_application/sources/data/models/source.dart';
import 'package:news_application/news/views/widget/news_item.dart';
import 'package:news_application/news/views/widget/show_details_button.dart';
import 'package:news_application/news/views/widget/tabBar_item.dart';
import 'package:news_application/sources/view_models/source_state.dart';
import 'package:news_application/sources/view_models/source_view_model_sources.dart';

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
    sourceViewModelSources = SourceViewModelSources(
      injectionSourceRepository(
        injectionSourcesDataSources(),
        injectionSourceLocalDataSources(),
      ),
    );
    newsViewModelNews = NewsViewModelNews(
      injectionNewsRepository(
        injectionNewsDataSources(),
        injectionNewsLocalDataSources(),
      ),
    );

    sourceViewModelSources.getSources(widget.categoryId).then((_) {
      final currentState = sourceViewModelSources.state;
      if (currentState is GetSourceSuccess) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) loadingData();
        });
      }
    });

    controller.addListener(() {
      final currentState = newsViewModelNews.state;
      if (controller.position.pixels == controller.position.maxScrollExtent &&
          currentState is! GetNewsLoading &&
          hasMore) {
        loadingData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sourceViewModelSources),
        BlocProvider(create: (_) => newsViewModelNews),
      ],
      child: BlocBuilder<SourceViewModelSources, SourceState>(
        builder: (context, viewSources) {
          if (viewSources is GetSourceLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (viewSources is GetSourceError) {
            return CustomedErrorMessages(message: viewSources.message);
          } else if (viewSources is GetSourceSuccess) {
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
                SizedBox(height: 16.h),
                Expanded(
                  child: BlocBuilder<NewsViewModelNews, NewsState>(
                    builder: (_, viewNews) {
                      if (viewNews is GetNewsLoading &&
                          newsViewModelNews.newsList.isEmpty) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (viewNews is GetNewsError) {
                        return CustomedErrorMessages(message: viewNews.message);
                      } else if (viewNews is GetNewsSuccess ||
                          viewNews is GetNewsLoading ||
                          viewNews is GetNewsPaginationLoading) {
                        final newsList = newsViewModelNews.newsList;

                        return ListView.separated(
                          controller: controller,
                          itemBuilder: (context, index) {
                            if (index < newsList.length) {
                              final news = newsList[index];
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
                                            0.05.h,
                                      ),
                                      child: ShowDetailsButton(news: news),
                                    ),
                                  );
                                },
                                child: NewsItem(news: news),
                              );
                            } else {
                              if (viewNews is GetNewsPaginationLoading) {
                                return const Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: Center(
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else if (!hasMore) {
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                    vertical:
                                        MediaQuery.sizeOf(context).height *
                                        0.4.h,
                                  ),
                                  child: Column(
                                    children: [
                                      Center(
                                        child: Text(
                                          "No more news",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(fontSize: 20),
                                        ),
                                      ),
                                      SizedBox(
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                            0.02.h,
                                      ),
                                      MaterialButton(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadiusGeometry.circular(
                                                16.r,
                                              ),
                                        ),
                                        color: Apptheme.grey,
                                        onPressed: () {
                                          final sourceState =
                                              sourceViewModelSources.state;
                                          if (sourceState is GetSourceSuccess) {
                                            final sources = sourceState.sources;
                                            if (sources.isNotEmpty) {
                                              final currentSource =
                                                  sources[currentIndex];
                                              newsViewModelNews.getNews(
                                                currentSource.id!,
                                                page,
                                                pageSize,
                                              );
                                              sourceViewModelSources.getSources(
                                                widget.categoryId,
                                              );
                                            }
                                          }
                                        },

                                        child: Text(
                                          "Try again",
                                          style: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .copyWith(fontSize: 20),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              } else {
                                return const SizedBox();
                              }
                            }
                          },
                          separatorBuilder: (context, index) =>
                              SizedBox(height: 16.h),
                          itemCount: newsList.length + 1,
                        );
                      }
                      return const SizedBox();
                    },
                  ),
                ),
              ],
            );
          } else {
            return SizedBox();
          }
        },
      ),
    );
  }

  Future<void> loadingData() async {
    final newsState = newsViewModelNews.state;
    if (newsState is GetNewsLoading) return;

    final sourceState = sourceViewModelSources.state;
    if (sourceState is GetSourceSuccess) {
      final sources = sourceState.sources;
      if (sources.isEmpty) return;

      final currentSource = sources[currentIndex];

      final oldLength = newsViewModelNews.newsList.length;

      await newsViewModelNews.getNews(currentSource.id!, page, pageSize);

      final newLength = newsViewModelNews.newsList.length;

      if (newLength > oldLength) {
        setState(() {
          page++;
        });
      } else {
        setState(() {
          hasMore = false;
        });
      }
    }
  }
}
