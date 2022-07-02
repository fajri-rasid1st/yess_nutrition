import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/repositories/food_repository.dart';

class ClearFoodHistories {
  final FoodRepository _repository;

  ClearFoodHistories(this._repository);

  Future<Either<Failure, String>> execute(String uid) {
    return _repository.clearFoodHistories(uid);
  }
}
