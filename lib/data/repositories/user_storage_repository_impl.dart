import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/data/datasources/datasources.dart';
import 'package:yess_nutrition/domain/repositories/repositories.dart';

class UserStorageRepositoryImpl implements UserStorageRepository {
  final UserStorageDataSource userStorageDataSource;

  UserStorageRepositoryImpl({required this.userStorageDataSource});

  @override
  Future<Either<StorageFailure, String>> uploadProfilePicture(
    String path,
    String name,
  ) async {
    try {
      final result =
          await userStorageDataSource.uploadProfilePicture(path, name);

      return Right(result.toString());
    } on StorageException {
      return const Left(StorageFailure('Oops, terjadi kesalahan'));
    }
  }
}
