import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/user_food_schedule_entity.dart';
import 'package:yess_nutrition/domain/repositories/user_firestore_repository.dart';

class ReadUserFoodSchedules {
  final UserFirestoreRepository _repository;

  ReadUserFoodSchedules(this._repository);

  Future<Either<Failure, List<UserFoodScheduleEntity>>> execute(String uid) {
    return _repository.readUserFoodSchedules(uid);
  }
}
