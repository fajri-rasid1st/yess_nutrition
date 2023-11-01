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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const Icon(
                  Icons.label,
                  color: primaryBackgroundColor,
                  size: 28,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      alarm.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(
                            color: primaryBackgroundColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FlutterSwitch(
                  value: alarm.isActive,
                  onToggle: onToggledSwitcher,
                  width: 54,
                  height: 30,
                  activeColor: primaryColor,
                  inactiveColor: primaryTextColor.withOpacity(0.8),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: <Widget>[
                Text(
                  alarmTime,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .copyWith(color: primaryBackgroundColor),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  color: primaryBackgroundColor,
                  onPressed: onPressedEditIcon,
                  tooltip: 'Edit',
                ),
                IconButton(
                  icon: const Icon(Icons.delete_rounded),
                  color: primaryBackgroundColor,
                  onPressed: onPressedDeleteIcon,
                  tooltip: 'Delete',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
