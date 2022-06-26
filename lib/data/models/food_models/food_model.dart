import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/data/models/nutrients_models/nutrients_model.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';
import 'package:yess_nutrition/domain/entities/nutrients_entity.dart';

class FoodModel extends Equatable {
  final String? label;
  final String? category;
  final String? categoryLabel;
  final List<String>? foodContentsLabel;
  final String? image;
  final NutrientsModel? nutrients;

  const FoodModel({
    this.label,
    this.category,
    this.categoryLabel,
    this.foodContentsLabel,
    this.image,
    this.nutrients,
  });

  factory FoodModel.fromJson(Map<String, dynamic> food) {
    return FoodModel(
      label: food['label'] as String?,
      category: food['category'] as String?,
      categoryLabel: food['categoryLabel'] as String?,
      foodContentsLabel: (food['foodContentsLabel'] as String?)?.split('; '),
      image: food['image'] as String?,
      nutrients: NutrientsModel.fromJsonFood(
        food['nutrients'] as Map<String, dynamic>,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'label': label,
      'category': category,
      'categoryLabel': categoryLabel,
      'foodContentsLabel': foodContentsLabel?.join('; '),
      'image': image,
      'nutrients': nutrients?.toJson(),
    };
  }

  FoodEntity toEntity() {
    return FoodEntity(
      label: label ?? '',
      category: category ?? '',
      categoryLabel: categoryLabel ?? '',
      foodContentsLabel: foodContentsLabel ?? <String>[],
      image: image ?? '',
      nutrients: nutrients?.toEntity() ??
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
        label,
        category,
        categoryLabel,
        foodContentsLabel,
        image,
        nutrients,
      ];
}
