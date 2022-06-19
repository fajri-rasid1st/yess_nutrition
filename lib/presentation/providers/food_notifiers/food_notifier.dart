import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';
import 'package:yess_nutrition/domain/usecases/food_usecases/search_foods.dart';

class FoodNotifier extends ChangeNotifier {
  final SearchFoods searchFoodsUseCase;

  FoodNotifier({required this.searchFoodsUseCase});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

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

  Future<void> searchFoods({required String query}) async {
    _onSubmittedQuery = query;

    _state = RequestState.loading;
    notifyListeners();

    final result = await searchFoodsUseCase.execute(query);

    result.fold(
      (failure) {
        _message = failure.message;
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

  Future<void> refresh() async {
    final result = await searchFoodsUseCase.execute(_onSubmittedQuery);

    result.fold(
      (failure) {
        _message = failure.message;
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
