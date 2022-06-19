import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/nutrients_entity.dart';

class NutrientsModel extends Equatable {
  final num? calories;
  final num? protein;
  final num? fat;
  final num? carbohydrate;
  final num? fiber;

  const NutrientsModel({
    this.calories,
    this.protein,
    this.fat,
    this.carbohydrate,
    this.fiber,
  });

  factory NutrientsModel.fromJson(Map<String, dynamic> nutrients) {
    return NutrientsModel(
      calories: nutrients['ENERC_KCAL'],
      protein: nutrients['PROCNT'],
      fat: nutrients['FAT'],
      carbohydrate: nutrients['CHOCDF'],
      fiber: nutrients['FIBTG'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'protein': protein,
      'fat': fat,
      'carbohydrate': carbohydrate,
      'fiber': fiber,
    };
  }

  NutrientsEntity toEntity() {
    return NutrientsEntity(
      calories: calories?.toDouble() ?? 0,
      protein: protein?.toDouble() ?? 0,
      fat: fat?.toDouble() ?? 0,
      carbohydrate: carbohydrate?.toDouble() ?? 0,
      fiber: fiber?.toDouble() ?? 0,
    );
  }

  @override
  List<Object?> get props => [calories, protein, fat, carbohydrate, fiber];
}
