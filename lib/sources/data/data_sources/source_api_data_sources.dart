import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_application/shared/view_model/api_constant.dart';
import 'package:news_application/sources/data/data_sources/sources_data_sources.dart';
import 'package:news_application/sources/data/models/source.dart';
import 'package:news_application/sources/data/models/source_respnse.dart';

class SourceApiDataSources implements SourcesDataSources {
  @override
  Future<List<Source>> getSources(String categoryId) async {
    Uri uri = Uri.https(ApiConstant.apiBase, ApiConstant.sourceEndPoints, {
      "apiKey": ApiConstant.apiKey,
      "category": categoryId,
    });
    http.Response response = await http.get(uri);

    Map<String, dynamic> json = jsonDecode(response.body);

    SourceRespnse sourceRespnse = SourceRespnse.fromJson(json);

    if (sourceRespnse.status == "ok" && sourceRespnse.sources != null) {
      return sourceRespnse.sources!;
    } else {
      throw Exception("Faild to load sources");
    }
  }
}
