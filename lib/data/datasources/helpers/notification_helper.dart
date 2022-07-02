import 'package:day_night_time_picker/lib/state/time.dart' as time;
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rxdart/rxdart.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:yess_nutrition/common/utils/routes.dart';

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
      selectNotificationSubject.add(details.payload ?? '');
    }

    await flutterLocalNotificationsPlugin.initialize(
      initSettings,
      onSelectNotification: (payload) async {
        selectNotificationSubject.add(payload ?? '');
      },
    );
  }

  /// Determine location and timezone
  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();

    final timeZone = await FlutterNativeTimezone.getLocalTimezone();

    if (timeZone != 'GMT') {
      tz.setLocalLocation(tz.getLocation(timeZone));
    } else {
      tz.setLocalLocation(tz.getLocation('Asia/Jakarta'));
    }
  }

  /// Schedule notification
  Future<void> scheduleNotification({
    required int id,
    required String uid,
    required String title,
    required time.Time time,
  }) async {
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

    final platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    final header = '<b>$title</b>';
    const body = 'Waktunya Anda untuk makan! Lihat jadwal makanan Anda.';

    await flutterLocalNotificationsPlugin.zonedSchedule(
      id,
      header,
      body,
      _convertTime(time),
      platformChannelSpecifics,
      payload: uid,
      androidAllowWhileIdle: true,
      matchDateTimeComponents: DateTimeComponents.time,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  /// Convert Datetime to TZDateTime for notifications
  tz.TZDateTime _convertTime(time.Time time) {
    final now = tz.TZDateTime.now(tz.local);

    final scheduleDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
    );

    if (scheduleDate.isBefore(now)) {
      return scheduleDate.add(const Duration(days: 1));
    }

    return scheduleDate;
  }

  /// Configure selected notification subject. Navigate to schedule page
  /// when notification on tapped.
  void configureSelectNotificationSubject(BuildContext context) {
    selectNotificationSubject.stream.listen((payload) {
      Navigator.pushNamed(context, scheduleAlarmRoute, arguments: payload);
    });
  }

  /// Remove specific schedule
  Future<void> removeSchedule(int id) async {
    return await flutterLocalNotificationsPlugin.cancel(id);
  }
}
