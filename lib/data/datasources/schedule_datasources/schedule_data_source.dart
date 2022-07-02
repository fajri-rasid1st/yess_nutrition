import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/data/datasources/helpers/database_helper.dart';
import 'package:yess_nutrition/data/models/schedule_models/alarm_model.dart';

abstract class ScheduleDataSource {
  Future<String> createAlarm(AlarmModel alarm);

  Future<List<AlarmModel>> getAlarms(String uid);

  Future<String> updateAlarm(AlarmModel alarm);

  Future<String> deleteAlarm(AlarmModel alarm);
}

class ScheduleDataSourceImpl implements ScheduleDataSource {
  final DatabaseHelper databaseHelper;

  ScheduleDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> createAlarm(AlarmModel alarm) async {
    try {
      await databaseHelper.createAlarm(alarm);

      return 'Berhasil menambahkan alarm notifikasi';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<List<AlarmModel>> getAlarms(String uid) async {
    try {
      final alarms = await databaseHelper.getAlarms(uid);

      return alarms;
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> updateAlarm(AlarmModel alarm) async {
    try {
      await databaseHelper.updateAlarm(alarm);

      return 'Alarm notifikasi telah diedit';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> deleteAlarm(AlarmModel alarm) async {
    try {
      await databaseHelper.deleteAlarm(alarm);

      return 'Berhasil menghapus alarm notifikasi';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
