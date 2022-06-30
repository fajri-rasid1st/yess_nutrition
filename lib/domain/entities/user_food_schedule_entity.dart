import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/nutrients_entity.dart';

class UserFoodScheduleEntity extends Equatable {
  final String id;
  final String uid;
  final String foodName;
  final String foodImage;
  final NutrientsEntity foodNutrients;
  final int totalServing;
  final String scheduleType;
  final bool isDone;

  const UserFoodScheduleEntity({
    required this.id,
    required this.uid,
    required this.foodName,
    required this.foodImage,
    required this.foodNutrients,
    required this.totalServing,
    required this.scheduleType,
    required this.isDone,
  });

  UserFoodScheduleEntity copyWith({
    String? id,
    String? uid,
    String? foodName,
    String? foodImage,
    NutrientsEntity? foodNutrients,
    int? totalServing,
    String? scheduleType,
    bool? isDone,
  }) {
    return UserFoodScheduleEntity(
      id: id ?? this.id,
      uid: uid ?? this.uid,
      foodName: foodName ?? this.foodName,
      foodImage: foodImage ?? this.foodImage,
      foodNutrients: foodNutrients ?? this.foodNutrients,
      totalServing: totalServing ?? this.totalServing,
      scheduleType: scheduleType ?? this.scheduleType,
      isDone: isDone ?? this.isDone,
    );
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
