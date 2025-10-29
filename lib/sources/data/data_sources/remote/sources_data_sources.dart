import 'package:news_application/sources/data/models/source.dart';

abstract class SourcesDataSources {
  Future<List<Source>> getSources(String categoryId);
}
