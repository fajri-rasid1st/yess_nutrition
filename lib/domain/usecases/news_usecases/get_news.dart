import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/domain/repositories/news_repository.dart';

class GetNews {
  final NewsRepository _repository;

  GetNews(this._repository);

  Future<Either<Failure, List<NewsEntity>>> execute(int pageSize, int page) {
    return _repository.getNews(pageSize, page);
  }
}
