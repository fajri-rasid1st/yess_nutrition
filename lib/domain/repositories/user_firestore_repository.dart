import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/user_data_entity.dart';
import 'package:yess_nutrition/domain/entities/user_food_schedule_entity.dart';
import 'package:yess_nutrition/domain/entities/user_nutrients_entity.dart';

abstract class UserFirestoreRepository {
  /*
  * User Data Firestore Repository
  */
  Future<Either<Failure, void>> createUserData(UserDataEntity userData);

  Future<Either<Failure, UserDataEntity>> readUserData(String uid);

  Future<Either<Failure, void>> updateUserData(UserDataEntity userData);

  Future<Either<Failure, bool>> isNewUser(String uid);

  /*
  * User Nutrients Firestore Repository
  */
  Future<Either<Failure, String>> createUserNutrients(
      UserNutrientsEntity userNutrients);

  Future<Either<Failure, UserNutrientsEntity?>> readUserNutrients(String uid);

  Future<Either<Failure, String>> updateUserNutrients(
      UserNutrientsEntity userNutrients);

  /*
  * User Food Schedule Firestore Repository
  */
  Future<Either<Failure, String>> createUserFoodSchedule(
      UserFoodScheduleEntity schedule);

  Future<Either<Failure, List<UserFoodScheduleEntity>>> readUserFoodSchedules(
      String uid);

  Future<Either<Failure, String>> updateUserFoodSchedule(
      UserFoodScheduleEntity schedule);

  Future<Either<Failure, String>> deleteUserFoodSchedule(
      UserFoodScheduleEntity schedule);

  Future<Either<Failure, String>> resetUserFoodSchedules(String uid);
}
