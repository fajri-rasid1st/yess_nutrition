import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:yess_nutrition/data/datasources/user_auth_data_source.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/domain/repositories/user_auth_repository.dart';

class UserAuthRepositoryImpl implements UserAuthRepository {
  final UserAuthDataSource userAuthDataSource;

  UserAuthRepositoryImpl({required this.userAuthDataSource});

  @override
  Either<AuthFailure, Stream<UserEntity?>> getUser() {
    try {
      final result = userAuthDataSource.getUser().map((user) {
        if (user == null) return null;

        return user.toEntity();
      });

      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? e.code));
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> signIn(
    String email,
    String password,
  ) async {
    try {
      final result = await userAuthDataSource.signIn(email, password);

      return Right(result.toEntity());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return const Left(AuthFailure('Email tidak valid'));
        case 'user-not-found':
          return const Left(AuthFailure('Email belum terdaftar'));
        case 'wrong-password':
          return const Left(AuthFailure('Password yang anda masukkan salah'));
        default:
          return Left(AuthFailure(e.message ?? e.code));
      }
    }
  }

  @override
  Future<Either<AuthFailure, UserEntity>> signUp(
    String email,
    String password,
  ) async {
    try {
      final result = await userAuthDataSource.signUp(email, password);

      return Right(result.toEntity());
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return const Left(AuthFailure('Email tidak valid'));
        case 'email-already-in-use':
          return const Left(AuthFailure('Email tersebut telah digunakan'));
        case 'weak-password':
          return const Left(AuthFailure('Password tidak valid'));
        default:
          return Left(AuthFailure(e.message ?? e.code));
      }
    }
  }

  @override
  Future<Either<AuthFailure, void>> signOut() async {
    try {
      final result = await userAuthDataSource.signOut();

      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? e.code));
    }
  }

  @override
  Future<Either<AuthFailure, void>> resetPassword(String email) async {
    try {
      final result = await userAuthDataSource.resetPassword(email);

      return Right(result);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'invalid-email':
          return const Left(AuthFailure('Email tidak valid'));
        case 'user-not-found':
          return const Left(AuthFailure('Email tersebut tidak terdaftar'));
        default:
          return Left(AuthFailure(e.message ?? e.code));
      }
    }
  }

  @override
  Future<Either<AuthFailure, void>> deleteUser() async {
    try {
      final result = await userAuthDataSource.deleteUser();

      return Right(result);
    } on FirebaseAuthException catch (e) {
      return Left(AuthFailure(e.message ?? e.code));
    }
  }
}
