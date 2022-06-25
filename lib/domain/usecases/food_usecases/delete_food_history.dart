import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';
import 'package:yess_nutrition/domain/repositories/food_repository.dart';

class DeleteFoodHistory {
  final FoodRepository _repository;

  DeleteFoodHistory(this._repository);

  Future<Either<Failure, String>> execute(FoodEntity food) {
    return _repository.deleteFoodHistory(food);
  }
}
