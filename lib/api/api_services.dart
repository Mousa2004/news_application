import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_application/api/api_constant.dart';
import 'package:news_application/model/news_response/news_response.dart';
import 'package:news_application/model/source_respnse/source_respnse.dart';

class ApiServices {
  static Future<SourceRespnse> getSources(String categoryId) async {
    Uri uri = Uri.https(ApiConstant.apiBase, ApiConstant.sourceEndPoints, {
      "apiKey": ApiConstant.apiKey,
      "category": categoryId,
    });
    http.Response response = await http.get(uri);

    Map<String, dynamic> json = jsonDecode(response.body);

    return SourceRespnse.fromJson(json);
  }

  static Future<NewsResponse> getNews(String newsId) async {
    Uri uri = Uri.https(ApiConstant.apiBase, ApiConstant.newsEndPoints, {
      "apiKey": ApiConstant.apiKey,
      "sources": newsId,
    });
    http.Response response = await http.get(uri);

    Map<String, dynamic> json = jsonDecode(response.body);

    return NewsResponse.fromJson(json);
  }

  static Future<NewsResponse> searchNews(String query) async {
    Uri uri = Uri.https(ApiConstant.apiBase, ApiConstant.newsEndPoints, {
      "apiKey": ApiConstant.apiKey,
      "q": query,
    });
    http.Response response = await http.get(uri);

    Map<String, dynamic> json = jsonDecode(response.body);

    return NewsResponse.fromJson(json);
  }
}
