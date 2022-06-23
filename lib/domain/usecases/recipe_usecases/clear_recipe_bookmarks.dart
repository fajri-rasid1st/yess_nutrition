import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/repositories/recipe_repository.dart';

class ClearRecipeBookmarks {
  final RecipeRepository _repository;

  ClearRecipeBookmarks(this._repository);

  Future<Either<Failure, String>> execute(String uid) {
    return _repository.clearRecipeBookmarks(uid);
  }
}
