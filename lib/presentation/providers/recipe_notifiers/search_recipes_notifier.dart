import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/recipe_entity.dart';
import 'package:yess_nutrition/domain/usecases/recipe_usecases/search_recipes.dart';

class SearchRecipesNotifier extends ChangeNotifier {
  final SearchRecipes searchRecipesUseCase;

  SearchRecipesNotifier({required this.searchRecipesUseCase});

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  List<RecipeEntity> _results = <RecipeEntity>[];
  List<RecipeEntity> get results => _results;

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

  Future<void> searchRecipes({required String query}) async {
    _onSubmittedQuery = query;

    _state = RequestState.loading;
    notifyListeners();

    final result = await searchRecipesUseCase.execute(query);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (results) {
        _results = results;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }

  Future<void> refresh() async {
    final result = await searchRecipesUseCase.execute(_onSubmittedQuery);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (results) {
        _results = results;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }
}
