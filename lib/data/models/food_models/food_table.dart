import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/data/models/nutrients_models/nutrients_table.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';

const foodHistoryTable = 'food_history_table';

class FoodTable extends Equatable {
  final int? id;
  final String uid;
  final String label;
  final String category;
  final String categoryLabel;
  final List<String> foodContentsLabel;
  final String image;
  final NutrientsTable nutrients;
  final DateTime createdAt;

  const FoodTable({
    this.id,
    required this.uid,
    required this.label,
    required this.category,
    required this.categoryLabel,
    required this.foodContentsLabel,
    required this.image,
    required this.nutrients,
    required this.createdAt,
  });

  factory FoodTable.fromEntity(FoodEntity food) {
    return FoodTable(
      id: food.id,
      uid: food.uid!,
      label: food.label,
      category: food.category,
      categoryLabel: food.categoryLabel,
      foodContentsLabel: food.foodContentsLabel,
      image: food.image,
      nutrients: NutrientsTable.fromEntity(food.nutrients),
      createdAt: food.createdAt!,
    );
  }

  factory FoodTable.fromMap(Map<String, dynamic> food) {
    return FoodTable(
      id: food['id'] as int,
      uid: food['uid'] as String,
      label: food['label'] as String,
      category: food['category'] as String,
      categoryLabel: food['categoryLabel'] as String,
      foodContentsLabel: (food['foodContentsLabel'] as String).split('; '),
      image: food['image'] as String,
      nutrients: NutrientsTable.fromString(food['nutrients'] as String),
      createdAt: DateTime.parse(food['createdAt'] as String),
    );
  }

  FoodEntity toEntity() {
    return FoodEntity.history(
      id: id,
      uid: uid,
      label: label,
      category: category,
      categoryLabel: categoryLabel,
      foodContentsLabel: foodContentsLabel,
      image: image,
      nutrients: nutrients.toEntity(),
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uid': uid,
      'label': label,
      'category': category,
      'categoryLabel': categoryLabel,
      'foodContentsLabel': foodContentsLabel.join('; '),
      'image': image,
      'nutrients': nutrients.toString(),
      'createdAt': createdAt.toIso8601String(),
    };
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
