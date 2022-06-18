import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/nutrients_entity.dart';

class FoodEntity extends Equatable {
  final String foodId;
  final String label;
  final String category;
  final String categoryLabel;
  final String image;
  final NutrientsEntity nutrients;

  const FoodEntity({
    required this.foodId,
    required this.label,
    required this.category,
    required this.categoryLabel,
    required this.image,
    required this.nutrients,
  });

  @override
  List<Object> get props => [
        foodId,
        label,
        category,
        categoryLabel,
        image,
        nutrients,
      ];
}
