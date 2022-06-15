import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';

abstract class UserStorageRepository {
  Future<Either<StorageFailure, String>> uploadProfilePicture(
    String path,
    String name,
  );
}
