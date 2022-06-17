import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, String>> createBookmark(NewsEntity news);

  Future<Either<Failure, List<NewsEntity>>> getBookmarks();

  Future<Either<Failure, bool>> isBookmarkExist(NewsEntity news);

  Future<Either<Failure, String>> deleteBookmark(NewsEntity news);

  Future<Either<Failure, String>> clearBookmarks();

  Future<Either<Failure, List<NewsEntity>>> getNews(int pageSize, int page);

  Future<Either<Failure, List<NewsEntity>>> searchNews(
    int pageSize,
    int page,
    String query,
  );
}
