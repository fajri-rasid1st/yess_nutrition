import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';
import 'package:yess_nutrition/domain/usecases/food_usecases/search_foods.dart';

class SearchProductNotifier extends ChangeNotifier {
  final SearchFoods searchFoodsUseCase;

  SearchProductNotifier({required this.searchFoodsUseCase});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  late Failure _failure;
  Failure get failure => _failure;

  List<FoodEntity> _results = <FoodEntity>[];
  List<FoodEntity> get results => _results;

  List<FoodEntity> _hints = <FoodEntity>[];
  List<FoodEntity> get hints => _hints;

  String _onChangedQuery = '';
  String get onChangedQuery => _onChangedQuery;

  set onChangedQuery(String value) {
    _onChangedQuery = value;
    notifyListeners();
  }

  String _onSubmittedQuery = '';
  String get onSubmittedQuery => _onSubmittedQuery;

  bool _isReload = false;
  bool get isReload => _isReload;

  set isReload(bool value) {
    _isReload = value;
    notifyListeners();
  }

  Future<void> searchProduct({
    required String upc,
    bool refresh = false,
  }) async {
    _onSubmittedQuery = upc;

    if (!refresh) {
      _state = RequestState.loading;
      notifyListeners();
    }

    final result = await searchFoodsUseCase.execute('upc=$_onSubmittedQuery');

    result.fold(
      (failure) {
        _failure = failure;
        _state = RequestState.error;
      },
      (results) {
        _results = results['parsed']!;
        _hints = results['hints']!;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }
}
