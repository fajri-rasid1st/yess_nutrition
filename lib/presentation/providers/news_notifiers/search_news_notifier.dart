import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/search_news.dart';

class SearchNewsNotifier extends ChangeNotifier {
  final SearchNews searchNewsUseCase;

  SearchNewsNotifier({required this.searchNewsUseCase});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<NewsEntity> _results = <NewsEntity>[];
  List<NewsEntity> get results => _results;

  String _message = '';
  String get message => _message;

  Future<void> searchNews(int pageSize, int page, String query) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await searchNewsUseCase.execute(pageSize, page, query);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (results) {
        _results = results;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }
}
