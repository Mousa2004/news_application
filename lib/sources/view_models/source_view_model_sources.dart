import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/shared/view/widget/service_locator.dart';
import 'package:news_application/sources/data/models/source.dart';
import 'package:news_application/sources/data/repositories/source_repository.dart';
import 'package:news_application/sources/view_models/source_state.dart';

class SourceViewModelSources extends Cubit<SourceState> {
  SourceViewModelSources() : super(InitialState());

  SourceRepository sourceDataSources = SourceRepository(
    ServiceLocator.sourcesDataSources,
  );

  Future<void> getSources(String categoryId) async {
    emit(GetSourceLoading());

    try {
      List<Source> sources = await sourceDataSources.getSources(categoryId);
      emit(GetSourceSuccess(sources));
    } catch (error) {
      emit(GetSourceError(error.toString()));
    }
  }
}
