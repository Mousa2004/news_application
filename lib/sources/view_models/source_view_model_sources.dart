import 'package:flutter/widgets.dart';
import 'package:news_application/shared/view/widget/service_locator.dart';
import 'package:news_application/sources/data/models/source.dart';
import 'package:news_application/sources/data/repositories/source_repository.dart';

class SourceViewModelSources with ChangeNotifier {
  List<Source> sources = [];
  String? errorMessage;
  bool isloading = false;
  SourceRepository sourceDataSources = SourceRepository(
    ServiceLocator.sourcesDataSources,
  );

  Future<void> getSources(String categoryId) async {
    isloading = true;
    notifyListeners();
    try {
      sources = await sourceDataSources.getSources(categoryId);
    } catch (error) {
      errorMessage = error.toString();
    }
    isloading = false;
    notifyListeners();
  }
}
