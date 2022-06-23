import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/nutrients_entity.dart';

class NutrientsTable extends Equatable {
  final double calories;
  final double carbohydrate;
  final double protein;
  final double fat;
  final double fiber;

  const NutrientsTable({
    required this.calories,
    required this.carbohydrate,
    required this.protein,
    required this.fat,
    required this.fiber,
  });

  factory NutrientsTable.fromEntity(NutrientsEntity nutrients) {
    return NutrientsTable(
      calories: nutrients.calories,
      carbohydrate: nutrients.carbohydrate,
      protein: nutrients.protein,
      fat: nutrients.fat,
      fiber: nutrients.fiber,
    );
  }

  factory NutrientsTable.fromString(String nutrients) {
    final nutrientsList = nutrients.split('; ');

    return NutrientsTable(
      calories: double.parse(nutrientsList[0]),
      carbohydrate: double.parse(nutrientsList[1]),
      protein: double.parse(nutrientsList[2]),
      fat: double.parse(nutrientsList[3]),
      fiber: double.parse(nutrientsList[4]),
    );
  }

  NutrientsEntity toEntity() {
    return NutrientsEntity(
      calories: calories,
      carbohydrate: carbohydrate,
      protein: protein,
      fat: fat,
      fiber: fiber,
    );
  }

  @override
  String toString() => '$calories; $carbohydrate; $protein; $fat; $fiber';

  @override
  List<Object> get props => [calories, carbohydrate, protein, fat, fiber];
}
