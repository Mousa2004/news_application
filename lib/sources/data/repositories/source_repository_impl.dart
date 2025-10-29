import 'package:news_application/sources/data/data_sources/remote/sources_data_sources.dart';
import 'package:news_application/sources/data/models/source.dart';
import 'package:news_application/sources/data/repositories/source_repository.dart';

class SourceRepositoryImpl implements SourceRepository {
  SourcesDataSources sourcesDataSources;
  SourceRepositoryImpl(this.sourcesDataSources);
  @override
  Future<List<Source>> getSources(String categoryId) {
    return sourcesDataSources.getSources(categoryId);
  }
}
