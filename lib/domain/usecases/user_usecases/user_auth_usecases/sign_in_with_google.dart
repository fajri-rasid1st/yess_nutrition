import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/domain/repositories/user_auth_repository.dart';

class SignInWithGoogle {
  final UserAuthRepository _repository;

  SignInWithGoogle(this._repository);

  Future<Either<Failure, UserEntity?>> execute() {
    return _repository.signInWithGoogle();
  }
}
