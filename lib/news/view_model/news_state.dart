import 'package:news_application/news/data/models/article.dart';

class NewsState {}

class InitialState extends NewsState {}

class GetNewsLoading extends NewsState {}

class GetNewsPaginationLoading extends NewsState {}

class GetNewsSuccess extends NewsState {
  List<News> newsList;

  GetNewsSuccess(this.newsList);
}

class GetSearchNewsSuccess extends NewsState {
  List<News> searchNewsList;
  GetSearchNewsSuccess(this.searchNewsList);
}

class GetNewsError extends NewsState {
  String message;
  GetNewsError(this.message);
}
