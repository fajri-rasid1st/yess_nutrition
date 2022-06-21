import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/data/models/nutrients_models/nutrients_model.dart';
import 'package:yess_nutrition/domain/entities/nutrients_entity.dart';
import 'package:yess_nutrition/domain/entities/recipe_entity.dart';

class RecipeModel extends Equatable {
  final String? recipeId;
  final String? label;
  final String? image;
  final String? url;
  final num? totalServing;
  final List<String>? healthLabels;
  final num? totalTime;
  final NutrientsModel? totalNutrients;

  const RecipeModel({
    this.recipeId,
    this.label,
    this.image,
    this.url,
    this.totalServing,
    this.healthLabels,
    this.totalTime,
    this.totalNutrients,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> recipe) {
    return RecipeModel(
      recipeId: (recipe['uri'] as String?)?.split('#').last,
      label: recipe['label'] as String?,
      image: recipe['image'] as String?,
      url: recipe['recipe'] as String?,
      totalServing: recipe['yield'] as num?,
      healthLabels: recipe['healthLabels'] as List<String>?,
      totalTime: recipe['totalTime'] as num?,
      totalNutrients: NutrientsModel.fromJsonRecipe(
        recipe['totalNutrients'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipeId': recipeId,
      'label': label,
      'image': image,
      'url': url,
      'totalServing': totalServing,
      'healthLabels': healthLabels,
      'totalTime': totalTime,
      'totalNutrients': totalNutrients?.toJson(),
    };
  }

  RecipeEntity toEntity() {
    return RecipeEntity(
      recipeId: recipeId ?? '',
      label: label ?? '',
      image: image ?? '',
      url: url ?? '',
      totalServing: totalServing?.toInt() ?? 0,
      healthLabels: healthLabels ?? <String>[],
      totalTime: totalServing?.toInt() ?? 0,
      totalNutrients: totalNutrients?.toEntity() ??
          const NutrientsEntity(
            calories: 0,
            carbohydrate: 0,
            protein: 0,
            fat: 0,
            fiber: 0,
          ),
    );
  }

  @override
  List<Object?> get props => [
        recipeId,
        label,
        image,
        url,
        totalServing,
        healthLabels,
        totalTime,
        totalNutrients,
      ];
}
