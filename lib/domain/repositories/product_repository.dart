import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<Either<Failure, String>> createFavoriteProduct(ProductEntity product);

  Future<Either<Failure, List<ProductEntity>>> getFavoriteProducts(String uid);

  Future<Either<Failure, String>> deleteFavoriteProduct(ProductEntity product);

  Future<Either<Failure, String>> clearFavoriteProducts(String uid);

  Future<Either<Failure, bool>> isFavoriteProductExist(ProductEntity product);

  Future<Either<Failure, List<ProductEntity>>> getProducts(
      String productBaseUrl);
}
