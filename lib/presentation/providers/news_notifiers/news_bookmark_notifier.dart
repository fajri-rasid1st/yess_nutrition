import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/clear_news_bookmarks.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/create_news_bookmark.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/delete_news_bookmark.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/get_news_bookmark_status.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/get_news_bookmarks.dart';

class NewsBookmarkNotifier extends ChangeNotifier {
  final CreateNewsBookmark createNewsBookmarkUseCase;
  final DeleteNewsBookmark deleteNewsBookmarkUseCase;
  final GetNewsBookmarkStatus getNewsBookmarkStatusUseCase;
  final GetNewsBookmarks getNewsBookmarksUseCase;
  final ClearNewsBookmarks clearNewsBookmarksUseCase;

  NewsBookmarkNotifier({
    required this.createNewsBookmarkUseCase,
    required this.deleteNewsBookmarkUseCase,
    required this.getNewsBookmarkStatusUseCase,
    required this.getNewsBookmarksUseCase,
    required this.clearNewsBookmarksUseCase,
  });

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  bool _isExist = false;
  bool get isExist => _isExist;

  List<NewsEntity> _bookmarks = <NewsEntity>[];
  List<NewsEntity> get bookmarks => _bookmarks;

  Future<void> createNewsBookmark(NewsEntity news) async {
    final result = await createNewsBookmarkUseCase.execute(news);

    result.fold(
      (failure) => _message = failure.message,
      (success) => _message = success,
    );

    await getNewsBookmarkStatus(news);
  }

  Future<void> deleteNewsBookmark(NewsEntity news) async {
    final result = await deleteNewsBookmarkUseCase.execute(news);

    result.fold(
      (failure) => _message = failure.message,
      (success) => _message = success,
    );

    await getNewsBookmarkStatus(news);
  }

  Future<void> getNewsBookmarkStatus(NewsEntity news) async {
    final result = await getNewsBookmarkStatusUseCase.execute(news);

    result.fold(
      (failure) => _message = failure.message,
      (isExist) => _isExist = isExist,
    );

    notifyListeners();
  }

  Future<void> getNewsBookmarks(String uid) async {
    final result = await getNewsBookmarksUseCase.execute(uid);

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

  Future<void> clearNewsBookmarks(String uid) async {
    final result = await clearNewsBookmarksUseCase.execute(uid);

    result.fold(
      (failure) => _message = failure.message,
      (success) => _message = success,
    );

    notifyListeners();
  }
}
