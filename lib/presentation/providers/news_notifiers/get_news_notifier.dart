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

  int _currentPageLoad = 0;
  int get currentPageLoad => _currentPageLoad;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _hasMoreData = true;
  bool get hasMoreData => _hasMoreData;

  Future<void> getNews({required int page}) async {
    _state = RequestState.loading;
     notifyListeners();

    final result = await getNewsUseCase.execute(10, page);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (news) {
        _news = news;
        _currentPageLoad = page;
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
}
