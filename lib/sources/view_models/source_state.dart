import 'package:news_application/sources/data/models/source.dart';

class SourceState {}

class InitialState extends SourceState {}

class GetSourceLoading extends SourceState {}

class GetSourceSuccess extends SourceState {
  List<Source> sources;
  GetSourceSuccess(this.sources);
}

class GetSourceError extends SourceState {
  String message;
  GetSourceError(this.message);
}
