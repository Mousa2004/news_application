import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_application/news/data/models/article.dart';
import 'package:news_application/shared/view_model/api_constant.dart';
import 'package:news_application/news/data/models/news_response.dart';

class NewsDataSources {
  Future<List<News>> getNews(String newsId, int page, int pageSize) async {
    Uri uri = Uri.https(ApiConstant.apiBase, ApiConstant.newsEndPoints, {
      "apiKey": ApiConstant.apiKey,
      "sources": newsId,
      "page": page.toString(),
      "pageSize": pageSize.toString(),
    });
    http.Response response = await http.get(uri);

    Map<String, dynamic> json = jsonDecode(response.body);

    NewsResponse newsResponse = NewsResponse.fromJson(json);

    if (newsResponse.status == "ok" && newsResponse.newsList != null) {
      return newsResponse.newsList!;
    } else {
      throw Exception("Faild to load news");
    }
  }

  Future<List<News>> searchNews(String query) async {
    Uri uri = Uri.https(ApiConstant.apiBase, ApiConstant.newsEndPoints, {
      "apiKey": ApiConstant.apiKey,
      "q": query,
    });
    http.Response response = await http.get(uri);

    Map<String, dynamic> json = jsonDecode(response.body);

    NewsResponse newsResponse = NewsResponse.fromJson(json);

    if (newsResponse.status == "ok" && newsResponse.newsList != null) {
      return newsResponse.newsList!;
    } else {
      throw Exception("No results found.");
    }
  }
}
