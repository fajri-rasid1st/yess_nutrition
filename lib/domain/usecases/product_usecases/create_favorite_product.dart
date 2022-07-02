import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/product_entity.dart';
import 'package:yess_nutrition/domain/repositories/product_repository.dart';

class CreateFavoriteProduct {
  final ProductRepository _repository;

  CreateFavoriteProduct(this._repository);

  Future<Either<Failure, String>> execute(ProductEntity product) {
    return _repository.createFavoriteProduct(product);
  }
}
