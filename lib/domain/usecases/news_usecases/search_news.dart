import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/domain/repositories/news_repository.dart';

class SearchNews {
  final NewsRepository _repository;

  SearchNews(this._repository);

  Future<Either<Failure, List<NewsEntity>>> execute(
    int pageSize,
    int page,
    String query,
  ) {
    return _repository.searchNews(pageSize, page, query);
  }
}
