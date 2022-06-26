import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/nutrients_entity.dart';

class FoodEntity extends Equatable {
  final int? id;
  final String? uid;
  final String label;
  final String category;
  final String categoryLabel;
  final List<String> foodContentsLabel;
  final String image;
  final NutrientsEntity nutrients;
  final DateTime? createdAt;

  const FoodEntity({
    this.id,
    this.uid,
    required this.label,
    required this.category,
    required this.categoryLabel,
    required this.foodContentsLabel,
    required this.image,
    required this.nutrients,
    this.createdAt,
  });

  const FoodEntity.history({
    required this.id,
    required this.uid,
    required this.label,
    required this.category,
    required this.categoryLabel,
    required this.foodContentsLabel,
    required this.image,
    required this.nutrients,
    required this.createdAt,
  });

  FoodEntity copyWith({
    int? id,
    String? uid,
    String? label,
    String? category,
    String? categoryLabel,
    List<String>? foodContentsLabel,
    String? image,
    NutrientsEntity? nutrients,
    DateTime? createdAt,
  }) {
    return FoodEntity(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      label: label ?? this.label,
      category: category ?? this.category,
      categoryLabel: categoryLabel ?? this.categoryLabel,
      foodContentsLabel: foodContentsLabel ?? this.foodContentsLabel,
      image: image ?? this.image,
      nutrients: nutrients ?? this.nutrients,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        uid,
        label,
        category,
        categoryLabel,
        foodContentsLabel,
        image,
        nutrients,
        createdAt,
      ];
}
