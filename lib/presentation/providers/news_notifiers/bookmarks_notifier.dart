import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/clear_bookmarks.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/get_bookmarks.dart';

class BookmarksNotifier extends ChangeNotifier {
  final GetBookmarks getBookmarksUseCase;
  final ClearBookmarks clearBookmarksUseCase;

  BookmarksNotifier({
    required this.getBookmarksUseCase,
    required this.clearBookmarksUseCase,
  });

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  List<NewsEntity> _bookmarks = <NewsEntity>[];
  List<NewsEntity> get bookmarks => _bookmarks;

  String _message = '';
  String get message => _message;

  Future<void> getBookmarks(String uid) async {
    final result = await getBookmarksUseCase.execute(uid);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (bookmarks) {
        _bookmarks = bookmarks;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }

  Future<void> clearBookmarks(String uid) async {
    final result = await clearBookmarksUseCase.execute(uid);

    result.fold(
      (failure) => _message = failure.message,
      (success) => _message = success,
    );

    notifyListeners();
  }
}
