import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/user_data_entity.dart';

abstract class UserFirestoreRepository {
  Future<Either<FirestoreFailure, void>> createUserData(
      UserDataEntity userData);

  Future<Either<FirestoreFailure, UserDataEntity>> readUserData(String uid);

  Future<Either<FirestoreFailure, void>> updateUserData(
      UserDataEntity userData);

  Future<Either<FirestoreFailure, void>> deleteUserData(String uid);

  Future<Either<FirestoreFailure, bool>> isNewUser(String uid);
}
