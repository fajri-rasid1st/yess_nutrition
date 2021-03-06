import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/repositories/news_repository.dart';

class ClearNewsBookmarks {
  final NewsRepository _repository;

  ClearNewsBookmarks(this._repository);

  Future<Either<Failure, String>> execute(String uid) {
    return _repository.clearNewsBookmarks(uid);
  }
}
