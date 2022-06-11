import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/repositories/user_firestore_repository.dart';

class DeleteUserData {
  final UserFirestoreRepository _repository;

  DeleteUserData(this._repository);

  Future<Either<FirestoreFailure, void>> execute(String uid) {
    return _repository.deleteUserData(uid);
  }
}
