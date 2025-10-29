import 'package:hive/hive.dart';
import 'package:news_application/news/data/data_sources/local/news_local_data_sources.dart';
import 'package:news_application/news/data/models/article.dart';

class NewsLocalDataSourcesImpl implements NewsLocalDataSources {
  @override
  Future<List<News>> getNews(String newsId, int page, int pageSize) async {
    var box = await Hive.openBox("NewsList");
    final newsData = await box.get(newsId);
    if (newsData == null) return [];
    return List<News>.from(newsData);
  }

  @override
  void saveNews(List<News> news, String newsId) async {
    var box = await Hive.openBox("NewsList");
    await box.put(newsId, news);
    await box.close();
  }
}
