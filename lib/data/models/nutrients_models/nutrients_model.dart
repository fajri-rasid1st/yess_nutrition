import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/nutrients_entity.dart';

class NutrientsModel extends Equatable {
  final num? calories;
  final num? carbohydrate;
  final num? protein;
  final num? fat;
  final num? fiber;

  const NutrientsModel({
    this.calories,
    this.carbohydrate,
    this.protein,
    this.fat,
    this.fiber,
  });

  factory NutrientsModel.fromJsonFood(Map<String, dynamic> nutrients) {
    return NutrientsModel(
      calories: nutrients['ENERC_KCAL'] as num?,
      carbohydrate: nutrients['CHOCDF'] as num?,
      protein: nutrients['PROCNT'] as num?,
      fat: nutrients['FAT'] as num?,
      fiber: nutrients['FIBTG'] as num?,
    );
  }

  factory NutrientsModel.fromJsonRecipe(Map<String, dynamic> nutrients) {
    return NutrientsModel(
      calories:
          (nutrients['ENERC_KCAL'] as Map<String, dynamic>)['quantity'] as num?,
      carbohydrate:
          (nutrients['CHOCDF'] as Map<String, dynamic>)['quantity'] as num?,
      protein:
          (nutrients['PROCNT'] as Map<String, dynamic>)['quantity'] as num?,
      fat: (nutrients['FAT'] as Map<String, dynamic>)['quantity'] as num?,
      fiber: (nutrients['FIBTG'] as Map<String, dynamic>)['quantity'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'carbohydrate': carbohydrate,
      'protein': protein,
      'fat': fat,
      'fiber': fiber,
    };
  }

  NutrientsEntity toEntity() {
    return NutrientsEntity(
      calories: calories?.toDouble() ?? 0,
      carbohydrate: carbohydrate?.toDouble() ?? 0,
      protein: protein?.toDouble() ?? 0,
      fat: fat?.toDouble() ?? 0,
      fiber: fiber?.toDouble() ?? 0,
    );
  }

  @override
  List<Object?> get props => [calories, carbohydrate, protein, fat, fiber];
}
