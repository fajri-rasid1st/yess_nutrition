import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/user_nutrients_entity.dart';
import 'package:yess_nutrition/domain/repositories/user_firestore_repository.dart';

class CreateUserNutrients {
  final UserFirestoreRepository _repository;

  CreateUserNutrients(this._repository);

  Future<Either<Failure, String>> execute(UserNutrientsEntity userNutrients) {
    return _repository.createUserNutrients(userNutrients);
  }
}
