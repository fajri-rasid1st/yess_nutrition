import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/product_entity.dart';
import 'package:yess_nutrition/domain/usecases/product_usecases/product_usecases.dart';

class FavoriteProductNotifier extends ChangeNotifier {
  final CreateFavoriteProduct createFavoriteProductUseCase;
  final DeleteFavoriteProduct deleteFavoriteProductUseCase;
  final GetFavoriteProductStatus getFavoriteProductStatusUseCase;
  final GetFavoriteProducts getFavoriteProductsUseCase;
  final ClearFavoriteProducts clearFavoriteProductsUseCase;

  FavoriteProductNotifier({
    required this.createFavoriteProductUseCase,
    required this.deleteFavoriteProductUseCase,
    required this.getFavoriteProductStatusUseCase,
    required this.getFavoriteProductsUseCase,
    required this.clearFavoriteProductsUseCase,
  });

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  bool _isExist = false;
  bool get isExist => _isExist;

  List<ProductEntity> _favorites = <ProductEntity>[];
  List<ProductEntity> get favorites => _favorites;

  Future<void> createFavoriteProduct(ProductEntity product) async {
    final result = await createFavoriteProductUseCase.execute(product);

    result.fold(
      (failure) => _message = failure.message,
      (success) => _message = success,
    );

    await getFavoriteProductStatus(product);
  }

  Future<void> deleteFavoriteProduct(ProductEntity product) async {
    final result = await deleteFavoriteProductUseCase.execute(product);

    result.fold(
      (failure) => _message = failure.message,
      (success) => _message = success,
    );

    await getFavoriteProductStatus(product);
  }

  Future<void> getFavoriteProductStatus(ProductEntity product) async {
    final result = await getFavoriteProductStatusUseCase.execute(product);
    
    result.fold(
      (failure) => _message = failure.message,
      (isExist) => _isExist = isExist,
    );

    notifyListeners();
  }

  Future<void> getFavoriteProducts(String uid) async {
    final result = await getFavoriteProductsUseCase.execute(uid);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (favorites) {
        _favorites = favorites;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }

  Future<void> clearFavoriteProducts(String uid) async {
    final result = await clearFavoriteProductsUseCase.execute(uid);

    result.fold(
      (failure) => _message = failure.message,
      (success) => _message = success,
    );

    notifyListeners();
  }
}
