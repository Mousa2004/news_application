import 'package:news_application/news/data/data_sources/news_data_sources.dart';
import 'package:news_application/news/data/models/article.dart';

class NewsRepository {
  NewsDataSources newsDataSources;
  NewsRepository(this.newsDataSources);
  Future<List<News>> getNews(String newsId, int page, int pageSize) {
    return newsDataSources.getNews(newsId, page, pageSize);
  }

  Future<List<News>> searchNews(String query) {
    return newsDataSources.searchNews(query);
  }
}
