import 'package:flutter/material.dart';
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

  // RequestState _state = RequestState.empty;
  // RequestState get state => _state;

  // List<NewsEntity> _bookmarks = <NewsEntity>[];
  // List<NewsEntity> get bookmarks => _bookmarks;

  // String _message = '';
  // String get message => _message;

  // Future<void> getBookmarks(String uid) async {
  //   final result = await getBookmarksUseCase.execute(uid);

  //   result.fold(
  //     (failure) {
  //       _message = failure.message;
  //       _state = RequestState.error;
  //     },
  //     (bookmarks) {
  //       _bookmarks = bookmarks;
  //       _state = RequestState.success;
  //     },
  //   );

  //   notifyListeners();
  // }

  // Future<void> clearBookmarks(String uid) async {
  //   final result = await clearBookmarksUseCase.execute(uid);

  //   result.fold(
  //     (failure) => _message = failure.message,
  //     (success) => _message = success,
  //   );

  //   notifyListeners();
  // }
}
