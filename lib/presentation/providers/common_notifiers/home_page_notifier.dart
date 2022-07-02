import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/constants.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/domain/entities/product_entity.dart';
import 'package:yess_nutrition/domain/usecases/news_usecases/get_news.dart';
import 'package:yess_nutrition/domain/usecases/product_usecases/get_products.dart';

class HomePageNotifier extends ChangeNotifier {
  final GetNews getNewsUseCase;
  final GetProducts getProductsUseCase;

  HomePageNotifier({
    required this.getNewsUseCase,
    required this.getProductsUseCase,
  });

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  List<NewsEntity> _news = <NewsEntity>[];
  List<NewsEntity> get news => _news;

  List<ProductEntity> _products = <ProductEntity>[];
  List<ProductEntity> get products => _products;

  final int _randIndex = math.Random().nextInt(8);
  int get randIndex => _randIndex;

  Future<void> getAllContents({bool refresh = false}) async {
    if (!refresh) {
      _state = RequestState.loading;
      notifyListeners();
    }

    final resultNews = await getNewsUseCase.execute(5, 1);

    final resultFoodProducts =
        await getProductsUseCase.execute(foodProductBaseUrls[randIndex]);

    final resultHealthProducts =
        await getProductsUseCase.execute(healthProductBaseUrls[randIndex]);

    resultNews.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (news) {
        _news = news;
        _state = RequestState.success;
      },
    );

    resultFoodProducts.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (productsFood) {
        _products = productsFood;
        _state = RequestState.success;
      },
    );

    resultHealthProducts.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (productsHealth) {
        _products = _products..addAll(productsHealth);
        _state = RequestState.success;
      },
    );

    _products.shuffle();
    _products.removeRange(10, _products.length);

    notifyListeners();
  }
}
