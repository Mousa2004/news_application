import 'package:flutter/widgets.dart';
import 'package:news_application/sources/data/models/source.dart';
import 'package:news_application/sources/data/models/source_respnse.dart';
import 'package:news_application/sources/data/data_sources/source_data_sources.dart';

class SourceViewModelSources with ChangeNotifier {
  List<Source> sources = [];
  String? errorMessage;
  bool isloading = false;
  SourceDataSources sourceDataSources = SourceDataSources();

  Future<void> getSources(String categoryId) async {
    isloading = true;
    notifyListeners();
    try {
      SourceRespnse response = await sourceDataSources.getSources(categoryId);
      if (response.status == "ok" && response.sources != null) {
        sources = response.sources!;
      } else {
        errorMessage = "Faild to load sources";
      }
    } catch (error) {
      errorMessage = error.toString();
    }
    isloading = false;
    notifyListeners();
  }
}
