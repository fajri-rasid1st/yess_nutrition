import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';
import 'package:yess_nutrition/domain/usecases/food_usecases/add_food_history.dart';
import 'package:yess_nutrition/domain/usecases/food_usecases/clear_food_histories.dart';
import 'package:yess_nutrition/domain/usecases/food_usecases/delete_food_history.dart';
import 'package:yess_nutrition/domain/usecases/food_usecases/get_food_histories.dart';

class FoodHistoryNotifier extends ChangeNotifier {
  final AddFoodHistory addFoodHistoryUseCase;
  final GetFoodHistories getFoodHistoriesUseCase;
  final DeleteFoodHistory deleteFoodHistoryUseCase;
  final ClearFoodHistories clearFoodHistoriesUseCase;

  FoodHistoryNotifier({
    required this.addFoodHistoryUseCase,
    required this.getFoodHistoriesUseCase,
    required this.deleteFoodHistoryUseCase,
    required this.clearFoodHistoriesUseCase,
  });

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  List<FoodEntity> _foods = <FoodEntity>[];
  List<FoodEntity> get foods => _foods;

  Future<void> addFoodHistory(FoodEntity food) async {
    final result = await addFoodHistoryUseCase.execute(food);

    result.fold(
      (failure) => _message = failure.message,
      (_) {},
    );

    notifyListeners();
  }

  Future<void> getFoodHistories(String uid) async {
    final result = await getFoodHistoriesUseCase.execute(uid);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (foods) {
        _foods = foods;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }

  Future<void> deleteFoodHistory(FoodEntity food) async {
    final result = await deleteFoodHistoryUseCase.execute(food);

    result.fold(
      (failure) => _message = failure.message,
      (success) => _message = success,
    );

    notifyListeners();
  }

  Future<void> clearFoodHistories(String uid) async {
    final result = await clearFoodHistoriesUseCase.execute(uid);

    result.fold(
      (failure) => _message = failure.message,
      (success) => _message = success,
    );

    notifyListeners();
  }
}
