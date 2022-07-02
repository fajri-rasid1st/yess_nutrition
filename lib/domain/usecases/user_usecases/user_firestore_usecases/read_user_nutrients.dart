import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/user_nutrients_entity.dart';
import 'package:yess_nutrition/domain/repositories/user_firestore_repository.dart';

class ReadUserNutrients {
  final UserFirestoreRepository _repository;

  ReadUserNutrients(this._repository);

  Future<Either<Failure, UserNutrientsEntity?>> execute(String uid) {
    return _repository.readUserNutrients(uid);
  }
}
