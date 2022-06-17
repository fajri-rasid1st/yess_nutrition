import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/domain/repositories/news_repository.dart';

class GetBookmarkStatus {
  final NewsRepository _repository;

  GetBookmarkStatus(this._repository);

  Future<Either<FirestoreFailure, bool>> execute(
    String uid,
    NewsEntity news,
  ) {
    return _repository.isBookmarkExist(uid, news);
  }
}
