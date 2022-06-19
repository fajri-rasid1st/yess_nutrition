import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/data/datasources/food_datasources/food_local_data_source.dart';
import 'package:yess_nutrition/data/datasources/food_datasources/food_remote_data_source.dart';
import 'package:yess_nutrition/data/models/food_models/food_table.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';
import 'package:yess_nutrition/domain/repositories/food_repository.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodLocalDataSource foodLocalDataSource;
  final FoodRemoteDataSource foodRemoteDataSource;

  FoodRepositoryImpl({
    required this.foodLocalDataSource,
    required this.foodRemoteDataSource,
  });

  @override
  Future<Either<Failure, void>> addFoodHistory(FoodEntity food) async {
    try {
      final foodTable = FoodTable.fromEntity(food);

      return Right(await foodLocalDataSource.addFoodHistory(foodTable));
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal menambahkan ke riwayat'));
    }
  }

  @override
  Future<Either<Failure, List<FoodEntity>>> getFoodHistories(String uid) async {
    try {
      final result = await foodLocalDataSource.getFoodHistories(uid);

      return Right(result.map((table) => table.toEntity()).toList());
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal memuat riwayat'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteFoodHistory(FoodEntity food) async {
    try {
      final foodTable = FoodTable.fromEntity(food);

      final result = await foodLocalDataSource.deleteFoodHistory(foodTable);

      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal menghapus riwayat'));
    }
  }

  @override
  Future<Either<Failure, String>> clearFoodHistories(String uid) async {
    try {
      final result = await foodLocalDataSource.clearFoodHistories(uid);

      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal menghapus semua riwayat'));
    }
  }

  @override
  Future<Either<Failure, Map<String, List<FoodEntity>>>> searchFoods(
      String query) async {
    try {
      final result = await foodRemoteDataSource.searchFoods(query);

      final resultEntity = result.map((key, value) {
        final foodEntity = value.map((model) => model.toEntity()).toList();

        return MapEntry(key, foodEntity);
      });

      return Right(resultEntity);
    } on ServerException {
      return const Left(ServerFailure('Gagal terhubung ke server'));
    } on SocketException {
      return const Left(ConnectionFailure('Tidak ada koneksi internet'));
    } on TlsException {
      return const Left(SslFailure('Verifikasi sertifikat SSL gagal'));
    }
  }
}
