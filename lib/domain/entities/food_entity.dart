import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/nutrients_entity.dart';

class FoodEntity extends Equatable {
  final String? uid;
  final String foodId;
  final String label;
  final String category;
  final String categoryLabel;
  final List<String> foodContentLabel;
  final String image;
  final NutrientsEntity nutrients;
  final DateTime? createdAt;

  const FoodEntity({
    this.uid,
    required this.foodId,
    required this.label,
    required this.category,
    required this.categoryLabel,
    required this.foodContentLabel,
    required this.image,
    required this.nutrients,
    this.createdAt,
  });

  const FoodEntity.history({
    required this.uid,
    required this.foodId,
    required this.label,
    required this.category,
    required this.categoryLabel,
    required this.foodContentLabel,
    required this.image,
    required this.nutrients,
    required this.createdAt,
  });

  FoodEntity copyWith({
    String? uid,
    String? foodId,
    String? label,
    String? category,
    String? categoryLabel,
    List<String>? foodContentLabel,
    String? image,
    NutrientsEntity? nutrients,
    DateTime? createdAt,
  }) {
    return FoodEntity(
      uid: uid ?? this.uid,
      foodId: foodId ?? this.foodId,
      label: label ?? this.label,
      category: category ?? this.category,
      categoryLabel: categoryLabel ?? this.categoryLabel,
      foodContentLabel: foodContentLabel ?? this.foodContentLabel,
      image: image ?? this.image,
      nutrients: nutrients ?? this.nutrients,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        uid,
        foodId,
        label,
        category,
        categoryLabel,
        foodContentLabel,
        image,
        nutrients,
        createdAt,
      ];
}
