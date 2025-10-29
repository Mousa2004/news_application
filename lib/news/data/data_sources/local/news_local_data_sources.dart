import 'package:news_application/news/data/models/article.dart';

abstract class NewsLocalDataSources {
  Future<List<News>> getNews(String newsId, int page, int pageSize);
  void saveNews(List<News> news, String newsId);
}
