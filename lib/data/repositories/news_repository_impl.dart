import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/data/datasources/news_datasources/news_firestore_data_source.dart';
import 'package:yess_nutrition/data/datasources/news_datasources/news_remote_data_source.dart';
import 'package:yess_nutrition/data/models/news_models/news_document.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsFirestoreDataSource newsFirestoreDataSource;
  final NewsRemoteDataSource newsRemoteDataSource;

  NewsRepositoryImpl({
    required this.newsFirestoreDataSource,
    required this.newsRemoteDataSource,
  });

  @override
  Future<Either<FirestoreFailure, String>> createBookmark(
    String uid,
    NewsEntity news,
  ) async {
    try {
      final newsDocument = NewsDocument.fromEntity(news);

      final result = await newsFirestoreDataSource.createBookmark(
        uid,
        newsDocument,
      );

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('Gagal menambah bookmarks'));
    }
  }

  @override
  Future<Either<FirestoreFailure, List<NewsEntity>>> getBookmarks(
    String uid,
  ) async {
    try {
      final result = await newsFirestoreDataSource.getBookmarks(uid);

      return Right(result.map((doc) => doc.toEntity()).toList());
    } on FirestoreException {
      return const Left(FirestoreFailure('Gagal memuat bookmarks'));
    }
  }

  @override
  Future<Either<FirestoreFailure, String>> deleteBookmark(
    String uid,
    NewsEntity news,
  ) async {
    try {
      final newsDocument = NewsDocument.fromEntity(news);

      final result = await newsFirestoreDataSource.deleteBookmark(
        uid,
        newsDocument,
      );

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('Gagal menghapus bookmark'));
    }
  }

  @override
  Future<Either<FirestoreFailure, String>> clearBookmarks(String uid) async {
    try {
      final result = await newsFirestoreDataSource.clearBookmarks(uid);

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('Gagal menghapus bookmarks'));
    }
  }

  @override
  Future<Either<FirestoreFailure, bool>> isBookmarkExist(
    String uid,
    NewsEntity news,
  ) async {
    try {
      final newsDocument = NewsDocument.fromEntity(news);

      final result = await newsFirestoreDataSource.isBookmarkExist(
        uid,
        newsDocument,
      );

      return Right(result);
    } on FirestoreException {
      return const Left(FirestoreFailure('Gagal memuat bookmark'));
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
      final result = await newsRemoteDataSource.searchNews(
        pageSize,
        page,
        query,
      );

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
