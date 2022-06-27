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

  UserNutrientsEntity copyWith({
    String? uid,
    int? currentCalories,
    int? maxCalories,
    int? currentCarbohydrate,
    int? maxCarbohydrate,
    int? currentProtein,
    int? maxProtein,
    int? currentFat,
    int? maxFat,
    DateTime? currentDate,
  }) {
    return UserNutrientsEntity(
      uid: uid ?? this.uid,
      currentCalories: currentCalories ?? this.currentCalories,
      maxCalories: maxCalories ?? this.maxCalories,
      currentCarbohydrate: currentCarbohydrate ?? this.currentCarbohydrate,
      maxCarbohydrate: maxCarbohydrate ?? this.maxCarbohydrate,
      currentProtein: currentProtein ?? this.currentProtein,
      maxProtein: maxProtein ?? this.maxProtein,
      currentFat: currentFat ?? this.currentFat,
      maxFat: maxFat ?? this.maxFat,
      currentDate: currentDate ?? this.currentDate,
    );
  }

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
