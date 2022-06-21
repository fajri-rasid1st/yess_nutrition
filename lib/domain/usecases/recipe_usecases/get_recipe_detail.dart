import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/recipe_detail_entity.dart';
import 'package:yess_nutrition/domain/repositories/recipe_repository.dart';

class GetRecipeDetail {
  final RecipeRepository _repository;

  GetRecipeDetail(this._repository);

  Future<Either<Failure, RecipeDetailEntity>> execute(String recipeId) {
    return _repository.getRecipeDetail(recipeId);
  }
}
