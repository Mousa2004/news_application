import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/sources/data/models/source.dart';
import 'package:news_application/sources/data/repositories/source_repository.dart';
import 'package:news_application/sources/view_models/source_state.dart';

class SourceViewModelSources extends Cubit<SourceState> {
  SourceRepository sourceDataSources;
  SourceViewModelSources(this.sourceDataSources) : super(InitialState());

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
