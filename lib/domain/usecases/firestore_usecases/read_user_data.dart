import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/domain/repositories/user_firestore_repository.dart';

class ReadUserData {
  final UserFirestoreRepository _repository;

  ReadUserData(this._repository);

  Either<FirestoreFailure, Stream<UserEntity>> execute(String uid) {
    return _repository.readUserData(uid);
  }
}
