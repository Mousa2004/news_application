import 'package:news_application/news/data/models/article.dart';

abstract class NewsDataSources {
  Future<List<News>> getNews(String newsId, int page, int pageSize);
  Future<List<News>> searchNews(String query);
}
