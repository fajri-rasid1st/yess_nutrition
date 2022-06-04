import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/repositories/user_auth_repository.dart';

class DeleteUser {
  final UserAuthRepository _repository;

  DeleteUser(this._repository);

  Future<Either<AuthFailure, void>> execute() {
    return _repository.deleteUser();
  }
}
