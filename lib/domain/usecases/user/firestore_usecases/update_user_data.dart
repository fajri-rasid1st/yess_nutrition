import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/user_data_entity.dart';
import 'package:yess_nutrition/domain/repositories/user_firestore_repository.dart';

class UpdateUserData {
  final UserFirestoreRepository _repository;

  UpdateUserData(this._repository);

  Future<Either<FirestoreFailure, void>> execute(UserDataEntity userData) {
    return _repository.updateUserData(userData);
  }
}
