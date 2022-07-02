import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/recipe_entity.dart';
import 'package:yess_nutrition/domain/repositories/recipe_repository.dart';

class SearchRecipes {
  final RecipeRepository _repository;

  SearchRecipes(this._repository);

  Future<Either<Failure, List<RecipeEntity>>> execute(String query) {
    return _repository.searchRecipes(query);
  }
}
