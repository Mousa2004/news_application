import 'package:flutter/material.dart';

import 'package:news_application/news/view_model/news_view_model_news.dart';

import 'package:news_application/shared/view/widget/apptheme.dart';

import 'package:news_application/news/views/widget/news_item.dart';
import 'package:news_application/news/views/widget/show_details_button.dart';
import 'package:news_application/shared/view/widget/customed_error_messages.dart';
import 'package:news_application/shared/view_model/setting_theme_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const String routName = "/search";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController search = TextEditingController();
  NewsViewModelNews newsViewModelNews = NewsViewModelNews();

  @override
  Widget build(BuildContext context) {
    SettingThemeProvider settingThemeProvider =
        Provider.of<SettingThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text("Search", style: Theme.of(context).textTheme.titleLarge),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(width: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextFormField(
                controller: search,
                onChanged: newsViewModelNews.searchNews,
                cursorColor: Apptheme.white,
                style: Theme.of(context).textTheme.titleLarge,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: "Search news...",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: Apptheme.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(
                      color: settingThemeProvider.isLight
                          ? Apptheme.black
                          : Apptheme.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ChangeNotifierProvider(
                create: (context) => newsViewModelNews,
                child: Consumer<NewsViewModelNews>(
                  builder: (_, search, _) {
                    if (search.isLoading) {
                      return Center(child: CircularProgressIndicator());
                    } else if (search.errorMessage != null) {
                      return CustomedErrorMessages(
                        message: search.errorMessage!,
                      );
                    } else if (search.searchNewsList.isEmpty) {
                      return Center(
                        child: Text(
                          "No results found.",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      );
                    } else {
                      final articles = search.searchNewsList;
                      return ListView.separated(
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16),
                        itemCount: articles.length,
                        itemBuilder: (context, index) {
                          final article = articles[index];
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
                                  child: ShowDetailsButton(
                                    news: search.searchNewsList[index],
                                  ),
                                ),
                              );
                            },

                            child: NewsItem(news: article),
                          );
                        },
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
