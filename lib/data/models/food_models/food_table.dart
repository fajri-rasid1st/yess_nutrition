import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/data/models/food_models/nutrients_table.dart';
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

  const FoodTable({
    required this.uid,
    required this.foodId,
    required this.label,
    required this.category,
    required this.categoryLabel,
    required this.foodContentLabel,
    required this.image,
    required this.nutrients,
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
    );
  }

  factory FoodTable.fromMap(Map<String, dynamic> food) {
    return FoodTable(
      uid: food['uid'],
      foodId: food['foodId'],
      label: food['label'],
      category: food['category'],
      categoryLabel: food['categoryLabel'],
      foodContentLabel: (food['foodContentLabel'] as String).split('; '),
      image: food['image'],
      nutrients: NutrientsTable.fromString((food['nutrients'] as String)),
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
      ];
}
