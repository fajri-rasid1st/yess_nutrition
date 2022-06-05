import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/data/datasources/user_firestore_data_source.dart';
import 'package:yess_nutrition/data/models/user_model.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/domain/repositories/user_firestore_repository.dart';

class UserFirestoreRepositoryImpl implements UserFirestoreRepository {
  final UserFirestoreDataSource userFirestoreDataSource;

  UserFirestoreRepositoryImpl({required this.userFirestoreDataSource});

  @override
  Future<Either<FirestoreFailure, void>> createUserData(UserEntity user) async {
    try {
      final userModel = UserModel.fromEntity(user);

      final result = await userFirestoreDataSource.createUserData(userModel);

      return Right(result);
    } on FirestoreException catch (e) {
      return Left(FirestoreFailure(e.message));
    }
  }

  @override
  Either<FirestoreFailure, Stream<UserEntity>> readUserData(String uid) {
    try {
      final userStream = userFirestoreDataSource.readUserData(uid);

      final result = userStream.map((user) => user.toEntity());

      return Right(result);
    } on FirestoreException catch (e) {
      return Left(FirestoreFailure(e.message));
    }
  }
}
