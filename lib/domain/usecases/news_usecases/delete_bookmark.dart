import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/domain/repositories/news_repository.dart';

class DeleteBookmark {
  final NewsRepository _repository;

  DeleteBookmark(this._repository);

  Future<Either<Failure, String>> execute(NewsEntity news) {
    return _repository.deleteBookmark(news);
  }
}
