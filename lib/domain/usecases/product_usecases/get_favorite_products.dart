import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/product_entity.dart';
import 'package:yess_nutrition/domain/repositories/product_repository.dart';

class GetFavoriteProducts {
  final ProductRepository _repository;

  GetFavoriteProducts(this._repository);

  Future<Either<Failure, List<ProductEntity>>> execute(String uid) {
    return _repository.getFavoriteProducts(uid);
  }
}
