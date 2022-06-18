import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';

abstract class UserAuthRepository {
  Either<Failure, Stream<UserEntity?>> getUser();

  Future<Either<Failure, UserEntity>> signIn(String email, String password);

  Future<Either<Failure, UserEntity>> signUp(String email, String password);

  Future<Either<Failure, void>> signOut();

  Future<Either<Failure, void>> resetPassword(String email);

  Future<Either<Failure, void>> deleteUser();

  Future<Either<Failure, UserEntity?>> signInWithGoogle();
}
