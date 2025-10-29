import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:news_application/sources/data/data_sources/local/source_local_data_sources.dart';
import 'package:news_application/sources/data/data_sources/remote/sources_data_sources.dart';
import 'package:news_application/sources/data/models/source.dart';
import 'package:news_application/sources/data/repositories/source_repository.dart';

class SourceRepositoryImpl implements SourceRepository {
  SourcesDataSources sourcesDataSources;
  SourceLocalDataSources sourceLocalDataSources;
  SourceRepositoryImpl(this.sourcesDataSources, this.sourceLocalDataSources);
  @override
  Future<List<Source>> getSources(String categoryId) async {
    // internet
    final List<ConnectivityResult> connectivityResult = await (Connectivity()
        .checkConnectivity());

    // This condition is for demo purposes only to explain every connection type.
    // Use conditions which work for your requirements.
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      var response = await sourcesDataSources.getSources(categoryId);
      sourceLocalDataSources.saveSources(response, categoryId);
      return response;
    } else {
      var response = sourceLocalDataSources.getSources(categoryId);
      return response;
    }
  }
}
