import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';

abstract class NewsRepository {
  Future<Either<Failure, String>> createNewsBookmark(NewsEntity news);

  Future<Either<Failure, List<NewsEntity>>> getNewsBookmarks(String uid);

  Future<Either<Failure, bool>> isNewsBookmarkExist(NewsEntity news);

  Future<Either<Failure, String>> deleteNewsBookmark(NewsEntity news);

  Future<Either<Failure, String>> clearNewsBookmarks(String uid);

  Future<Either<Failure, List<NewsEntity>>> getNews(int pageSize, int page);

  Future<Either<Failure, List<NewsEntity>>> searchNews(
    int pageSize,
    int page,
    String query,
  );
}
