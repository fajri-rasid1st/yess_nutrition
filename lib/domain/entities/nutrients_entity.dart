import 'package:equatable/equatable.dart';

class NutrientsEntity extends Equatable {
  final double calories;
  final double protein;
  final double fat;
  final double carbohydrate;
  final double fiber;

  const NutrientsEntity({
    required this.calories,
    required this.protein,
    required this.fat,
    required this.carbohydrate,
    required this.fiber,
  });

  @override
  List<Object> get props => [calories, protein, fat, carbohydrate, fiber];
}
