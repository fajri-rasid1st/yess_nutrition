import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/data/datasources/news_datasources/news_local_data_source.dart';
import 'package:yess_nutrition/data/datasources/news_datasources/news_remote_data_source.dart';
import 'package:yess_nutrition/data/models/news_models/news_table.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsLocalDataSource newsLocalDataSource;
  final NewsRemoteDataSource newsRemoteDataSource;

  NewsRepositoryImpl({
    required this.newsLocalDataSource,
    required this.newsRemoteDataSource,
  });

  @override
  Future<Either<Failure, String>> createBookmark(NewsEntity news) async {
    try {
      final newsTable = NewsTable.fromEntity(news);

      final result = await newsLocalDataSource.createBookmark(newsTable);

      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal menambah bookmark'));
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getBookmarks() async {
    try {
      final result = await newsLocalDataSource.getBookmarks();

      return Right(result.map((table) => table.toEntity()).toList());
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal memuat bookmarks'));
    }
  }

  @override
  Future<Either<Failure, bool>> isBookmarkExist(NewsEntity news) async {
    try {
      final newsTable = NewsTable.fromEntity(news);

      final result = await newsLocalDataSource.isBookmarkExist(newsTable);

      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal memuat bookmark'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteBookmark(NewsEntity news) async {
    try {
      final newsTable = NewsTable.fromEntity(news);

      final result = await newsLocalDataSource.deleteBookmark(newsTable);

      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal menghapus bookmark'));
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getNews(
    int pageSize,
    int page,
  ) async {
    try {
      final result = await newsRemoteDataSource.getNews(pageSize, page);

      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure('Gagal terhubung ke server'));
    } on SocketException {
      return const Left(ConnectionFailure('Tidak ada koneksi internet'));
    } on TlsException {
      return const Left(SslFailure('Verifikasi sertifikat SSL gagal'));
    }
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> searchNews(
    int pageSize,
    int page,
    String query,
  ) async {
    try {
      final result =
          await newsRemoteDataSource.searchNews(pageSize, page, query);

      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return const Left(ServerFailure('Gagal terhubung ke server'));
    } on SocketException {
      return const Left(ConnectionFailure('Tidak ada koneksi internet'));
    } on TlsException {
      return const Left(SslFailure('Verifikasi sertifikat SSL gagal'));
    }
  }
}
