import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/repositories/news_repository.dart';

class ClearBookmarks {
  final NewsRepository _repository;

  ClearBookmarks(this._repository);

  Future<Either<Failure, String>> execute() {
    return _repository.clearBookmarks();
  }
}
