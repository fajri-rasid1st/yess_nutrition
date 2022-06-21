import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/recipe_detail_entity.dart';
import 'package:yess_nutrition/domain/entities/recipe_entity.dart';

abstract class RecipeRepository {
  Future<Either<Failure, String>> createRecipeBookmark(RecipeEntity recipe);

  Future<Either<Failure, List<RecipeEntity>>> getRecipeBookmarks(String uid);

  Future<Either<Failure, String>> deleteRecipeBookmark(RecipeEntity recipe);

  Future<Either<Failure, String>> clearRecipeBookmarks(String uid);

  Future<Either<Failure, bool>> isRecipeBookmarkExist(RecipeEntity recipe);

  Future<Either<Failure, List<RecipeEntity>>> searchRecipes(String query);

  Future<Either<Failure, RecipeDetailEntity>> getRecipeDetail(String recipeId);
}
