import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/repositories/repositories.dart';

class UploadProfilePicture {
  final UserStorageRepository _repository;

  UploadProfilePicture(this._repository);

  Future<Either<StorageFailure, void>> execute(String path, String name) {
    return _repository.uploadProfilePicture(path, name);
  }
}
