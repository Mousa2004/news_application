import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_application/news/data/data_sources/local/news_local_data_sources.dart';
import 'package:news_application/news/data/data_sources/remote/news_data_sources.dart';
import 'package:news_application/news/data/models/article.dart';
import 'package:news_application/news/data/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  NewsDataSources newsDataSources;
  NewsLocalDataSources newsLocalDataSources;
  NewsRepositoryImpl(this.newsDataSources, this.newsLocalDataSources);
  @override
  Future<List<News>> getNews(String newsId, int page, int pageSize) async {
    //Internet
    final List<ConnectivityResult> connectivityResult = await (Connectivity()
        .checkConnectivity());

    // This condition is for demo purposes only to explain every connection type.
    // Use conditions which work for your requirements.
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      var response = await newsDataSources.getNews(newsId, page, pageSize);
      newsLocalDataSources.saveNews(response, newsId);
      return response;
      // Mobile network available.
    } else {
      //No Internet
      var response = await newsLocalDataSources.getNews(newsId, page, pageSize);
      return response;
    }
  }

  @override
  Future<List<News>> searchNews(String query) {
    return newsDataSources.searchNews(query);
  }
}
