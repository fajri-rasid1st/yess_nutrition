import 'package:equatable/equatable.dart';

class RecipeEntity extends Equatable {
  final String? uid;
  final String recipeId;
  final String label;
  final String image;
  final String url;
  final int totalServing;
  final int totalTime;
  final double calories;

  const RecipeEntity({
    this.uid,
    required this.recipeId,
    required this.label,
    required this.image,
    required this.url,
    required this.totalServing,
    required this.totalTime,
    required this.calories,
  });

  const RecipeEntity.bookmark({
    required this.uid,
    required this.recipeId,
    required this.label,
    required this.image,
    required this.url,
    required this.totalServing,
    required this.totalTime,
    required this.calories,
  });

  RecipeEntity copyWith({
    String? uid,
    String? recipeId,
    String? label,
    String? image,
    String? url,
    int? totalServing,
    int? totalTime,
    double? calories,
  }) {
    return RecipeEntity(
      uid: uid ?? this.uid,
      recipeId: recipeId ?? this.recipeId,
      label: label ?? this.label,
      image: image ?? this.image,
      url: url ?? this.url,
      totalServing: totalServing ?? this.totalServing,
      totalTime: totalTime ?? this.totalTime,
      calories: calories ?? this.calories,
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
        totalTime,
        calories,
      ];
}
