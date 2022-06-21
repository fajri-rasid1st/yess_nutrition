import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/nutrients_entity.dart';

class RecipeDetailEntity extends Equatable {
  final String recipeId;
  final String label;
  final String image;
  final String url;
  final int totalServing;
  final int totalTime;
  final double calories;
  final List<String> dietLabels;
  final List<String> healthLabels;
  final List<String> cautionLabels;
  final List<String> ingredients;
  final NutrientsEntity totalNutrients;

  const RecipeDetailEntity({
    required this.recipeId,
    required this.label,
    required this.image,
    required this.url,
    required this.totalServing,
    required this.totalTime,
    required this.calories,
    required this.dietLabels,
    required this.healthLabels,
    required this.cautionLabels,
    required this.ingredients,
    required this.totalNutrients,
  });

  @override
  List<Object> get props {
    return [
      recipeId,
      label,
      image,
      url,
      totalServing,
      totalTime,
      calories,
      dietLabels,
      healthLabels,
      cautionLabels,
      ingredients,
      totalNutrients,
    ];
  }
}
