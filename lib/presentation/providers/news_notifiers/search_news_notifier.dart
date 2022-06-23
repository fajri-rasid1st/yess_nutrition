import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/search_news.dart';

class SearchNewsNotifier extends ChangeNotifier {
  final SearchNews searchNewsUseCase;

  SearchNewsNotifier({required this.searchNewsUseCase});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  List<NewsEntity> _results = <NewsEntity>[];
  List<NewsEntity> get results => _results;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasMoreData = false;
  bool get hasMoreData => _hasMoreData;

  bool _isReload = false;
  bool get isReload => _isReload;

  set isReload(bool value) {
    _isReload = value;
    notifyListeners();
  }

  String _onChangedQuery = '';
  String get onChangedQuery => _onChangedQuery;

  set onChangedQuery(String value) {
    _onChangedQuery = value;
    notifyListeners();
  }

  String _onSubmittedQuery = '';
  String get onSubmittedQuery => _onSubmittedQuery;

  int _currentPageLoad = 0;

  Future<void> searchNews({required int page, required String query}) async {
    _onSubmittedQuery = query;

    _state = RequestState.loading;
    notifyListeners();

    final result = await searchNewsUseCase.execute(10, page, query);

    _currentPageLoad = page;

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (results) {
        if (results.isNotEmpty) {
          _hasMoreData = true;
        }

        _results = results;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }

  Future<void> searchMoreNews() async {
    _currentPageLoad++;

    _isLoading = true;

    final result = await searchNewsUseCase.execute(
      10,
      _currentPageLoad,
      _onSubmittedQuery,
    );

    _isLoading = false;

    result.fold(
      (_) {
        _hasMoreData = false;
      },
      (results) {
        if (results.isEmpty) {
          _hasMoreData = false;
        } else {
          _results.addAll(results);
        }
      },
    );

    notifyListeners();
  }

  Future<void> refresh() async {
    final result = await searchNewsUseCase.execute(
      10,
      _currentPageLoad,
      _onSubmittedQuery,
    );

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (results) {
        if (results.isNotEmpty) {
          _hasMoreData = true;
        }

        _results = results;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }
}
