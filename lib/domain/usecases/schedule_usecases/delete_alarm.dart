import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/alarm_entity.dart';
import 'package:yess_nutrition/domain/repositories/schedule_repository.dart';

class DeleteAlarm {
  final ScheduleRepository _repository;

  DeleteAlarm(this._repository);

  Future<Either<Failure, String>> execute(AlarmEntity alarm) {
    return _repository.deleteAlarm(alarm);
  }
}
