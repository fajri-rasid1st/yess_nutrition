import 'package:equatable/equatable.dart';

import 'package:yess_nutrition/domain/entities/nutrients_entity.dart';

class NutrientsTable extends Equatable {
  final double calories;
  final double protein;
  final double fat;
  final double carbohydrate;
  final double fiber;

  const NutrientsTable({
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbohydrate,
    required this.fiber,
  });

  factory NutrientsTable.fromEntity(NutrientsEntity nutrients) {
    return NutrientsTable(
      calories: nutrients.calories,
      protein: nutrients.protein,
      fat: nutrients.fat,
      carbohydrate: nutrients.carbohydrate,
      fiber: nutrients.fiber,
    );
  }

  factory NutrientsTable.fromString(String nutrients) {
    final nutrientsList = nutrients.split('; ');

    return NutrientsTable(
      calories: double.parse(nutrientsList[0]),
      protein: double.parse(nutrientsList[1]),
      fat: double.parse(nutrientsList[2]),
      carbohydrate: double.parse(nutrientsList[3]),
      fiber: double.parse(nutrientsList[4]),
    );
  }

  NutrientsEntity toEntity() {
    return NutrientsEntity(
      calories: calories,
      protein: protein,
      fat: fat,
      carbohydrate: carbohydrate,
      fiber: fiber,
    );
  }

  @override
  String toString() => '$calories; $protein; $fat; $carbohydrate; $fiber';

  @override
  List<Object> get props => [calories, protein, fat, carbohydrate, fiber];
}
