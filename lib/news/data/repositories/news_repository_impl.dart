import 'package:news_application/news/data/data_sources/remote/news_data_sources.dart';
import 'package:news_application/news/data/models/article.dart';
import 'package:news_application/news/data/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  NewsDataSources newsDataSources;
  NewsRepositoryImpl(this.newsDataSources);
  @override
  Future<List<News>> getNews(String newsId, int page, int pageSize) {
    return newsDataSources.getNews(newsId, page, pageSize);
  }

  @override
  Future<List<News>> searchNews(String query) {
    return newsDataSources.searchNews(query);
  }
}
