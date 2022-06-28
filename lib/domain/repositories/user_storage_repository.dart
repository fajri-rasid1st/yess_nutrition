import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';

abstract class UserStorageRepository {
  Future<Either<Failure, String>> uploadProfilePicture(
    String path,
    String name,
  );

  Future<Either<Failure, void>> deleteProfilePicture(String filename);
}
