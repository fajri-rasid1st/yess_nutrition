import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';

abstract class UserAuthRepository {
  Either<AuthFailure, Stream<UserEntity?>> getUser();

  Future<Either<AuthFailure, UserEntity>> signIn(String email, String password);

  Future<Either<AuthFailure, UserEntity>> signUp(String email, String password);

  Future<Either<AuthFailure, void>> signOut();

  Future<Either<AuthFailure, void>> resetPassword(String email);

  Future<Either<AuthFailure, void>> deleteUser();
}
