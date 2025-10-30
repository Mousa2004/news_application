// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../news/data/data_sources/local/news_local_data_sources.dart'
    as _i720;
import '../../../news/data/data_sources/local/news_local_data_sources_impl.dart'
    as _i67;
import '../../../news/data/data_sources/remote/news_data_sources.dart' as _i944;
import '../../../news/data/data_sources/remote/news_data_sources_impl.dart'
    as _i367;
import '../../../news/data/repositories/news_repository.dart' as _i710;
import '../../../news/data/repositories/news_repository_impl.dart' as _i234;
import '../../../news/view_model/news_view_model_news.dart' as _i665;
import '../../../sources/data/data_sources/local/source_local_data_sources.dart'
    as _i559;
import '../../../sources/data/data_sources/local/source_local_data_sources_impl.dart'
    as _i676;
import '../../../sources/data/data_sources/remote/source_data_sources_impl.dart'
    as _i62;
import '../../../sources/data/data_sources/remote/sources_data_sources.dart'
    as _i28;
import '../../../sources/data/repositories/source_repository.dart' as _i251;
import '../../../sources/data/repositories/source_repository_impl.dart'
    as _i968;
import '../../../sources/view_models/source_view_model_sources.dart' as _i1042;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i720.NewsLocalDataSources>(
        () => _i67.NewsLocalDataSourcesImpl());
    gh.singleton<_i28.SourcesDataSources>(() => _i62.SourceDataSourcesImpl());
    gh.singleton<_i559.SourceLocalDataSources>(
        () => _i676.SourceLocalDataSourcesImpl());
    gh.singleton<_i944.NewsDataSources>(() => _i367.NewsDataSourcesImpl());
    gh.factory<_i251.SourceRepository>(() => _i968.SourceRepositoryImpl(
          gh<_i28.SourcesDataSources>(),
          gh<_i559.SourceLocalDataSources>(),
        ));
    gh.factory<_i710.NewsRepository>(() => _i234.NewsRepositoryImpl(
          gh<_i944.NewsDataSources>(),
          gh<_i720.NewsLocalDataSources>(),
        ));
    gh.factory<_i1042.SourceViewModelSources>(
        () => _i1042.SourceViewModelSources(gh<_i251.SourceRepository>()));
    gh.factory<_i665.NewsViewModelNews>(
        () => _i665.NewsViewModelNews(gh<_i710.NewsRepository>()));
    return this;
  }
}
