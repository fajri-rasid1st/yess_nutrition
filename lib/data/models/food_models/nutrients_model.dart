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
      calories: calories?.toDouble() ?? -1,
      protein: protein?.toDouble() ?? -1,
      fat: fat?.toDouble() ?? -1,
      carbohydrate: carbohydrate?.toDouble() ?? -1,
      fiber: fiber?.toDouble() ?? -1,
    );
  }

  @override
  List<Object?> get props => [calories, protein, fat, carbohydrate, fiber];
}
