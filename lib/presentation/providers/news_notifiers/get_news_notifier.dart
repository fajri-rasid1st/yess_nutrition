import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/get_news.dart';

class GetNewsNotifier extends ChangeNotifier {
  final GetNews getNewsUseCase;

  GetNewsNotifier({required this.getNewsUseCase});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  List<NewsEntity> _news = <NewsEntity>[];
  List<NewsEntity> get news => _news;

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

  int _currentPageLoad = 0;

  Future<void> getNews({required int page}) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getNewsUseCase.execute(10, page);

    _currentPageLoad = page;

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (news) {
        _news = news;
        _hasMoreData = true;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }

  Future<void> getNewsByCount({required int count}) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getNewsUseCase.execute(count, 1);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (news) {
        _news = news;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }

  Future<void> getMoreNews() async {
    _currentPageLoad++;

    _isLoading = true;

    final result = await getNewsUseCase.execute(10, _currentPageLoad);

    _isLoading = false;

    result.fold(
      (_) {
        _hasMoreData = false;
      },
      (news) {
        if (news.isEmpty) {
          _hasMoreData = false;
        } else {
          _news.addAll(news);
        }
      },
    );

    notifyListeners();
  }

  Future<void> refresh() async {
    final result = await getNewsUseCase.execute(10, _currentPageLoad);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (news) {
        _news = news;
        _hasMoreData = true;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }
}
