import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/recipe_detail_entity.dart';
import 'package:yess_nutrition/domain/usecases/recipe_usecases/get_recipe_detail.dart';

class GetRecipeDetailNotifier extends ChangeNotifier {
  final GetRecipeDetail getRecipeDetailUseCase;

  GetRecipeDetailNotifier({required this.getRecipeDetailUseCase});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  late RecipeDetailEntity _recipe;
  RecipeDetailEntity get recipe => _recipe;

  bool _isReload = false;
  bool get isReload => _isReload;

  set isReload(bool value) {
    _isReload = value;
    notifyListeners();
  }

  String _recipeId = '';

  Future<void> getRecipeDetail({required String recipeId}) async {
    _recipeId = recipeId;

    _state = RequestState.loading;
    notifyListeners();

    final result = await getRecipeDetailUseCase.execute(recipeId);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (recipe) {
        _recipe = recipe;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }

  Future<void> refresh() async {
    final result = await getRecipeDetailUseCase.execute(_recipeId);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (recipe) {
        _recipe = recipe;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }
}
