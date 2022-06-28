import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/domain/entities/alarm_entity.dart';

abstract class ScheduleRepository {
  Future<Either<Failure, String>> createAlarm(AlarmEntity alarm);

  Future<Either<Failure, List<AlarmEntity>>> getAlarms(String uid);

  Future<Either<Failure, String>> updateAlarm(AlarmEntity alarm);

  Future<Either<Failure, String>> deleteAlarm(AlarmEntity alarm);
}
