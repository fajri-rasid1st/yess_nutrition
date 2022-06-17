import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';

abstract class NewsRepository {
  Future<Either<FirestoreFailure, String>> createBookmark(
    String uid,
    NewsEntity news,
  );

  Future<Either<FirestoreFailure, List<NewsEntity>>> getBookmarks(String uid);

  Future<Either<FirestoreFailure, String>> deleteBookmark(
    String uid,
    NewsEntity news,
  );

  Future<Either<FirestoreFailure, String>> clearBookmarks(String uid);

  Future<Either<FirestoreFailure, bool>> isBookmarkExist(
    String uid,
    NewsEntity news,
  );

  Future<Either<Failure, List<NewsEntity>>> getNews(int pageSize, int page);

  Future<Either<Failure, List<NewsEntity>>> searchNews(
    int pageSize,
    int page,
    String query,
  );
}
