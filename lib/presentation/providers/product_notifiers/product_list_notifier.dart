import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/product_entity.dart';
import 'package:yess_nutrition/domain/usecases/product_usecases/product_usecases.dart';

class ProductListNotifier extends ChangeNotifier {
  final GetProducts getProductsUseCase;

  ProductListNotifier({required this.getProductsUseCase});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  List<ProductEntity> _products = <ProductEntity>[];
  List<ProductEntity> get products => _products;

  bool _isReload = false;
  bool get isReload => _isReload;

  set isReload(bool value) {
    _isReload = value;
    notifyListeners();
  }

  String _productBaseUrl = '';

  Future<void> getProducts({required String productBaseUrl}) async {
    _productBaseUrl = productBaseUrl;

    _state = RequestState.loading;
    notifyListeners();

    final result = await getProductsUseCase.execute(productBaseUrl);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (products) {
        _products = products;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }

  Future<void> refresh() async {
    final result = await getProductsUseCase.execute(_productBaseUrl);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (products) {
        _products = products;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }
}
