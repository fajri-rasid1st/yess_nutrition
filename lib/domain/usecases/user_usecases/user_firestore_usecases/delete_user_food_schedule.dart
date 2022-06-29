import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/user_food_schedule_entity.dart';
import 'package:yess_nutrition/domain/repositories/user_firestore_repository.dart';

class DeleteUserFoodSchedule {
  final UserFirestoreRepository _repository;

  DeleteUserFoodSchedule(this._repository);

  Future<Either<Failure, String>> execute(UserFoodScheduleEntity schedule) {
    return _repository.deleteUserFoodSchedule(schedule);
  }
}
