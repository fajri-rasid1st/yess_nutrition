import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/repositories/repositories.dart';

class DeleteProfilePicture {
  final UserStorageRepository _repository;

  DeleteProfilePicture(this._repository);

  Future<Either<Failure, void>> execute(String filename) {
    return _repository.deleteProfilePicture(filename);
  }
}
