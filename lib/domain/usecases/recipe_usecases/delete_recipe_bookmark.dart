import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/recipe_entity.dart';
import 'package:yess_nutrition/domain/repositories/recipe_repository.dart';

class DeleteRecipeBookmark {
  final RecipeRepository _repository;

  DeleteRecipeBookmark(this._repository);

  Future<Either<Failure, String>> execute(RecipeEntity recipe) {
    return _repository.deleteRecipeBookmark(recipe);
  }
}
