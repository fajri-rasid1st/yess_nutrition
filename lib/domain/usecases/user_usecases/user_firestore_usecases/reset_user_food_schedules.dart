import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/repositories/user_firestore_repository.dart';

class ResetUserFoodSchedules {
  final UserFirestoreRepository _repository;

  ResetUserFoodSchedules(this._repository);

  Future<Either<Failure, String>> execute(String uid) {
    return _repository.resetUserFoodSchedules(uid);
  }
}
