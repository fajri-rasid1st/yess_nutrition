// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/data/datasources/databases/nutritime_helper.dart';
import 'package:yess_nutrition/data/models/schedule_models/nutritime_info.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import '../main_page.dart';

class AlarmNutriTimePage extends StatefulWidget {
  const AlarmNutriTimePage({Key? key}) : super(key: key);

  @override
  State<AlarmNutriTimePage> createState() => _AlarmNutriTimePageState();
}

class _AlarmNutriTimePageState extends State<AlarmNutriTimePage> {
  DateTime? _alarmTime;
  String? _alarmTimeString;
  final NutriTimeHelper _alarmHelper = NutriTimeHelper();
  late Future<List<NutriTimeInfo>> _alarms;
  late List<NutriTimeInfo> _currentAlarms;

  @override
  void initState() {
    _alarmTime = DateTime.now();
    _alarmHelper.initializeDatabase().then((value) {
      print('------database intialized');
      loadAlarms();
    });
    super.initState();
  }

  void loadAlarms() {
    _alarms = _alarmHelper.getAlarms();
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          centerTitle: true,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.popAndPushNamed(context, alarmNutriTime);
            },
          ),
          automaticallyImplyLeading: false,
          title: const Text("Nutri Time"),
        ),
        body: SafeArea(
            child: Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Alarm Waktu Makan',
                style: TextStyle(
                    color: primaryTextColor,
                    fontWeight: FontWeight.w700,
                    fontSize: 24),
              ),
              Expanded(
                child: FutureBuilder<List<NutriTimeInfo>>(
                  future: _alarms,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      _currentAlarms = snapshot.data!;
                      return ListView(
                        children: snapshot.data!.map<Widget>((alarm) {
                          var alarmTime = DateFormat('hh:mm aa')
                              .format(alarm.alarmDateTime);
                          var gradientColor = GradientTemplate
                              .gradientTemplate[alarm.gradientColorIndex]
                              .colors;
                          return Container(
                            margin: const EdgeInsets.only(bottom: 32),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: gradientColor,
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: gradientColor.last.withOpacity(0.4),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                  offset: const Offset(4, 4),
                                ),
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(24)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        const Icon(
                                          Icons.label,
                                          color: Colors.white,
                                          size: 24,
                                        ),
                                        const SizedBox(width: 8),
                                        Text(
                                          alarm.title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'avenir'),
                                        ),
                                      ],
                                    ),
                                    Switch(
                                      onChanged: (bool value) {},
                                      value: true,
                                      activeColor: Colors.white,
                                    ),
                                  ],
                                ),
                                const Text(
                                  'Mon-Fri',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'avenir'),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      alarmTime,
                                      style: const TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'avenir',
                                          fontSize: 24,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    IconButton(
                                        icon: const Icon(Icons.delete),
                                        color: Colors.white,
                                        onPressed: () {
                                          deleteAlarm(alarm.id!);
                                        }),
                                  ],
                                ),
                              ],
                            ),
                          );
                        }).followedBy([
                          if (_currentAlarms.length < 5)
                            DottedBorder(
                              strokeWidth: 2,
                              color: clockOutline,
                              borderType: BorderType.RRect,
                              radius: const Radius.circular(24),
                              dashPattern: const [5, 4],
                              child: Container(
                                width: double.infinity,
                                decoration: const BoxDecoration(
                                  color: clockBG,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(24)),
                                ),
                                child: FlatButton(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 32, vertical: 16),
                                  onPressed: () {
                                    _alarmTimeString = DateFormat('HH:mm')
                                        .format(DateTime.now());
                                    showModalBottomSheet(
                                      useRootNavigator: true,
                                      context: context,
                                      clipBehavior: Clip.antiAlias,
                                      shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(24),
                                        ),
                                      ),
                                      builder: (context) {
                                        return StatefulBuilder(
                                          builder: (context, setModalState) {
                                            return Container(
                                              padding: const EdgeInsets.all(32),
                                              child: Column(
                                                children: [
                                                  FlatButton(
                                                    onPressed: () async {
                                                      var selectedTime =
                                                          await showTimePicker(
                                                        context: context,
                                                        initialTime:
                                                            TimeOfDay.now(),
                                                      );
                                                      if (selectedTime !=
                                                          null) {
                                                        final now =
                                                            DateTime.now();
                                                        var selectedDateTime =
                                                            DateTime(
                                                                now.year,
                                                                now.month,
                                                                now.day,
                                                                selectedTime
                                                                    .hour,
                                                                selectedTime
                                                                    .minute);
                                                        _alarmTime =
                                                            selectedDateTime;
                                                        setModalState(() {
                                                          _alarmTimeString =
                                                              DateFormat(
                                                                      'HH:mm')
                                                                  .format(
                                                                      selectedDateTime);
                                                        });
                                                      }
                                                    },
                                                    child: Text(
                                                      _alarmTimeString!,
                                                      style: const TextStyle(
                                                          fontSize: 32),
                                                    ),
                                                  ),
                                                  const ListTile(
                                                    title: Text('Repeat'),
                                                    trailing: Icon(Icons
                                                        .arrow_forward_ios),
                                                  ),
                                                  const ListTile(
                                                    title: Text('Sound'),
                                                    trailing: Icon(Icons
                                                        .arrow_forward_ios),
                                                  ),
                                                  const ListTile(
                                                    title: Text('Title'),
                                                    trailing: Icon(Icons
                                                        .arrow_forward_ios),
                                                  ),
                                                  FloatingActionButton.extended(
                                                    onPressed: onSaveAlarm,
                                                    icon:
                                                        const Icon(Icons.alarm),
                                                    label: const Text('Save'),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      },
                                    );
                                  },
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset(
                                        'assets/img/Group10.png',
                                        scale: 1.5,
                                      ),
                                      const SizedBox(height: 8),
                                      const Text(
                                        'Add Alarm',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'avenir'),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          else
                            const Center(
                                child: Text(
                              'Only 5 alarms allowed!',
                              style: TextStyle(color: Colors.white),
                            )),
                        ]).toList(),
                      );
                    }
                    return const Center(
                      child: Text(
                        'Loading..',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        )));
  }

  void scheduleAlarm(
      DateTime scheduledNotificationDateTime, NutriTimeInfo alarmInfo) async {
    // ignore: prefer_const_constructors
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'alarm_notif',
      'Channel for Alarm notification',
      icon: 'splash',
      sound: const RawResourceAndroidNotificationSound('a_long_cold_sting'),
      largeIcon: const DrawableResourceAndroidBitmap('splash'),
    );

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
        sound: 'a_long_cold_sting.wav',
        presentAlert: true,
        presentBadge: true,
        presentSound: true);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.schedule(
        0,
        'Waktunya Makan',
        alarmInfo.title,
        scheduledNotificationDateTime,
        platformChannelSpecifics);
  }

  void onSaveAlarm() {
    DateTime scheduleAlarmDateTime;
    if (_alarmTime!.isAfter(DateTime.now())) {
      scheduleAlarmDateTime = _alarmTime!;
    } else {
      scheduleAlarmDateTime = _alarmTime!.add(const Duration(days: 1));
    }

    var alarmInfo = NutriTimeInfo(
      alarmDateTime: scheduleAlarmDateTime,
      gradientColorIndex: _currentAlarms.length,
      title: 'alarm',
    );
    _alarmHelper.insertAlarm(alarmInfo);
    scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
    Navigator.pop(context);
    loadAlarms();
  }

  void deleteAlarm(int id) {
    _alarmHelper.delete(id);
    //unsubscribe for notification
    loadAlarms();
  }
}
