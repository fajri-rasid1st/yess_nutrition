import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/recipe_entity.dart';
import 'package:yess_nutrition/domain/repositories/recipe_repository.dart';

class GetRecipeBookmarks {
  final RecipeRepository _repository;

  GetRecipeBookmarks(this._repository);

  Future<Either<Failure, List<RecipeEntity>>> execute(String uid) {
    return _repository.getRecipeBookmarks(uid);
  }
}
