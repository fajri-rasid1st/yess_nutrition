import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/user_data_entity.dart';
import 'package:yess_nutrition/domain/repositories/user_firestore_repository.dart';

class CreateUserData {
  final UserFirestoreRepository _repository;

  CreateUserData(this._repository);

  Future<Either<Failure, void>> execute(UserDataEntity userData) {
    return _repository.createUserData(userData);
  }
}
