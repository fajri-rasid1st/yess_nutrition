import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';
import 'package:yess_nutrition/domain/repositories/food_repository.dart';

class SearchFoods {
  final FoodRepository _repository;

  SearchFoods(this._repository);

  Future<Either<Failure, Map<String, List<FoodEntity>>>> execute(String query) {
    return _repository.searchFoods(query);
  }
}
