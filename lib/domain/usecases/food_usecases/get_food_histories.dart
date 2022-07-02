import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';
import 'package:yess_nutrition/domain/repositories/food_repository.dart';

class GetFoodHistories {
  final FoodRepository _repository;

  GetFoodHistories(this._repository);

  Future<Either<Failure, List<FoodEntity>>> execute(String uid) {
    return _repository.getFoodHistories(uid);
  }
}
