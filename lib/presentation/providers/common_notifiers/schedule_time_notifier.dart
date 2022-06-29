import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleTimeNotifier extends ChangeNotifier {
  Time _time = Time.fromTimeOfDay(TimeOfDay.now());
  Time get time => _time;

  setTimeFromTimeOfDay(TimeOfDay value) {
    _time = Time.fromTimeOfDay(value);
    notifyListeners();
  }

  String _timeString = DateFormat('hh:mm a').format(DateTime.now());
  String get timeString => _timeString;

  setTimeStringFromDateTime(DateTime value) {
    _timeString = DateFormat('hh:mm a').format(value);
    notifyListeners();
  }
}
