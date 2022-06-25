import 'package:yess_nutrition/data/models/schedule_models/nutritime_info.dart';

List<NutriTimeInfo> alarms = [
  NutriTimeInfo(
      title: 'Sarapan',
      alarmDateTime: DateTime.now().add(const Duration(hours: 1)),
      gradientColorIndex: 0),
  NutriTimeInfo(
      title: 'Makan Siang',
      alarmDateTime: DateTime.now().add(const Duration(hours: 1)),
      gradientColorIndex: 1),
  NutriTimeInfo(
      title: 'Makan Malam',
      alarmDateTime: DateTime.now().add(const Duration(hours: 1)),
      gradientColorIndex: 2),
];
