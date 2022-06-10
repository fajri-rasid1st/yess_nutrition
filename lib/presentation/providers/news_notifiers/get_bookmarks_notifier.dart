import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/get_bookmarks.dart';

class GetBookmarksNotifier extends ChangeNotifier {
  final GetBookmarks getBookmarksUseCase;

  GetBookmarksNotifier({required this.getBookmarksUseCase});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  late List<NewsEntity> _bookmarks;
  List<NewsEntity> get bookmarks => _bookmarks;

  String _message = '';
  String get message => _message;

  Future<void> getBookmarks() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getBookmarksUseCase.execute();

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
        notifyListeners();
      },
      (bookmarks) {
        _bookmarks = bookmarks;
        _state = RequestState.success;
        notifyListeners();
      },
    );
  }
}