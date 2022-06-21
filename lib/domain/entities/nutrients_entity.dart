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

  @override
  List<Object> get props => [calories, carbohydrate, protein, fat, fiber];
}
