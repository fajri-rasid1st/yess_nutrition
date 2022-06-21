import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/recipe_entity.dart';

const recipeBookmarksTable = 'recipe_bookmarks_table';

class RecipeTable extends Equatable {
  final String uid;
  final String recipeId;
  final String label;
  final String image;
  final String url;
  final int totalServing;
  final int totalTime;
  final num calories;

  const RecipeTable({
    required this.uid,
    required this.recipeId,
    required this.label,
    required this.image,
    required this.url,
    required this.totalServing,
    required this.totalTime,
    required this.calories,
  });

  factory RecipeTable.fromEntity(RecipeEntity recipe) {
    return RecipeTable(
      uid: recipe.uid!,
      recipeId: recipe.recipeId,
      label: recipe.label,
      image: recipe.image,
      url: recipe.url,
      totalServing: recipe.totalServing,
      totalTime: recipe.totalTime,
      calories: recipe.calories,
    );
  }

  factory RecipeTable.fromMap(Map<String, dynamic> recipe) {
    return RecipeTable(
      uid: recipe['uid'] as String,
      recipeId: recipe['recipeId'] as String,
      label: recipe['label'] as String,
      image: recipe['image'] as String,
      url: recipe['url'] as String,
      totalServing: recipe['totalServing'] as int,
      totalTime: recipe['totalTime'] as int,
      calories: recipe['calories'] as num,
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
      totalTime: totalServing,
      calories: calories.toDouble(),
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
      'totalTime': totalTime,
      'calories': calories,
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
        totalTime,
        calories,
      ];
}
