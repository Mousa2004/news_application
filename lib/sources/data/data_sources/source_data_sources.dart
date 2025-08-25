import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_application/shared/view_model/api_constant.dart';
import 'package:news_application/sources/data/models/source_respnse.dart';

class SourceDataSources {
  Future<SourceRespnse> getSources(String categoryId) async {
    Uri uri = Uri.https(ApiConstant.apiBase, ApiConstant.sourceEndPoints, {
      "apiKey": ApiConstant.apiKey,
      "category": categoryId,
    });
    http.Response response = await http.get(uri);

    Map<String, dynamic> json = jsonDecode(response.body);

    return SourceRespnse.fromJson(json);
  }
}
