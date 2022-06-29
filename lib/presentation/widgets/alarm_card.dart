import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:intl/intl.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/domain/entities/alarm_entity.dart';

class AlarmCard extends StatelessWidget {
  final AlarmEntity alarm;
  final VoidCallback onPressedEditIcon;
  final VoidCallback onPressedDeleteIcon;
  final void Function(bool) onToggledSwitcher;

  const AlarmCard({
    Key? key,
    required this.alarm,
    required this.onPressedEditIcon,
    required this.onPressedDeleteIcon,
    required this.onToggledSwitcher,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final alarmTime = DateFormat('hh:mm aa').format(alarm.scheduledAt);
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
      child: Padding(
        padding: const EdgeInsets.all(12),
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
                  value: !alarm.isPending,
                  onToggle: onToggledSwitcher,
                ),
              ],
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
                  onPressed: onPressedEditIcon,
                  tooltip: 'Edit Time',
                ),
                const SizedBox(width: 8),
                IconButton(
                  icon: const Icon(Icons.delete_rounded),
                  color: primaryBackgroundColor,
                  onPressed: onPressedDeleteIcon,
                  tooltip: 'Delete Time',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
