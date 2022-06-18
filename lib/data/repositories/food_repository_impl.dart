import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/data/datasources/food_datasources/food_remote_data_source.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';
import 'package:yess_nutrition/domain/repositories/food_repository.dart';

class FoodRepositoryImpl implements FoodRepository {
  final FoodRemoteDataSource foodRemoteDataSource;

  FoodRepositoryImpl({required this.foodRemoteDataSource});

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
