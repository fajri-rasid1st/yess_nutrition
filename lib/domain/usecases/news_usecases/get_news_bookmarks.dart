import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/domain/repositories/news_repository.dart';

class GetNewsBookmarks {
  final NewsRepository _repository;

  GetNewsBookmarks(this._repository);

  Future<Either<Failure, List<NewsEntity>>> execute(String uid) {
    return _repository.getNewsBookmarks(uid);
  }
}
