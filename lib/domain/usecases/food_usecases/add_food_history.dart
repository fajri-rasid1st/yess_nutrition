import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';
import 'package:yess_nutrition/domain/repositories/food_repository.dart';

class AddFoodHistory {
  final FoodRepository _repository;

  AddFoodHistory(this._repository);

  Future<Either<Failure, void>> execute(FoodEntity food) {
    return _repository.addFoodHistory(food);
  }
}
