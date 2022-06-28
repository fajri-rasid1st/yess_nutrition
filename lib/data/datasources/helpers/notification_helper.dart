import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static NotificationHelper? _notificationHelper;

  NotificationHelper._internal() {
    _notificationHelper = this;
  }

  factory NotificationHelper() {
    return _notificationHelper ?? NotificationHelper._internal();
  }

  /// Menginisialisasi pengaturan notifikasi
  Future<void> initNotifications(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
  ) async {
    const initSettingsAndroid = AndroidInitializationSettings('app_icon');

    const initSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const initSettings = InitializationSettings(
      android: initSettingsAndroid,
      iOS: initSettingsIOS,
    );

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

  /// Menampilkan notifikasi dengan payload berupa string encoding dari [restaurant]
  Future<void> showNotification(
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    Restaurant restaurant,
  ) async {
    const channelId = '1';
    const channelName = 'channel_01';
    const channelDescription = 'restaurant_channel';

    const androidPlatformChannelSpecifics = AndroidNotificationDetails(
      channelId,
      channelName,
      channelDescription: channelDescription,
      importance: Importance.max,
      priority: Priority.high,
      ticker: 'ticker',
      styleInformation: DefaultStyleInformation(true, true),
    );

    const iOSPlatformChannelSpecifics = IOSNotificationDetails();

    const platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    final title = '<b>${restaurant.name}</b>';
    const body = 'Rekomendasi restaurant untukmu. Klik untuk melihat detail.';

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: jsonEncode(restaurant.toMap()),
    );
  }

  /// Melakukan konfigurasi/listen notifikasi, sehingga mengarah ke halaman
  /// detail restaurant saat notifikasi ditekan
  void configureSelectNotificationSubject(BuildContext context) {
    selectNotificationSubject.stream.listen((payload) {
      final result = jsonDecode(payload);
      final restaurant = Restaurant.fromMap(result);

      Utilities.navigateToDetailScreen(
        context: context,
        restaurant: restaurant,
      );
    });
  }
}
