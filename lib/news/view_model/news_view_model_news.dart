import 'package:flutter/widgets.dart';
import 'package:news_application/news/data/data_sources/news_data_sources.dart';
import 'package:news_application/news/data/models/article.dart';

class NewsViewModelNews with ChangeNotifier {
  NewsDataSources newsDataSources = NewsDataSources();
  List<News> newsList = [];
  List<News> searchNewsList = [];
  String? errorMessage;
  bool isLoading = false;
  Future<void> getNews(String newsId, int page, int pageSize) async {
    isLoading = true;
    notifyListeners();
    try {
      if (page == 1) newsList.clear();
      newsList.addAll(await newsDataSources.getNews(newsId, page, pageSize));
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

  Future<void> searchNews(String query) async {
    isLoading = true;
    notifyListeners();
    try {
      searchNewsList = await newsDataSources.searchNews(query);
    } catch (error) {
      errorMessage = error.toString();
    }
    isLoading = false;
    notifyListeners();
  }
}
