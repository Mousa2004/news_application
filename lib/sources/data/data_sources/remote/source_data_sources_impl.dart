import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';
import 'package:news_application/shared/view_model/api_constant.dart';
import 'package:news_application/sources/data/data_sources/remote/sources_data_sources.dart';
import 'package:news_application/sources/data/models/source.dart';
import 'package:news_application/sources/data/models/source_respnse.dart';

@Singleton(as: SourcesDataSources)
class SourceDataSourcesImpl implements SourcesDataSources {
  @override
  Future<List<Source>> getSources(String categoryId) async {
    Uri uri = Uri.https(ApiConstant.apiBase, ApiConstant.sourceEndPoints, {
      "apiKey": ApiConstant.apiKey,
      "category": categoryId,
    });
    var response = await http.get(uri);

    var json = jsonDecode(response.body);

    SourceRespnse sourceRespnse = SourceRespnse.fromJson(json);

    if (sourceRespnse.status == "ok" && sourceRespnse.sources != null) {
      return sourceRespnse.sources!;
    } else {
      throw Exception("Faild to load sources");
    }
  }
}
