import 'package:flutter/material.dart';
import 'package:news_application/api/api_services.dart';
import 'package:news_application/apptheme.dart';
import 'package:news_application/model/news_response/news_response.dart';
import 'package:news_application/news/news_item.dart';
import 'package:news_application/news/show_details_button.dart';
import 'package:news_application/provider/setting_theme_provider.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  static const String routName = "/search";
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController search = TextEditingController();
  Future<NewsResponse>? searchResult;

  void _onSearchChanged(String query) {
    if (query.isNotEmpty) {
      setState(() {
        searchResult = ApiServices.searchNews(query);
      });
    } else {
      setState(() {
        searchResult = null;
      });
    }
  }

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
                onChanged: _onSearchChanged,
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
              child: searchResult == null
                  ? Center(
                      child: Text(
                        "Start typing to search...",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    )
                  : FutureBuilder<NewsResponse>(
                      future: searchResult,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        } else if (snapshot.hasError) {
                          return Center(
                            child: Text("Error: ${snapshot.error}"),
                          );
                        } else if (!snapshot.hasData ||
                            snapshot.data!.newsList!.isEmpty) {
                          return Center(
                            child: Text(
                              "No results found.",
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                          );
                        } else {
                          final articles = snapshot.data!.newsList;
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                SizedBox(height: 16),
                            itemCount: articles!.length,
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
                                        news: snapshot.data!.newsList![index],
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
          ],
        ),
      ),
    );
  }
}
