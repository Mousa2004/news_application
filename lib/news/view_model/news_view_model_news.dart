import 'package:flutter/widgets.dart';
import 'package:news_application/news/data/data_sources/news_data_sources.dart';
import 'package:news_application/news/data/models/article.dart';
import 'package:news_application/news/data/models/news_response.dart';

class NewsViewModelNews with ChangeNotifier {
  NewsDataSources newsDataSources = NewsDataSources();
  List<News> newsList = [];
  String? errorMessage;
  bool isLoading = false;
  Future<void> getNews(String newsId, int page, int pageSize) async {
    isLoading = true;
    notifyListeners();
    try {
      NewsResponse response = await newsDataSources.getNews(
        newsId,
        page,
        pageSize,
      );
      if (response.status == "ok" && response.newsList != null) {
        if (page == 1) newsList.clear();
        newsList.addAll(response.newsList!);
      } else {
        errorMessage = "Faild to load news";
      }
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }

  void clearNews() {
    newsList.clear();
    notifyListeners();
  }
}
