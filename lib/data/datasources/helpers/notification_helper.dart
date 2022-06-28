import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/domain/entities/entities.dart';

final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _notificationHelper;

  NotificationHelper._instance() {
    _notificationHelper = this;
  }

  factory NotificationHelper() {
    return _notificationHelper ?? NotificationHelper._instance();
  }

  /// Initialize notification
  Future<void> initNotifications() async {
    await _configureLocalTimeZone();

    const initSettingsAndroid = AndroidInitializationSettings('app_icon');
    const initSettings = InitializationSettings(android: initSettingsAndroid);

    final details =
        await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();

    if (details != null && details.didNotificationLaunchApp) {
      selectNotificationSubject.add(details.payload ?? 'empty_payload');
    }

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onSelectNotification: (payload) async {
        selectNotificationSubject.add(payload ?? 'empty_payload');
      },
    );
  }

  /// Schedule notification
  Future<void> scheduleNotification(
    int id,
    int hour,
    int minutes,
    String uid,
    AlarmEntity alarm,
  ) async {
    final channelId = 'channel_$id';
    const channelName = 'my_channel';
    const channelDescription = 'my_description_channel';

    final androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      sound: const RawResourceAndroidNotificationSound('slow_spring_board'),
      styleInformation: const DefaultStyleInformation(true, true),
    );

    final platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    final title = '<b>${alarm.title}</b>';
    const body = 'Waktunya Anda untuk makan. Lihat jadwal makanan Anda.';

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      _convertTime(hour, minutes),
      platformChannelSpecifics,
      payload: uid,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// Determine location and timezone
  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();

    final String timeZone = await FlutterNativeTimezone.getLocalTimezone();

    tz.setLocalLocation(tz.getLocation(timeZone));
  }

  /// Convert Datetime to TZDateTime for notifications
  tz.TZDateTime _convertTime(int hour, int minutes) {
    final now = tz.TZDateTime.now(tz.local);

    var scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      hour,
      minutes,
    );

    if (scheduleDate.isBefore(now)) {
      scheduleDate = scheduleDate.add(const Duration(days: 1));
    }

    return scheduleDate;
  }

  /// Configure selected notification subject. Navigate to schedule page
  /// when notification on tapped.
  void configureSelectNotificationSubject(BuildContext context) {
    selectNotificationSubject.stream.listen((payload) {
      Navigator.pushNamed(context, scheduleRoute, arguments: payload);
    });
  }

  /// Remove specific schedule
  Future<void> removeSchedule(int id) async {
    return await flutterLocalNotificationsPlugin.cancel(id);
  }

  /// Clear all schedules
  Future<void> clearSchedules() async {
    return await flutterLocalNotificationsPlugin.cancelAll();
  }
}
