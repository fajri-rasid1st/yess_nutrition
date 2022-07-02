import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/data/datasources/user_datasources/user_firestore_data_source.dart';
import 'package:yess_nutrition/data/models/user_models/user_data_model.dart';
import 'package:yess_nutrition/data/models/user_models/user_food_schedule_model.dart';
import 'package:yess_nutrition/data/models/user_models/user_nutrients_model.dart';
import 'package:yess_nutrition/domain/entities/user_data_entity.dart';
import 'package:yess_nutrition/domain/entities/user_food_schedule_entity.dart';
import 'package:yess_nutrition/domain/entities/user_nutrients_entity.dart';
import 'package:yess_nutrition/domain/repositories/user_firestore_repository.dart';

class UserFirestoreRepositoryImpl implements UserFirestoreRepository {
  final UserFirestoreDataSource userFirestoreDataSource;

  UserFirestoreRepositoryImpl({required this.userFirestoreDataSource});

  /*
  * User Data Firestore Repository Implements
  */
  @override
  Future<Either<Failure, void>> createUserData(UserDataEntity userData) async {
    try {
      final userDataModel = UserDataModel.fromEntity(userData);

      final result =
          await userFirestoreDataSource.createUserData(userDataModel);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('Oops, terjadi kesalahan'));
    }
  }

  @override
  Future<Either<Failure, UserDataEntity>> readUserData(String uid) async {
    try {
      final result = await userFirestoreDataSource.readUserData(uid);

      return Right(result.toEntity());
    } on FirestoreException {
      return const Left(FirestoreFailure('Oops, terjadi kesalahan'));
    }
  }

  @override
  Future<Either<Failure, void>> updateUserData(UserDataEntity userData) async {
    try {
      final userDataModel = UserDataModel.fromEntity(userData);

      final result =
          await userFirestoreDataSource.updateUserData(userDataModel);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('Oops, terjadi kesalahan'));
    }
  }

  @override
  Future<Either<Failure, bool>> isNewUser(String uid) async {
    try {
      final result = await userFirestoreDataSource.isNewUser(uid);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('Oops, terjadi kesalahan'));
    }
  }

  /*
  * User Nutrients Firestore Repository Implements
  */
  @override
  Future<Either<Failure, String>> createUserNutrients(
      UserNutrientsEntity userNutrients) async {
    try {
      final model = UserNutrientsModel.fromEntity(userNutrients);

      final result = await userFirestoreDataSource.createUserNutrients(model);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('Oops, terjadi kesalahan'));
    }
  }

  @override
  Future<Either<Failure, UserNutrientsEntity?>> readUserNutrients(
      String uid) async {
    try {
      final result = await userFirestoreDataSource.readUserNutrients(uid);

      return Right(result?.toEntity());
    } on FirestoreException {
      return const Left(FirestoreFailure('Oops, terjadi kesalahan'));
    }
  }

  @override
  Future<Either<Failure, String>> updateUserNutrients(
      UserNutrientsEntity userNutrients) async {
    try {
      final model = UserNutrientsModel.fromEntity(userNutrients);

      final result = await userFirestoreDataSource.updateUserNutrients(model);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('Oops, terjadi kesalahan'));
    }
  }

  /*
  * User Food Schedule Firestore Repository Implements
  */
  @override
  Future<Either<Failure, String>> createUserFoodSchedule(
      UserFoodScheduleEntity schedule) async {
    try {
      final model = UserFoodScheduleModel.fromEntity(schedule);

      final result =
          await userFirestoreDataSource.createUserFoodSchedule(model);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('Oops, terjadi kesalahan'));
    }
  }

  @override
  Future<Either<Failure, List<UserFoodScheduleEntity>>> readUserFoodSchedules(
      String uid) async {
    try {
      final result = await userFirestoreDataSource.readUserFoodSchedules(uid);

      return Right(result.map((model) => model.toEntity()).toList());
    } on FirestoreException {
      return const Left(FirestoreFailure('Oops, terjadi kesalahan'));
    }
  }

  @override
  Future<Either<Failure, String>> updateUserFoodSchedule(
      UserFoodScheduleEntity schedule) async {
    try {
      final model = UserFoodScheduleModel.fromEntity(schedule);

      final result =
          await userFirestoreDataSource.updateUserFoodSchedule(model);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('Oops, terjadi kesalahan'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteUserFoodSchedule(
      UserFoodScheduleEntity schedule) async {
    try {
      final model = UserFoodScheduleModel.fromEntity(schedule);

      final result =
          await userFirestoreDataSource.deleteUserFoodSchedule(model);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('Oops, terjadi kesalahan'));
    }
  }

  @override
  Future<Either<Failure, String>> resetUserFoodSchedules(String uid) async {
    try {
      final result = await userFirestoreDataSource.resetUserFoodSchedules(uid);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('Oops, terjadi kesalahan'));
    }
  }
}
