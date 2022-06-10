import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/repositories/user_auth_repository.dart';

class ResetPassword {
  final UserAuthRepository _repository;

  ResetPassword(this._repository);

  Future<Either<AuthFailure, void>> execute(String email) {
    return _repository.resetPassword(email);
  }
}
