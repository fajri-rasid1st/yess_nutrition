import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/data/models/recipe_models/recipe_model.dart';

class RecipeResponse extends Equatable {
  final List<RecipeModel> recipes;

  const RecipeResponse({required this.recipes});

  factory RecipeResponse.fromJson(Map<String, dynamic> results) {
    return RecipeResponse(
      recipes: List<RecipeModel>.from(
        (results['hits'] as List<Map<String, dynamic>>).map(
          (hit) => RecipeModel.fromJson(
            hit['recipe'] as Map<String, dynamic>,
          ),
        ),
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipes': List<Map<String, dynamic>>.from(
        recipes.map((food) => food.toJson()),
      ),
    };
  }

  @override
  List<Object> get props => [recipes];
}
