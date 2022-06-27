import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/constants.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/product_entity.dart';
import 'package:yess_nutrition/domain/usecases/product_usecases/product_usecases.dart';

class ProductsNotifier extends ChangeNotifier {
  final GetProducts getProductsUseCase;

  ProductsNotifier({required this.getProductsUseCase});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  final Map<String, List<ProductEntity>> _productsMap = {};
  Map<String, List<ProductEntity>> get productsMap => _productsMap;

  bool _isReload = false;
  bool get isReload => _isReload;

  set isReload(bool value) {
    _isReload = value;
    notifyListeners();
  }

  final int _randIndex = math.Random().nextInt(8);
  int get randIndex => _randIndex;

  Future<void> getProducts() async {
    final foodProducts =
        await getProductsUseCase.execute(foodProductBaseUrls[randIndex]);

    final healthProducts =
        await getProductsUseCase.execute(healthProductBaseUrls[randIndex]);

    final recommendationProducts =
        await getProductsUseCase.execute(recommendationProductBaseUrl);

    foodProducts.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (products) {
        _productsMap['food'] = products;
        _state = RequestState.success;
      },
    );

    healthProducts.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (products) {
        _productsMap['health'] = products;
        _state = RequestState.success;
      },
    );

    recommendationProducts.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (products) {
        _productsMap['recommendation'] = products;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }
}
