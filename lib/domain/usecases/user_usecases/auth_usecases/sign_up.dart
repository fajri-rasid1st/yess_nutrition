import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/domain/repositories/user_auth_repository.dart';

class SignUp {
  final UserAuthRepository _repository;

  SignUp(this._repository);

  Future<Either<AuthFailure, UserEntity>> execute(
    String email,
    String password,
  ) {
    return _repository.signUp(email, password);
  }
}
