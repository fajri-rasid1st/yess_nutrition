import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/data/datasources/user_firestore_data_source.dart';
import 'package:yess_nutrition/data/models/user_data_model.dart';
import 'package:yess_nutrition/domain/entities/user_data_entity.dart';
import 'package:yess_nutrition/domain/repositories/user_firestore_repository.dart';

class UserFirestoreRepositoryImpl implements UserFirestoreRepository {
  final UserFirestoreDataSource userFirestoreDataSource;

  UserFirestoreRepositoryImpl({required this.userFirestoreDataSource});

  @override
  Future<Either<FirestoreFailure, void>> createUserData(
      UserDataEntity userData) async {
    try {
      final userDataModel = UserDataModel.fromEntity(userData);

      final result =
          await userFirestoreDataSource.createUserData(userDataModel);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('Terjadi kesalahan. Coba lagi.'));
    }
  }

  @override
  Future<Either<FirestoreFailure, UserDataEntity>> readUserData(
      String uid) async {
    try {
      final result = await userFirestoreDataSource.readUserData(uid);

      return Right(result.toEntity());
    } on FirestoreException {
      return const Left(FirestoreFailure('Terjadi kesalahan. Coba lagi.'));
    }
  }

  @override
  Future<Either<FirestoreFailure, void>> updateUserData(
      UserDataEntity userData) async {
    try {
      final userDataModel = UserDataModel.fromEntity(userData);

      final result =
          await userFirestoreDataSource.updateUserData(userDataModel);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('Terjadi kesalahan. Coba lagi.'));
    }
  }

  @override
  Future<Either<FirestoreFailure, void>> deleteUserData(String uid) async {
    try {
      final result = await userFirestoreDataSource.deleteUserData(uid);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('Terjadi kesalahan. Coba lagi.'));
    }
  }
}
