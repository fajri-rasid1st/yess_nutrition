import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/domain/repositories/user_auth_repository.dart';

class GetUser {
  final UserAuthRepository _repository;

  GetUser(this._repository);

  Either<Failure, Stream<UserEntity?>> execute() {
    return _repository.getUser();
  }
}
