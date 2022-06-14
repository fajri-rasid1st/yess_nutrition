import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';

abstract class UserStorageRepository {
  Future<Either<StorageFailure, void>> uploadProfilePicture(
      String path, String name);
}
