import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/data/models/nutrients_models/nutrients_table.dart';
import 'package:yess_nutrition/domain/entities/recipe_entity.dart';

const recipeFavoriteTable = 'recipe_favorite_table';

class RecipeTable extends Equatable {
  final String uid;
  final String recipeId;
  final String label;
  final String image;
  final String url;
  final int totalServing;
  final List<String> healthLabels;
  final int totalTime;
  final NutrientsTable totalNutrients;

  const RecipeTable({
    required this.uid,
    required this.recipeId,
    required this.label,
    required this.image,
    required this.url,
    required this.totalServing,
    required this.healthLabels,
    required this.totalTime,
    required this.totalNutrients,
  });

  factory RecipeTable.fromEntity(RecipeEntity recipe) {
    return RecipeTable(
      uid: recipe.uid!,
      recipeId: recipe.recipeId,
      label: recipe.label,
      image: recipe.image,
      url: recipe.url,
      totalServing: recipe.totalServing,
      healthLabels: recipe.healthLabels,
      totalTime: recipe.totalTime,
      totalNutrients: NutrientsTable.fromEntity(recipe.totalNutrients),
    );
  }

  factory RecipeTable.fromMap(Map<String, dynamic> recipe) {
    return RecipeTable(
      uid: recipe['uid'] as String,
      recipeId: recipe['uri'] as String,
      label: recipe['label'] as String,
      image: recipe['image'] as String,
      url: recipe['recipe'] as String,
      totalServing: recipe['yield'] as int,
      healthLabels: (recipe['healthLabels'] as String).split('; '),
      totalTime: recipe['totalTime'] as int,
      totalNutrients: NutrientsTable.fromString(
        recipe['totalNutrients'] as String,
      ),
    );
  }

  RecipeEntity toEntity() {
    return RecipeEntity.favorite(
      uid: uid,
      recipeId: recipeId,
      label: label,
      image: image,
      url: url,
      totalServing: totalServing,
      healthLabels: healthLabels,
      totalTime: totalServing,
      totalNutrients: totalNutrients.toEntity(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'recipeId': recipeId,
      'label': label,
      'image': image,
      'url': url,
      'totalServing': totalServing,
      'healthLabels': healthLabels.join('; '),
      'totalTime': totalTime,
      'totalNutrients': totalNutrients.toString(),
    };
  }

  @override
  List<Object> get props => [
        uid,
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
