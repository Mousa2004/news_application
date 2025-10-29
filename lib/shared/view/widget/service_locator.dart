import 'package:news_application/news/data/data_sources/local/news_local_data_sources.dart';
import 'package:news_application/news/data/data_sources/local/news_local_data_sources_impl.dart';
import 'package:news_application/news/data/data_sources/remote/news_data_sources.dart';
import 'package:news_application/news/data/data_sources/remote/news_data_sources_impl.dart';
import 'package:news_application/news/data/repositories/news_repository.dart';
import 'package:news_application/news/data/repositories/news_repository_impl.dart';
import 'package:news_application/sources/data/data_sources/local/source_local_data_sources.dart';
import 'package:news_application/sources/data/data_sources/local/source_local_data_sources_impl.dart';
import 'package:news_application/sources/data/data_sources/remote/source_data_sources_impl.dart';

import 'package:news_application/sources/data/data_sources/remote/sources_data_sources.dart';
import 'package:news_application/sources/data/repositories/source_repository.dart';
import 'package:news_application/sources/data/repositories/source_repository_impl.dart';

SourcesDataSources injectionSourcesDataSources() {
  return SourceDataSourcesImpl();
}

SourceLocalDataSources injectionSourceLocalDataSources() {
  return SourceLocalDataSourcesImpl();
}

SourceRepository injectionSourceRepository(
  SourcesDataSources injectionSourcesDataSources,
  SourceLocalDataSources sourceLocalDataSources,
) {
  return SourceRepositoryImpl(
    injectionSourcesDataSources,
    sourceLocalDataSources,
  );
}

NewsDataSources injectionNewsDataSources() {
  return NewsDataSourcesImpl();
}

NewsLocalDataSources injectionNewsLocalDataSources() {
  return NewsLocalDataSourcesImpl();
}

NewsRepository injectionNewsRepository(
  NewsDataSources injectionNewsDataSources,
  NewsLocalDataSources injectionNewsLocalDataSources,
) {
  return NewsRepositoryImpl(
    injectionNewsDataSources,
    injectionNewsLocalDataSources,
  );
}
