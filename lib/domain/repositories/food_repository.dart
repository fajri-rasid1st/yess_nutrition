import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';

abstract class FoodRepository {
  Future<Either<Failure, void>> addFoodHistory(FoodEntity food);

  Future<Either<Failure, List<FoodEntity>>> getFoodHistories(String uid);

  Future<Either<Failure, String>> deleteFoodHistory(FoodEntity food);

  Future<Either<Failure, String>> clearFoodHistories(String uid);

  Future<Either<Failure, Map<String, List<FoodEntity>>>> searchFoods(
      String query);
}
