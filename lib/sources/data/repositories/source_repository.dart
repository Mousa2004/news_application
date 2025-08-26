import 'package:news_application/sources/data/data_sources/sources_data_sources.dart';
import 'package:news_application/sources/data/models/source.dart';

class SourceRepository {
  SourcesDataSources sourcesDataSources;
  SourceRepository(this.sourcesDataSources);
  Future<List<Source>> getSources(String categoryId) {
    return sourcesDataSources.getSources(categoryId);
  }
}
