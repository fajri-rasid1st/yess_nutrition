import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/user_data_entity.dart';

abstract class UserFirestoreRepository {
  Future<Either<Failure, void>> createUserData(UserDataEntity userData);

  Future<Either<Failure, UserDataEntity>> readUserData(String uid);

  Future<Either<Failure, void>> updateUserData(UserDataEntity userData);

  Future<Either<Failure, void>> deleteUserData(String uid);

  Future<Either<Failure, bool>> isNewUser(String uid);
}
