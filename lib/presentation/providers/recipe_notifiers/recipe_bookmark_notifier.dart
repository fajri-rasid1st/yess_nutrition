import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/recipe_entity.dart';
import 'package:yess_nutrition/domain/usecases/recipe_usecases/clear_recipe_bookmarks.dart';
import 'package:yess_nutrition/domain/usecases/recipe_usecases/create_recipe_bookmark.dart';
import 'package:yess_nutrition/domain/usecases/recipe_usecases/delete_recipe_bookmark.dart';
import 'package:yess_nutrition/domain/usecases/recipe_usecases/get_recipe_bookmark_status.dart';
import 'package:yess_nutrition/domain/usecases/recipe_usecases/get_recipe_bookmarks.dart';

class RecipeBookmarkNotifier extends ChangeNotifier {
  final CreateRecipeBookmark createRecipeBookmarkUseCase;
  final DeleteRecipeBookmark deleteRecipeBookmarkUseCase;
  final GetRecipeBookmarkStatus getRecipeBookmarkStatusUseCase;
  final GetRecipeBookmarks getRecipeBookmarksUseCase;
  final ClearRecipeBookmarks clearRecipeBookmarksUseCase;

  RecipeBookmarkNotifier({
    required this.createRecipeBookmarkUseCase,
    required this.deleteRecipeBookmarkUseCase,
    required this.getRecipeBookmarkStatusUseCase,
    required this.getRecipeBookmarksUseCase,
    required this.clearRecipeBookmarksUseCase,
  });

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  bool _isExist = false;
  bool get isExist => _isExist;

  List<RecipeEntity> _bookmarks = <RecipeEntity>[];
  List<RecipeEntity> get bookmarks => _bookmarks;

  Future<void> createRecipeBookmark(RecipeEntity recipe) async {
    final result = await createRecipeBookmarkUseCase.execute(recipe);

    result.fold(
      (failure) => _message = failure.message,
      (success) => _message = success,
    );

    await getRecipeBookmarkStatus(recipe);
  }

  Future<void> deleteRecipeBookmark(RecipeEntity recipe) async {
    final result = await deleteRecipeBookmarkUseCase.execute(recipe);

    result.fold(
      (failure) => _message = failure.message,
      (success) => _message = success,
    );

    await getRecipeBookmarkStatus(recipe);
  }

  Future<void> getRecipeBookmarkStatus(RecipeEntity recipe) async {
    final result = await getRecipeBookmarkStatusUseCase.execute(recipe);

    result.fold(
      (failure) => _message = failure.message,
      (isExist) => _isExist = isExist,
    );

    notifyListeners();
  }

  Future<void> getRecipeBookmarks(String uid) async {
    final result = await getRecipeBookmarksUseCase.execute(uid);

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

  Future<void> clearRecipeBookmarks(String uid) async {
    final result = await clearRecipeBookmarksUseCase.execute(uid);

    result.fold(
      (failure) => _message = failure.message,
      (success) => _message = success,
    );

    notifyListeners();
  }
}
