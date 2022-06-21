import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/data/datasources/recipe_datasources/recipe_local_data_source.dart';
import 'package:yess_nutrition/data/datasources/recipe_datasources/recipe_remote_data_source.dart';
import 'package:yess_nutrition/data/models/recipe_models/recipe_table.dart';
import 'package:yess_nutrition/domain/entities/recipe_detail_entity.dart';
import 'package:yess_nutrition/domain/entities/recipe_entity.dart';
import 'package:yess_nutrition/domain/repositories/recipe_repository.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeLocalDataSource recipeLocalDataSource;
  final RecipeRemoteDataSource recipeRemoteDataSource;

  RecipeRepositoryImpl({
    required this.recipeLocalDataSource,
    required this.recipeRemoteDataSource,
  });

  @override
  Future<Either<Failure, String>> createRecipeBookmark(
      RecipeEntity recipe) async {
    try {
      final recipeTable = RecipeTable.fromEntity(recipe);

      final result =
          await recipeLocalDataSource.createRecipeBookmark(recipeTable);

      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal menambah resep ke bookmark'));
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> getRecipeBookmarks(
      String uid) async {
    try {
      final result = await recipeLocalDataSource.getRecipeBookmarks(uid);

      return Right(result.map((table) => table.toEntity()).toList());
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal memuat resep bookmarks'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteRecipeBookmark(
      RecipeEntity recipe) async {
    try {
      final recipeTable = RecipeTable.fromEntity(recipe);

      final result =
          await recipeLocalDataSource.deleteRecipeBookmark(recipeTable);

      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal menghapus resep bookmark'));
    }
  }

  @override
  Future<Either<Failure, String>> clearRecipeBookmarks(String uid) async {
    try {
      final result = await recipeLocalDataSource.clearRecipeBookmarks(uid);

      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal menghapus resep bookmarks'));
    }
  }

  @override
  Future<Either<Failure, bool>> isRecipeBookmarkExist(
      RecipeEntity recipe) async {
    try {
      final recipeTable = RecipeTable.fromEntity(recipe);

      final result =
          await recipeLocalDataSource.isRecipeBookmarkExist(recipeTable);

      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal memuat resep bookmark'));
    }
  }

  @override
  Future<Either<Failure, List<RecipeEntity>>> searchRecipes(
      String query) async {
    try {
      final result = await recipeRemoteDataSource.searchRecipes(query);

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
  Future<Either<Failure, RecipeDetailEntity>> getRecipeDetail(
      String recipeId) async {
    try {
      final result = await recipeRemoteDataSource.getRecipeDetail(recipeId);

      return Right(result.toEntity());
    } on ServerException {
      return const Left(ServerFailure('Gagal terhubung ke server'));
    } on SocketException {
      return const Left(ConnectionFailure('Tidak ada koneksi internet'));
    } on TlsException {
      return const Left(SslFailure('Verifikasi sertifikat SSL gagal'));
    }
  }
}
