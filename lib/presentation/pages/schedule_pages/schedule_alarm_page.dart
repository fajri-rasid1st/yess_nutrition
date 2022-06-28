import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/alarm_entity.dart';
import 'package:yess_nutrition/presentation/providers/schedule_notifiers/schedule_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_information.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class ScheduleAlarmPage extends StatefulWidget {
  final String uid;

  const ScheduleAlarmPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<ScheduleAlarmPage> createState() => _ScheduleAlarmPageState();
}

class _ScheduleAlarmPageState extends State<ScheduleAlarmPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<ScheduleNotifier>(context, listen: false)
          .getAlarms(widget.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        elevation: 0.8,
        toolbarHeight: 64,
        centerTitle: true,
        title: const Text(
          'NutriTime Notification',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 32,
          ),
          color: primaryColor,
          tooltip: 'Back',
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => onPressedAddAlarmIcon(context),
            icon: const Icon(
              Icons.add_alarm_rounded,
              size: 26,
            ),
            color: primaryColor,
            tooltip: 'Clear All',
          ),
        ],
      ),
      body: Consumer<ScheduleNotifier>(
        builder: ((context, scheduleNotifier, child) {
          if (scheduleNotifier.state == RequestState.success) {
            if (scheduleNotifier.alarms.isEmpty) {
              return const CustomInformation(
                key: Key('bookmarks_empty'),
                imgPath: 'assets/svg/eating_time_cuate.svg',
                title: 'Alarm notifikasi masih kosong!',
                subtitle: 'Tambah alarm dengan klik icon di pojok kanan atas.',
              );
            }

            return _buildAlarmList(scheduleNotifier.alarms);
          } else if (scheduleNotifier.state == RequestState.error) {
            return CustomInformation(
              key: const Key('error_message'),
              imgPath: 'assets/svg/feeling_sorry_cuate.svg',
              title: scheduleNotifier.message,
              subtitle: 'Silahkan kembali beberapa saat lagi.',
            );
          }

          return const LoadingIndicator();
        }),
      ),
    );
  }

  ListView _buildAlarmList(List<AlarmEntity> alarms) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      itemBuilder: (context, index) {
        return _buildAlarmCard(context, alarms[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemCount: alarms.length,
    );
  }

  Container _buildAlarmCard(BuildContext context, AlarmEntity alarm) {
    final alarmTime = DateFormat('hh:mm aa').format(alarm.scheduledAt);
    final alarmDay = DateFormat('EEEE').format(alarm.scheduledAt);
    final gradientColor = gradientTemplates[alarm.gradientColorIndex].colors;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: gradientColor.last.withOpacity(0.25),
            offset: const Offset(4, 4),
            blurRadius: 8,
            spreadRadius: 2,
          ),
        ],
        gradient: LinearGradient(
          colors: gradientColor,
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              const Icon(
                Icons.label,
                color: primaryBackgroundColor,
              ),
              const SizedBox(width: 8),
              Text(
                alarm.title,
                style: const TextStyle(color: primaryBackgroundColor),
              ),
              const Spacer(),
              FlutterSwitch(
                value: true,
                onToggle: (value) {},
              ),
            ],
          ),
          Text(
            alarmDay,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(color: primaryBackgroundColor),
          ),
          Row(
            children: <Widget>[
              Text(
                alarmTime,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: primaryBackgroundColor),
              ),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                color: primaryBackgroundColor,
                onPressed: () {},
              ),
              const SizedBox(width: 8),
              IconButton(
                icon: const Icon(Icons.delete_rounded),
                color: primaryBackgroundColor,
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> onPressedAddAlarmIcon(BuildContext context) async {
    var alarmTime = DateFormat('HH:mm').format(DateTime.now());

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Container(
              padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  GestureDetector(
                    onTap: () async {
                      final selectedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );

                      if (selectedTime != null) {
                        final now = DateTime.now();

                        final selectedDateTime = DateTime(
                          now.year,
                          now.month,
                          now.day,
                          selectedTime.hour,
                          selectedTime.minute,
                        );

                        setState(() {
                          alarmTime =
                              DateFormat('HH:mm').format(selectedDateTime);
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: secondaryColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          alarmTime,
                          style: Theme.of(context)
                              .textTheme
                              .headline3!
                              .copyWith(color: primaryColor),
                        ),
                      ),
                    ),
                  ),
                  const ListTile(
                    title: Text('Title'),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.alarm),
                      label: const Text('Simpan'),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  // Future<void> createAlarmNotification(AlarmEntity alarm) {}

  // void deleteAlarm(int id) {
  //   _alarmHelper.delete(id);
  //   //unsubscribe for notification
  //   loadAlarms();
  // }

  // void onSaveAlarm() {
  //   DateTime scheduleAlarmDateTime;
  //   if (_alarmTime!.isAfter(DateTime.now())) {
  //     scheduleAlarmDateTime = _alarmTime!;
  //   } else {
  //     scheduleAlarmDateTime = _alarmTime!.add(const Duration(days: 1));
  //   }

  //   var alarmInfo = NutriTimeInfo(
  //     alarmDateTime: scheduleAlarmDateTime,
  //     gradientColorIndex: _currentAlarms.length,
  //     title: 'alarm',
  //   );
  //   _alarmHelper.insertAlarm(alarmInfo);
  //   scheduleAlarm(scheduleAlarmDateTime, alarmInfo);
  //   Navigator.pop(context);
  //   loadAlarms();
  // }
}
