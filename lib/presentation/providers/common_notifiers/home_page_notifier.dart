import 'package:flutter/cupertino.dart';
import 'package:yess_nutrition/common/utils/utils.dart';
import 'package:yess_nutrition/domain/entities/entities.dart';
import 'package:yess_nutrition/domain/usecases/usecases.dart';

class HomePageNotifier extends ChangeNotifier {
  final GetNews getNewsUseCase;

  HomePageNotifier({required this.getNewsUseCase});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  List<NewsEntity> _news = <NewsEntity>[];
  List<NewsEntity> get news => _news;

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
}
