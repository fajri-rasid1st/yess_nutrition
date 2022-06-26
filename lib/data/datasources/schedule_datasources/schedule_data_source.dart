import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/data/datasources/database/database_helper.dart';
import 'package:yess_nutrition/data/models/schedule_models/alarm_model.dart';

abstract class ScheduleDataSource {
  Future<String> createAlarm(AlarmModel alarm);

  Future<List<AlarmModel>> getAlarms(String uid);

  Future<String> deleteAlarm(AlarmModel alarm);
}

class ScheduleDataSourceImpl implements ScheduleDataSource {
  final DatabaseHelper databaseHelper;

  ScheduleDataSourceImpl({required this.databaseHelper});

  @override
  Future<String> createAlarm(AlarmModel alarm) async {
    try {
      await databaseHelper.createAlarm(alarm);

      return 'Alarm berhasil dibuat';
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
  Future<String> deleteAlarm(AlarmModel alarm) async {
    try {
      await databaseHelper.deleteAlarm(alarm);

      return 'Alarm berhasil dihapus';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}

// List<AlarmScheduleModel> alarms = [
//   AlarmScheduleModel(
//     title: 'Sarapan',
//     alarmDateTime: DateTime.now().add(const Duration(hours: 1)),
//     gradientColorIndex: 0,
//   ),
//   AlarmScheduleModel(
//     title: 'Makan Siang',
//     alarmDateTime: DateTime.now().add(const Duration(hours: 1)),
//     gradientColorIndex: 1,
//   ),
//   AlarmScheduleModel(
//     title: 'Makan Malam',
//     alarmDateTime: DateTime.now().add(const Duration(hours: 1)),
//     gradientColorIndex: 2,
//   ),
// ];
