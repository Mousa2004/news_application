import 'package:news_application/news/data/data_sources/news_api_data_sources.dart';
import 'package:news_application/news/data/data_sources/news_data_sources.dart';
import 'package:news_application/sources/data/data_sources/source_api_data_sources.dart';
import 'package:news_application/sources/data/data_sources/sources_data_sources.dart';

class ServiceLocator {
  static NewsDataSources newsDataSources = NewsApiDataSources();
  static SourcesDataSources sourcesDataSources = SourceApiDataSources();
}
