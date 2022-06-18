import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';

abstract class FoodRepository {
  Future<Either<Failure, Map<String, List<FoodEntity>>>> searchFoods(
      String query);
}
