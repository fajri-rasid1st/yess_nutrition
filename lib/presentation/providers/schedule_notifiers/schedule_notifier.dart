import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/alarm_entity.dart';
import 'package:yess_nutrition/domain/usecases/schedule_usecases/create_alarm.dart';
import 'package:yess_nutrition/domain/usecases/schedule_usecases/delete_alarm.dart';
import 'package:yess_nutrition/domain/usecases/schedule_usecases/get_alarms.dart';

class ScheduleNotifier extends ChangeNotifier {
  final CreateAlarm createAlarmUseCase;
  final GetAlarms getAlarmsUseCase;
  final DeleteAlarm deleteAlarmUseCase;

  ScheduleNotifier({
    required this.createAlarmUseCase,
    required this.getAlarmsUseCase,
    required this.deleteAlarmUseCase,
  });

  RequestState _state = RequestState.empty;
  RequestState get state => _state;

  String _message = '';
  String get message => _message;

  List<AlarmEntity> _alarms = <AlarmEntity>[];
  List<AlarmEntity> get bookmarks => _alarms;

  Future<void> createAlarm(AlarmEntity alarm) async {
    final result = await createAlarmUseCase.execute(alarm);

    result.fold(
      (failure) => _message = failure.message,
      (success) => _message = success,
    );
  }

  Future<void> getAlarms(String uid) async {
    final result = await getAlarmsUseCase.execute(uid);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.error;
      },
      (alarms) {
        _alarms = alarms;
        _state = RequestState.success;
      },
    );

    notifyListeners();
  }

  Future<void> deleteAlarm(AlarmEntity alarm) async {
    final result = await deleteAlarmUseCase.execute(alarm);

    result.fold(
      (failure) => _message = failure.message,
      (success) => _message = success,
    );
  }
}
