import 'package:equatable/equatable.dart';

class UserNutrientsEntity extends Equatable {
  final String uid;
  final int currentCalories;
  final int maxCalories;
  final int currentCarbohydrate;
  final int maxCarbohydrate;
  final int currentProtein;
  final int maxProtein;
  final int currentFat;
  final int maxFat;
  final DateTime currentDate;

  const UserNutrientsEntity({
    required this.uid,
    this.currentCalories = 0,
    required this.maxCalories,
    this.currentCarbohydrate = 0,
    required this.maxCarbohydrate,
    this.currentProtein = 0,
    required this.maxProtein,
    this.currentFat = 0,
    required this.maxFat,
    required this.currentDate,
  });

  @override
  List<Object> get props => [
        uid,
        currentCalories,
        maxCalories,
        currentCarbohydrate,
        maxCarbohydrate,
        currentProtein,
        maxProtein,
        currentFat,
        maxFat,
        currentDate,
      ];
}
