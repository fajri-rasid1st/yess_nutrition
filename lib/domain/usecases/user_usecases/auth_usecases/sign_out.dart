import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/repositories/user_auth_repository.dart';

class SignOut {
  final UserAuthRepository _repository;

  SignOut(this._repository);

  Future<Either<AuthFailure, void>> execute() {
    return _repository.signOut();
  }
}
