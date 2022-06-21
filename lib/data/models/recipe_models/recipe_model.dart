import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/recipe_entity.dart';

class RecipeModel extends Equatable {
  final String? recipeId;
  final String? label;
  final String? image;
  final String? url;
  final num? totalServing;
  final num? totalTime;
  final num? calories;

  const RecipeModel({
    this.recipeId,
    this.label,
    this.image,
    this.url,
    this.totalServing,
    this.totalTime,
    this.calories,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> recipe) {
    return RecipeModel(
      recipeId: (recipe['uri'] as String?)?.split('#').last,
      label: recipe['label'] as String?,
      image: recipe['image'] as String?,
      url: recipe['url'] as String?,
      totalServing: recipe['yield'] as num?,
      totalTime: recipe['totalTime'] as num?,
      calories: recipe['calories'] as num?,
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
    };
  }

  RecipeEntity toEntity() {
    return RecipeEntity(
      recipeId: recipeId ?? '',
      label: label ?? '',
      image: image ?? '',
      url: url ?? '',
      totalServing: totalServing?.toInt() ?? 0,
      totalTime: totalServing?.toInt() ?? 0,
      calories: calories?.toDouble() ?? 0,
    );
  }

  @override
  List<Object?> get props => [
        recipeId,
        label,
        image,
        url,
        totalServing,
        totalTime,
        calories,
      ];
}
