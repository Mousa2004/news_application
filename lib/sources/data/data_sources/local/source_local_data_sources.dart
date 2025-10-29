import 'package:news_application/sources/data/models/source.dart';

abstract class SourceLocalDataSources {
  Future<List<Source>> getSources(String categoryId);
  void saveSources(List<Source> source, String categoryId);
}
