import 'dart:math' as math;
import 'package:flutter/cupertino.dart';
import 'package:yess_nutrition/common/utils/utils.dart';
import 'package:yess_nutrition/domain/entities/entities.dart';
import 'package:yess_nutrition/domain/usecases/usecases.dart';

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

  Future<void> getAllContentHomePage() async {
    _state = RequestState.loading;
    notifyListeners();

    final resultNews = await getNewsUseCase.execute(5, 1);

    final foodProducts =
        await getProductsUseCase.execute(foodProductBaseUrls[randIndex]);

    final healthProducts =
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

    foodProducts.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (productsFood) {
        _products = List<ProductEntity>.from(_products)..addAll(productsFood);
        _state = RequestState.success;
      },
    );

    healthProducts.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (productsHealth) {
        _products = List<ProductEntity>.from(_products)..addAll(productsHealth);
        _state = RequestState.success;
      },
    );

    _products.shuffle();
    _products.removeRange(10, _products.length);

    notifyListeners();
  }

  Future<void> refresh() async {
    final resultNews = await getNewsUseCase.execute(5, 1);

    final foodProducts =
        await getProductsUseCase.execute(foodProductBaseUrls[randIndex]);

    final healthProducts =
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

    foodProducts.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (productsFood) {
        _products = List<ProductEntity>.from(_products)..addAll(productsFood);
        _state = RequestState.success;
      },
    );

    healthProducts.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (productsHealth) {
        _products = List<ProductEntity>.from(_products)..addAll(productsHealth);
        _state = RequestState.success;
      },
    );

    _products.shuffle();
    _products.removeRange(10, _products.length);

    notifyListeners();
  }
}
