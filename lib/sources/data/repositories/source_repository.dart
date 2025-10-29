import 'package:news_application/sources/data/models/source.dart';

abstract class SourceRepository {
  Future<List<Source>> getSources(String categoryId);
}
