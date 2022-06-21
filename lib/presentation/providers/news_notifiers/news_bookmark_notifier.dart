import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/clear_bookmarks.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/create_bookmark.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/delete_bookmark.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/get_bookmark_status.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/get_bookmarks.dart';

class NewsBookmarkNotifier extends ChangeNotifier {
  final CreateBookmark createBookmarkUseCase;
  final DeleteBookmark deleteBookmarkUseCase;
  final GetBookmarkStatus getBookmarkStatusUseCase;
  final GetBookmarks getBookmarksUseCase;
  final ClearBookmarks clearBookmarksUseCase;

  NewsBookmarkNotifier({
    required this.createBookmarkUseCase,
    required this.deleteBookmarkUseCase,
    required this.getBookmarkStatusUseCase,
    required this.getBookmarksUseCase,
    required this.clearBookmarksUseCase,
  });

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  bool _isExist = false;
  bool get isExist => _isExist;

  List<NewsEntity> _bookmarks = <NewsEntity>[];
  List<NewsEntity> get bookmarks => _bookmarks;

  Future<void> createBookmark(NewsEntity news) async {
    final result = await createBookmarkUseCase.execute(news);

    result.fold(
      (failure) => _message = failure.message,
      (success) => _message = success,
    );

    await getBookmarkStatus(news);
  }

  Future<void> deleteBookmark(NewsEntity news) async {
    final result = await deleteBookmarkUseCase.execute(news);

    result.fold(
      (failure) => _message = failure.message,
      (success) => _message = success,
    );

    await getBookmarkStatus(news);
  }

  Future<void> getBookmarkStatus(NewsEntity news) async {
    final result = await getBookmarkStatusUseCase.execute(news);

    result.fold(
      (failure) => _message = failure.message,
      (isExist) => _isExist = isExist,
    );

    notifyListeners();
  }

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
