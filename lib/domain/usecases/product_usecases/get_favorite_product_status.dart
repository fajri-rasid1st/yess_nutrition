import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/product_entity.dart';
import 'package:yess_nutrition/domain/repositories/product_repository.dart';

class GetFavoriteProductStatus {
  final ProductRepository _repository;

  GetFavoriteProductStatus(this._repository);

  Future<Either<Failure, bool>> execute(ProductEntity product) {
    return _repository.isFavoriteProductExist(product);
  }
}
