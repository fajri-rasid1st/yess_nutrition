import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/data/models/recipe_models/recipe_detail_model.dart';

class RecipeDetailResponse extends Equatable {
  final RecipeDetailModel recipe;

  const RecipeDetailResponse({required this.recipe});

  factory RecipeDetailResponse.fromJson(Map<String, dynamic> result) {
    return RecipeDetailResponse(
      recipe: RecipeDetailModel.fromJson(
        result['recipe'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() => {'recipe': recipe.toJson()};

  @override
  List<Object> get props => [recipe];
}
