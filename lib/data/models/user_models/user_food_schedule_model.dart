import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/data/models/nutrients_models/nutrients_table.dart';
import 'package:yess_nutrition/domain/entities/user_food_schedule_entity.dart';

class UserFoodScheduleModel extends Equatable {
  final String id;
  final String uid;
  final String foodName;
  final String foodImage;
  final NutrientsTable foodNutrients;
  final int totalServing;
  final String scheduleType;
  final bool isDone;

  const UserFoodScheduleModel({
    required this.id,
    required this.uid,
    required this.foodName,
    required this.foodImage,
    required this.foodNutrients,
    required this.totalServing,
    required this.scheduleType,
    required this.isDone,
  });

  factory UserFoodScheduleModel.fromEntity(UserFoodScheduleEntity schedule) {
    return UserFoodScheduleModel(
      id: schedule.id,
      uid: schedule.uid,
      foodName: schedule.foodName,
      foodImage: schedule.foodImage,
      foodNutrients: NutrientsTable.fromEntity(schedule.foodNutrients),
      totalServing: schedule.totalServing,
      scheduleType: schedule.scheduleType,
      isDone: schedule.isDone,
    );
  }

  factory UserFoodScheduleModel.fromDocument(Map<String, dynamic> schedule) {
    return UserFoodScheduleModel(
      id: schedule['id'],
      uid: schedule['uid'],
      foodName: schedule['foodName'],
      foodImage: schedule['foodImage'],
      foodNutrients: NutrientsTable.fromString(schedule['foodNutrients']),
      totalServing: schedule['totalServing'],
      scheduleType: schedule['scheduleType'],
      isDone: schedule['isDone'],
    );
  }

  UserFoodScheduleEntity toEntity() {
    return UserFoodScheduleEntity(
      id: id,
      uid: uid,
      foodName: foodName,
      foodImage: foodImage,
      foodNutrients: foodNutrients.toEntity(),
      totalServing: totalServing,
      scheduleType: scheduleType,
      isDone: isDone,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'uid': uid,
      'foodName': foodName,
      'foodImage': foodImage,
      'foodNutrients': foodNutrients.toString(),
      'totalServing': totalServing,
      'scheduleType': scheduleType,
      'isDone': isDone,
    };
  }

  @override
  List<Object> get props => [
        id,
        uid,
        foodName,
        foodImage,
        foodNutrients,
        totalServing,
        scheduleType,
        isDone,
      ];
}
