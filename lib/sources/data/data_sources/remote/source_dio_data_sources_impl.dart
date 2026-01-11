import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:news_application/shared/view_model/api_constant.dart';
import 'package:news_application/sources/data/data_sources/remote/sources_data_sources.dart';
import 'package:news_application/sources/data/models/source.dart';
import 'package:news_application/sources/data/models/source_respnse.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

@Named("SourceDioDataSourcesImpl")
@Singleton(as: SourcesDataSources)
class SourceDioDataSourcesImpl implements SourcesDataSources {
  Dio dio = Dio(
    BaseOptions(
      baseUrl: "https://newsapi.org",
      queryParameters: {"apiKey": ApiConstant.apiKey},
    ),
  );
  SourceDioDataSourcesImpl() {
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
  Future<List<Source>> getSources(String categoryId) async {
    try {
      var response = await dio.get(
        ApiConstant.sourceEndPoints,
        queryParameters: {"category": categoryId},
      );
      var responseBody = response.data;
      SourceRespnse sourceRespnse = SourceRespnse.fromJson(responseBody);
      if (sourceRespnse.sources != null && sourceRespnse.status == "ok") {
        return sourceRespnse.sources!;
      } else {
        throw Exception("Faild to load sources");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
