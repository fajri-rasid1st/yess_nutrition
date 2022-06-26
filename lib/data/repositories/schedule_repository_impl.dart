import 'package:dartz/dartz.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/data/datasources/schedule_datasources/schedule_data_source.dart';
import 'package:yess_nutrition/data/models/schedule_models/alarm_model.dart';
import 'package:yess_nutrition/domain/entities/alarm_entity.dart';
import 'package:yess_nutrition/domain/repositories/schedule_repository.dart';

class ScheduleRepositoryImpl implements ScheduleRepository {
  final ScheduleDataSource scheduleDataSource;

  ScheduleRepositoryImpl({required this.scheduleDataSource});

  @override
  Future<Either<Failure, String>> createAlarm(AlarmEntity alarm) async {
    try {
      final alarmModel = AlarmModel.fromEntity(alarm);

      final result = await scheduleDataSource.createAlarm(alarmModel);

      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal membuat alarm. Coba lagi.'));
    }
  }

  @override
  Future<Either<Failure, List<AlarmEntity>>> getAlarms(String uid) async {
    try {
      final result = await scheduleDataSource.getAlarms(uid);

      return Right(result.map((model) => model.toEntity()).toList());
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal memuat alarm'));
    }
  }

  @override
  Future<Either<Failure, String>> deleteAlarm(AlarmEntity alarm) async {
    try {
      final alarmModel = AlarmModel.fromEntity(alarm);

      final result = await scheduleDataSource.deleteAlarm(alarmModel);

      return Right(result);
    } on DatabaseException {
      return const Left(DatabaseFailure('Gagal menghapus alarm. Coba lagi.'));
    }
  }
}
