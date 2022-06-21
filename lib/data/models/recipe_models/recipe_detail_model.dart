import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/data/models/nutrients_models/nutrients_model.dart';
import 'package:yess_nutrition/domain/entities/nutrients_entity.dart';
import 'package:yess_nutrition/domain/entities/recipe_detail_entity.dart';

class RecipeDetailModel extends Equatable {
  final String? recipeId;
  final String? label;
  final String? image;
  final String? url;
  final num? totalServing;
  final num? totalTime;
  final num? calories;
  final List<String>? dietLabels;
  final List<String>? healthLabels;
  final List<String>? cautionLabels;
  final List<String>? ingredients;
  final NutrientsModel? totalNutrients;

  const RecipeDetailModel({
    this.recipeId,
    this.label,
    this.image,
    this.url,
    this.totalServing,
    this.totalTime,
    this.calories,
    this.dietLabels,
    this.healthLabels,
    this.cautionLabels,
    this.ingredients,
    this.totalNutrients,
  });

  factory RecipeDetailModel.fromJson(Map<String, dynamic> recipe) {
    return RecipeDetailModel(
      recipeId: (recipe['uri'] as String?)?.split('#').last,
      label: recipe['label'] as String?,
      image: recipe['image'] as String?,
      url: recipe['url'] as String?,
      totalServing: recipe['yield'] as num?,
      totalTime: recipe['totalTime'] as num?,
      calories: recipe['calories'] as num?,
      dietLabels: recipe['dietLabels'] as List<String>?,
      healthLabels: recipe['healthLabels'] as List<String>?,
      cautionLabels: recipe['cautions'] as List<String>?,
      ingredients: recipe['ingredientLines'] as List<String>?,
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
      'totalTime': totalTime,
      'calories': calories,
      'dietLabels': dietLabels,
      'healthLabels': healthLabels,
      'cautionLabels': cautionLabels,
      'ingredients': ingredients,
      'totalNutrients': totalNutrients?.toJson(),
    };
  }

  RecipeDetailEntity toEntity() {
    return RecipeDetailEntity(
      recipeId: recipeId ?? '',
      label: label ?? '',
      image: image ?? '',
      url: url ?? '',
      totalServing: totalServing?.toInt() ?? 0,
      totalTime: totalServing?.toInt() ?? 0,
      calories: calories?.toDouble() ?? 0,
      dietLabels: dietLabels ?? <String>[],
      healthLabels: healthLabels ?? <String>[],
      cautionLabels: cautionLabels ?? <String>[],
      ingredients: ingredients ?? <String>[],
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
  List<Object?> get props {
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
