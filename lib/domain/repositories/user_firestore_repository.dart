import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/user_data_entity.dart';
import 'package:yess_nutrition/domain/entities/user_nutrients_entity.dart';

abstract class UserFirestoreRepository {
  Future<Either<Failure, void>> createUserData(UserDataEntity userData);

  Future<Either<Failure, UserDataEntity>> readUserData(String uid);

  Future<Either<Failure, void>> updateUserData(UserDataEntity userData);

  Future<Either<Failure, bool>> isNewUser(String uid);

  Future<Either<Failure, String>> createUserNutrients(
      UserNutrientsEntity userNutrients);

  Future<Either<Failure, UserNutrientsEntity?>> readUserNutrients(String uid);

  Future<Either<Failure, String>> updateUserNutrients(
      UserNutrientsEntity userNutrients);
}
