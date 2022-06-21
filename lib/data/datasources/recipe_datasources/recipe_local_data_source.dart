import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/data/datasources/database/database_helper.dart';
import 'package:yess_nutrition/data/models/recipe_models/recipe_table.dart';

abstract class RecipeLocalDataSource {
  Future<String> createRecipeBookmark(RecipeTable recipe);

  Future<List<RecipeTable>> getRecipeBookmarks(String uid);

  Future<String> deleteRecipeBookmark(RecipeTable recipe);

  Future<String> clearRecipeBookmarks(String uid);

  Future<bool> isRecipeBookmarkExist(RecipeTable recipe);
}

class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  final DatabaseHelper databaseHelper;

  RecipeLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> createRecipeBookmark(RecipeTable recipe) async {
    try {
      await databaseHelper.createRecipeBookmark(recipe);

      return 'Resep ditambahkan ke Bookmarks.';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<RecipeTable>> getRecipeBookmarks(String uid) async {
    try {
      final bookmarks = await databaseHelper.getRecipeBookmarks(uid);

      return bookmarks;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> deleteRecipeBookmark(RecipeTable recipe) async {
    try {
      await databaseHelper.deleteRecipeBookmark(recipe);

      return 'Resep dihapus dari Bookmarks.';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> clearRecipeBookmarks(String uid) async {
    try {
      await databaseHelper.clearRecipeBookmarks(uid);

      return 'Semua resep berhasil dihapus.';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<bool> isRecipeBookmarkExist(RecipeTable recipe) async {
    try {
      final isExist = await databaseHelper.isRecipeBookmarkExist(recipe);

      return isExist;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
