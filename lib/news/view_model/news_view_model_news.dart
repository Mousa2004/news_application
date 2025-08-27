import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/news/data/models/article.dart';
import 'package:news_application/news/data/repositories/news_repository.dart';
import 'package:news_application/news/view_model/news_state.dart';
import 'package:news_application/shared/view/widget/service_locator.dart';

class NewsViewModelNews extends Cubit<NewsState> {
  NewsViewModelNews() : super(InitialState());
  NewsRepository newsDataSources = NewsRepository(
    ServiceLocator.newsDataSources,
  );
  List<News> newsList = [];

  Future<void> getNews(String newsId, int page, int pageSize) async {
    if (page == 1) {
      emit(GetNewsLoading());
    } else {
      emit(GetNewsPaginationLoading());
    }

    try {
      if (page == 1) newsList.clear();
      final newData = await newsDataSources.getNews(newsId, page, pageSize);

      newsList.addAll(newData);

      emit(GetNewsSuccess(List.from(newsList)));
    } catch (error) {
      emit(GetNewsError(error.toString()));
    }
  }

  void clearNews() {
    newsList.clear();
  }

  Future<void> searchNews(String query) async {
    emit(GetNewsLoading());

    try {
      List<News> searchNewsList = await newsDataSources.searchNews(query);
      emit(GetSearchNewsSuccess(searchNewsList));
    } catch (error) {
      emit(GetNewsError(error.toString()));
    }
  }
}
