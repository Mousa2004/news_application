import 'package:hive/hive.dart';
import 'package:news_application/sources/data/data_sources/local/source_local_data_sources.dart';
import 'package:news_application/sources/data/models/source.dart';

class SourceLocalDataSourcesImpl implements SourceLocalDataSources {
  @override
  Future<List<Source>> getSources(String categoryId) async {
    var box = await Hive.openBox("SourcesList");
    final data = box.get(categoryId);
    if (data == null) return [];
    return List<Source>.from(data);
  }

  @override
  void saveSources(List<Source> source, String categoryId) async {
    var box = await Hive.openBox("SourcesList");
    await box.put(categoryId, source);
    await box.close();
  }
}
