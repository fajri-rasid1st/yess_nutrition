import 'package:flutter/material.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/create_bookmark.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/delete_bookmark.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/get_bookmark_status.dart';

class BookmarkNotifier extends ChangeNotifier {
  final CreateBookmark createBookmarkUseCase;
  final DeleteBookmark deleteBookmarkUseCase;
  final GetBookmarkStatus getBookmarkStatusUseCase;

  BookmarkNotifier({
    required this.createBookmarkUseCase,
    required this.deleteBookmarkUseCase,
    required this.getBookmarkStatusUseCase,
  });

  String _message = '';
  String get message => _message;

  bool _isExist = false;
  bool get isExist => _isExist;

  Future<void> createBookmark(NewsEntity movie) async {
    final result = await createBookmarkUseCase.execute(movie);

    result.fold(
      (failure) => _message = failure.message,
      (success) => _message = success,
    );

    await getBookmarkStatus(movie);
  }

  Future<void> deleteBookmark(NewsEntity movie) async {
    final result = await deleteBookmarkUseCase.execute(movie);

    result.fold(
      (failure) => _message = failure.message,
      (success) => _message = success,
    );

    await getBookmarkStatus(movie);
  }

  Future<void> getBookmarkStatus(NewsEntity movie) async {
    final result = await getBookmarkStatusUseCase.execute(movie);

    result.fold(
      (failure) => _message = failure.message,
      (isExist) => _isExist = isExist,
    );

    notifyListeners();
  }
}
