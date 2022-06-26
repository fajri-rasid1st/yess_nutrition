import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/alarm_entity.dart';
import 'package:yess_nutrition/domain/repositories/schedule_repository.dart';

class GetAlarms {
  final ScheduleRepository _repository;

  GetAlarms(this._repository);

  Future<Either<Failure, List<AlarmEntity>>> execute(String uid) {
    return _repository.getAlarms(uid);
  }
}
