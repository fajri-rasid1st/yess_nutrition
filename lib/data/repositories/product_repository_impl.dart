import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/data/datasources/product_datasources/product_local_data_source.dart';
import 'package:yess_nutrition/data/datasources/product_datasources/product_remote_data_source.dart';
import 'package:yess_nutrition/data/models/product_models/product_table.dart';
import 'package:yess_nutrition/domain/entities/product_entity.dart';
import 'package:yess_nutrition/domain/repositories/product_repository.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource productLocalDataSource;
  final ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImpl({
    required this.productLocalDataSource,
    required this.productRemoteDataSource,
  });

  @override
  Future<Either<Failure, String>> createFavoriteProduct(
      ProductEntity product) async {
    try {
      final productTable = ProductTable.fromEntity(product);

      final result =
          await productLocalDataSource.createFavoriteProduct(productTable);

      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal menambah product ke favorite'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getFavoriteProducts(
      String uid) async {
    try {
      final result = await productLocalDataSource.getFavoriteProducts(uid);

      return Right(result.map((table) => table.toEntity()).toList());
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal memuat product favorite'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteFavoriteProduct(
      ProductEntity product) async {
    try {
      final productTable = ProductTable.fromEntity(product);

      final result =
          await productLocalDataSource.deleteFavoriteProduct(productTable);

      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal menghapus product favorite'));
    }
  }

  @override
  Future<Either<Failure, String>> clearFavoriteProducts(String uid) async {
    try {
      final result = await productLocalDataSource.clearFavoriteProducts(uid);

      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal menghapus semua favorite'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavoriteProductExist(
      ProductEntity product) async {
    try {
      final productTable = ProductTable.fromEntity(product);

      final result =
          await productLocalDataSource.isFavoriteProductExist(productTable);

      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal memuat product favorite'));
    }
  }

  @override
  Future<Either<Failure, List<ProductEntity>>> getProducts(
      String productBaseUrl) async {
    try {
      final result = await productRemoteDataSource.getProducts(productBaseUrl);

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
