import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/data/models/food_models/nutrients_model.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';
import 'package:yess_nutrition/domain/entities/nutrients_entity.dart';

class FoodModel extends Equatable {
  final String? foodId;
  final String? label;
  final String? category;
  final String? categoryLabel;
  final List<String>? foodContentLabel;
  final String? image;
  final NutrientsModel? nutrients;

  const FoodModel({
    this.foodId,
    this.label,
    this.category,
    this.categoryLabel,
    this.foodContentLabel,
    this.image,
    this.nutrients,
  });

  factory FoodModel.fromJson(Map<String, dynamic> food) {
    return FoodModel(
      foodId: food['foodId'],
      label: food['label'],
      category: food['category'],
      categoryLabel: food['categoryLabel'],
      foodContentLabel: (food['foodContentLabel'] as String?)?.split('; '),
      image: food['image'],
      nutrients: NutrientsModel.fromJson(food['nutrients']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'foodId': foodId,
      'label': label,
      'category': category,
      'categoryLabel': categoryLabel,
      'foodContentLabel': foodContentLabel?.join('; '),
      'image': image,
      'nutrients': nutrients?.toJson(),
    };
  }

  FoodEntity toEntity() {
    return FoodEntity(
      foodId: foodId ?? '',
      label: label ?? '',
      category: category ?? '',
      categoryLabel: categoryLabel ?? '',
      foodContentLabel: foodContentLabel ?? <String>[],
      image: image ?? '',
      nutrients: nutrients?.toEntity() ??
          const NutrientsEntity(
            calories: -1,
            protein: -1,
            fat: -1,
            carbohydrate: -1,
            fiber: -1,
          ),
    );
  }

  @override
  List<Object?> get props => [
        foodId,
        label,
        category,
        categoryLabel,
        foodContentLabel,
        image,
        nutrients,
      ];
}
