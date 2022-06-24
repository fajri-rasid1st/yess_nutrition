import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/repositories/product_repository.dart';

class ClearFavoriteProducts {
  final ProductRepository _repository;

  ClearFavoriteProducts(this._repository);

  Future<Either<Failure, String>> execute(String uid) {
    return _repository.clearFavoriteProducts(uid);
  }
}
