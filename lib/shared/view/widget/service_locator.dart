import 'package:news_application/news/data/data_sources/remote/news_data_sources_impl.dart';
import 'package:news_application/news/data/data_sources/remote/news_data_sources.dart';
import 'package:news_application/news/data/repositories/news_repository.dart';
import 'package:news_application/news/data/repositories/news_repository_impl.dart';
import 'package:news_application/sources/data/data_sources/remote/source_data_sources_impl.dart';

import 'package:news_application/sources/data/data_sources/remote/sources_data_sources.dart';
import 'package:news_application/sources/data/repositories/source_repository.dart';
import 'package:news_application/sources/data/repositories/source_repository_impl.dart';

SourcesDataSources injectionSourcesDataSources() {
  return SourceDataSourcesImpl();
}

SourceRepository injectionSourceRepository(
  SourcesDataSources injectionSourcesDataSources,
) {
  return SourceRepositoryImpl(injectionSourcesDataSources);
}

NewsDataSources injectionNewsDataSources() {
  return NewsDataSourcesImpl();
}

NewsRepository injectionNewsRepository(
  NewsDataSources injectionNewsDataSources,
) {
  return NewsRepositoryImpl(injectionNewsDataSources);
}
