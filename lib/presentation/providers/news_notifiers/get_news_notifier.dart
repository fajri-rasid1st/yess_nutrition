import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/get_news.dart';

class GetNewsNotifier extends ChangeNotifier {
  final GetNews getNewsUseCase;

  GetNewsNotifier({required this.getNewsUseCase});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<NewsEntity> _news = <NewsEntity>[];
  List<NewsEntity> get news => _news;

  String _message = '';
  String get message => _message;

  Future<void> getNews(int pageSize, int page) async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getNewsUseCase.execute(pageSize, page);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (news) {
        _news = news;
        _state = RequestState.success;
        notifyListeners();
      },
    );
  }
}
