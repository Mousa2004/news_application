import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_application/news/data/data_sources/remote/news_data_sources.dart';
import 'package:news_application/news/data/models/article.dart';
import 'package:news_application/news/data/models/news_response.dart';
import 'package:news_application/shared/view_model/api_constant.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Named("NewsDioDataSourcesImp")
@Singleton(as: NewsDataSources)
class NewsDioDataSourcesImp implements NewsDataSources {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://newsapi.org",
      queryParameters: {"apiKey": ApiConstant.apiKey},
    ),
  );
  NewsDioDataSourcesImp() {
    dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: true,
        error: true,
        compact: true,
        maxWidth: 90,
        enabled: true,
        filter: (options, args) {
          // don't print requests with uris containing '/posts'
          if (options.path.contains('/posts')) {
            return false;
          }
          // don't print responses with unit8 list data
          return !args.isResponse || !args.hasUint8ListData;
        },
      ),
    );
  }
  @override
  Future<List<News>> getNews(String newsId, int page, int pageSize) async {
    try {
      var response = await dio.get(
        ApiConstant.newsEndPoints,
        queryParameters: {
          "sources": newsId,
          "page": page.toString(),
          "pageSize": pageSize.toString(),
        },
      );
      var responeBody = response.data;
      NewsResponse newsResponse = NewsResponse.fromJson(responeBody);
      if (newsResponse.status == "ok" && newsResponse.newsList != null) {
        return newsResponse.newsList!;
      } else {
        throw Exception("Faild to load news");
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<News>> searchNews(String query) async {
    try {
      var response = await dio.get(
        ApiConstant.newsEndPoints,
        queryParameters: {"q": query},
      );
      NewsResponse newsResponse = NewsResponse.fromJson(response.data);
      if (newsResponse.status == "ok" && newsResponse.newsList != null) {
        return newsResponse.newsList!;
      } else {
        throw Exception("No results found.");
      }
    } catch (e) {
      rethrow;
    }
  }
}
