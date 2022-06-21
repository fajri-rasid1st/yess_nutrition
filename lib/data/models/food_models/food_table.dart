import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/data/models/nutrients_models/nutrients_table.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';

const foodHistoryTable = 'food_history_table';

class FoodTable extends Equatable {
  final String uid;
  final String foodId;
  final String label;
  final String category;
  final String categoryLabel;
  final List<String> foodContentLabel;
  final String image;
  final NutrientsTable nutrients;
  final DateTime createdAt;

  const FoodTable({
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

  factory FoodTable.fromEntity(FoodEntity food) {
    return FoodTable(
      uid: food.uid!,
      foodId: food.foodId,
      label: food.label,
      category: food.category,
      categoryLabel: food.categoryLabel,
      foodContentLabel: food.foodContentLabel,
      image: food.image,
      nutrients: NutrientsTable.fromEntity(food.nutrients),
      createdAt: food.createdAt!,
    );
  }

  factory FoodTable.fromMap(Map<String, dynamic> food) {
    return FoodTable(
      uid: food['uid'] as String,
      foodId: food['foodId'] as String,
      label: food['label'] as String,
      category: food['category'] as String,
      categoryLabel: food['categoryLabel'] as String,
      foodContentLabel: (food['foodContentLabel'] as String).split('; '),
      image: food['image'] as String,
      nutrients: NutrientsTable.fromString(food['nutrients'] as String),
      createdAt: DateTime.parse(food['createdAt'] as String),
    );
  }

  FoodEntity toEntity() {
    return FoodEntity.history(
      uid: uid,
      foodId: foodId,
      label: label,
      category: category,
      categoryLabel: categoryLabel,
      foodContentLabel: foodContentLabel,
      image: image,
      nutrients: nutrients.toEntity(),
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'foodId': foodId,
      'label': label,
      'category': category,
      'categoryLabel': categoryLabel,
      'foodContentLabel': foodContentLabel.join('; '),
      'image': image,
      'nutrients': nutrients.toString(),
      'createdAt': createdAt.toIso8601String(),
    };
  }

  @override
  List<Object> get props => [
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
