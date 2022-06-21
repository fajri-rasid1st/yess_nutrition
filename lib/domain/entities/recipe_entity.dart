import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/nutrients_entity.dart';

class RecipeEntity extends Equatable {
  final String? uid;
  final String recipeId;
  final String label;
  final String image;
  final String url;
  final int totalServing;
  final List<String> healthLabels;
  final int totalTime;
  final NutrientsEntity totalNutrients;

  const RecipeEntity({
    this.uid,
    required this.recipeId,
    required this.label,
    required this.image,
    required this.url,
    required this.totalServing,
    required this.healthLabels,
    required this.totalTime,
    required this.totalNutrients,
  });

  const RecipeEntity.favorite({
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

  RecipeEntity copyWith({
    String? uid,
    String? recipeId,
    String? label,
    String? image,
    String? url,
    int? totalServing,
    List<String>? healthLabels,
    int? totalTime,
    NutrientsEntity? totalNutrients,
  }) {
    return RecipeEntity(
      uid: uid ?? this.uid,
      recipeId: recipeId ?? this.recipeId,
      label: label ?? this.label,
      image: image ?? this.image,
      url: url ?? this.url,
      totalServing: totalServing ?? this.totalServing,
      healthLabels: healthLabels ?? this.healthLabels,
      totalTime: totalTime ?? this.totalTime,
      totalNutrients: totalNutrients ?? this.totalNutrients,
    );
  }

  @override
  List<Object?> get props => [
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
