import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/keys.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/data/datasources/helpers/notification_helper.dart';
import 'package:yess_nutrition/domain/entities/alarm_entity.dart';
import 'package:yess_nutrition/presentation/providers/common_notifiers/schedule_time_notifier.dart';
import 'package:yess_nutrition/presentation/providers/schedule_notifiers/schedule_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/alarm_card.dart';
import 'package:yess_nutrition/presentation/widgets/custom_information.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class ScheduleAlarmPage extends StatefulWidget {
  final String uid;

  const ScheduleAlarmPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<ScheduleAlarmPage> createState() => _ScheduleAlarmPageState();
}

class _ScheduleAlarmPageState extends State<ScheduleAlarmPage> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();
  final NotificationHelper _notificationHelper = NotificationHelper();

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
      resizeToAvoidBottomInset: false,
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
            tooltip: 'Add Schedule',
          ),
        ],
      ),
      body: Consumer<ScheduleNotifier>(
        builder: ((context, schedule, child) {
          if (schedule.state == RequestState.success) {
            if (schedule.alarms.isEmpty) {
              return const CustomInformation(
                key: Key('bookmarks_empty'),
                imgPath: 'assets/svg/eating_time_cuate.svg',
                title: 'Alarm notifikasi masih kosong!',
                subtitle: 'Tambah alarm dengan klik icon di pojok kanan atas.',
              );
            }

            return _buildAlarmList(schedule.alarms);
          } else if (schedule.state == RequestState.error) {
            return CustomInformation(
              key: const Key('error_message'),
              imgPath: 'assets/svg/feeling_sorry_cuate.svg',
              title: schedule.message,
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
        return AlarmCard(
          alarm: alarms[index],
          onPressedEditIcon: () {},
          onPressedDeleteIcon: () {},
          onToggledSwitcher: (value) {},
        );
      },
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: alarms.length,
    );
  }

  Future<void> onPressedAddAlarmIcon(BuildContext context) async {
    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
          child: Consumer<ScheduleTimeNotifier>(
            builder: (context, timeNotifier, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Atur Notifikasi',
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        timeNotifier.timeString,
                        style: Theme.of(context)
                            .textTheme
                            .headline4!
                            .copyWith(color: primaryColor),
                      ),
                      IconButton(
                        onPressed: () {
                          showTimePicker(context, timeNotifier);
                        },
                        icon: const Icon(Icons.edit_rounded),
                        color: primaryColor,
                        tooltip: 'Edit Time',
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  FormBuilder(
                    key: _formKey,
                    child: FormBuilderTextField(
                      name: 'title',
                      textInputAction: TextInputAction.done,
                      textCapitalization: TextCapitalization.words,
                      maxLength: 50,
                      decoration: const InputDecoration(
                        labelText: 'Judul',
                        hintText: 'Makan pagi, siang, sore, etc',
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Bagian ini harus diisi',
                        ),
                      ]),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        await onPressedSaveButton(context, timeNotifier);
                      },
                      icon: const Icon(Icons.add_rounded),
                      label: const Text('Simpan'),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  void showTimePicker(BuildContext context, ScheduleTimeNotifier timeNotifier) {
    Navigator.push(
      context,
      showPicker(
        context: context,
        value: TimeOfDay.now(),
        elevation: 8,
        borderRadius: 12,
        accentColor: secondaryBackgroundColor,
        barrierDismissible: false,
        onChange: (time) {
          timeNotifier.setTimeFromTimeOfDay(time);
        },
        onChangeDateTime: (datetime) {
          timeNotifier.setTimeStringFromDateTime(datetime);
        },
        cancelText: 'Batal',
        cancelStyle: Theme.of(context).textTheme.button!.copyWith(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
        okStyle: Theme.of(context).textTheme.button!.copyWith(
              color: primaryColor,
              fontWeight: FontWeight.bold,
            ),
      ),
    );
  }

  Future<void> onPressedSaveButton(
    BuildContext context,
    ScheduleTimeNotifier timeNotifier,
  ) async {
    FocusScope.of(context).unfocus();

    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      final value = _formKey.currentState!.value;
      final scheduleNotifier = context.read<ScheduleNotifier>();

      // show loading
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingIndicator(),
      );

      final now = DateTime.now();
      final dateSchedule = DateTime(
        now.year,
        now.month,
        now.day,
        timeNotifier.time.hour,
        timeNotifier.time.minute,
      );
      final alarm = AlarmEntity(
        uid: widget.uid,
        title: value['title'],
        scheduledAt: dateSchedule,
        isPending: false,
        gradientColorIndex: setGradientColorIndex(timeNotifier.time),
      );

      // insert alarm to database
      await scheduleNotifier.createAlarm(alarm);

      // read alarm from database
      await scheduleNotifier.getAlarms(widget.uid);

      // create alarm notification schedule
      await _notificationHelper.scheduleNotification(
        scheduleNotifier.alarms.last.id!,
        widget.uid,
        timeNotifier.time,
        alarm,
      );

      // close loading
      navigatorKey.currentState!.pop();

      // close bottom sheet
      navigatorKey.currentState!.pop();

      final message = scheduleNotifier.message;
      final snackBar = Utilities.createSnackBar(message);

      scaffoldMessengerKey.currentState!
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  int setGradientColorIndex(Time time) {
    if (time.hour >= 6 && time.hour <= 12) return 0;

    if (time.hour >= 12 && time.hour <= 18) return 1;

    return 2;
  }
}
