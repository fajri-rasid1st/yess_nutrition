import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/user_nutrients_entity.dart';

class UserNutrientsModel extends Equatable {
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

  const UserNutrientsModel({
    required this.uid,
    required this.currentCalories,
    required this.maxCalories,
    required this.currentCarbohydrate,
    required this.maxCarbohydrate,
    required this.currentProtein,
    required this.maxProtein,
    required this.currentFat,
    required this.maxFat,
    required this.currentDate,
  });

  factory UserNutrientsModel.fromEntity(UserNutrientsEntity userNutrients) {
    return UserNutrientsModel(
      uid: userNutrients.uid,
      currentCalories: userNutrients.currentCalories,
      maxCalories: userNutrients.maxCalories,
      currentCarbohydrate: userNutrients.currentCarbohydrate,
      maxCarbohydrate: userNutrients.maxCarbohydrate,
      currentProtein: userNutrients.currentProtein,
      maxProtein: userNutrients.maxProtein,
      currentFat: userNutrients.currentFat,
      maxFat: userNutrients.maxFat,
      currentDate: userNutrients.currentDate,
    );
  }

  factory UserNutrientsModel.fromDocument(Map<String, dynamic> userNutrients) {
    return UserNutrientsModel(
      uid: userNutrients['uid'],
      currentCalories: userNutrients['currentCalories'],
      maxCalories: userNutrients['maxCalories'],
      currentCarbohydrate: userNutrients['currentCarbohydrate'],
      maxCarbohydrate: userNutrients['maxCarbohydrate'],
      currentProtein: userNutrients['currentProtein'],
      maxProtein: userNutrients['maxProtein'],
      currentFat: userNutrients['currentFat'],
      maxFat: userNutrients['maxFat'],
      currentDate: userNutrients['currentDate'],
    );
  }

  UserNutrientsEntity toEntity() {
    return UserNutrientsEntity(
      uid: uid,
      currentCalories: currentCalories,
      maxCalories: maxCalories,
      currentCarbohydrate: currentCarbohydrate,
      maxCarbohydrate: maxCarbohydrate,
      currentProtein: currentProtein,
      maxProtein: maxProtein,
      currentFat: currentFat,
      maxFat: maxFat,
      currentDate: currentDate,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'uid': uid,
      'currentCalories': currentCalories,
      'maxCalories': maxCalories,
      'currentCarbohydrate': currentCarbohydrate,
      'maxCarbohydrate': maxCarbohydrate,
      'currentProtein': currentProtein,
      'maxProtein': maxProtein,
      'currentFat': currentFat,
      'maxFat': maxFat,
      'currentDate': currentDate,
    };
  }

  @override
  List<Object?> get props => [
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
