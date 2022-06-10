import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/domain/repositories/news_repository.dart';

class GetBookmarks {
  final NewsRepository _repository;

  GetBookmarks(this._repository);

  Future<Either<Failure, List<NewsEntity>>> execute() {
    return _repository.getBookmarks();
  }
}
