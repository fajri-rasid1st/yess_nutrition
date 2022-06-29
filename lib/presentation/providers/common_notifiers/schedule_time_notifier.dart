import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ScheduleTimeNotifier extends ChangeNotifier {
  late Time _time;
  Time get time => _time;

  setTimeFromTimeOfDay(TimeOfDay value) {
    _time = Time.fromTimeOfDay(value);
    notifyListeners();
  }

  late String _timeString;
  String get timeString => _timeString;

  setTimeStringFromDateTime(DateTime value) {
    _timeString = DateFormat('hh:mm a').format(value);
    notifyListeners();
  }
}
