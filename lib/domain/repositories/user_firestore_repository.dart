import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';

abstract class UserFirestoreRepository {
  Future<Either<FirestoreFailure, void>> createUserData(UserEntity user);

  Either<FirestoreFailure, Stream<UserEntity>> readUserData(String uid);
}
