import 'package:equatable/equatable.dart';

class NutrientsEntity extends Equatable {
  final double calories;
  final double carbohydrate;
  final double protein;
  final double fat;
  final double fiber;

  const NutrientsEntity({
    required this.calories,
    required this.carbohydrate,
    required this.protein,
    required this.fat,
    required this.fiber,
  });

  NutrientsEntity multiplyBy({required int value}) {
    return NutrientsEntity(
      calories: (calories * value).roundToDouble(),
      carbohydrate: (carbohydrate * value).roundToDouble(),
      protein: (protein * value).roundToDouble(),
      fat: (fat * value).roundToDouble(),
      fiber: (fiber * value).roundToDouble(),
    );
  }

  @override
  List<Object> get props => [calories, carbohydrate, protein, fat, fiber];
}
