import 'package:countup/countup.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class SmallCircularProgress extends StatelessWidget {
  final Color backgroundColor, progressColor;
  final String descriptionProgress;
  final double progress;

  const SmallCircularProgress({
    Key? key,
    required this.backgroundColor,
    required this.progressColor,
    required this.descriptionProgress,
    required this.progress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 38.0,
      lineWidth: 11,
      percent: progress,
      animation: true,
      animationDuration: 1000,
      center: Countup(
        begin: 0,
        end: progress * 100,
        duration: const Duration(milliseconds: 1000),
        style: Theme.of(context)
            .textTheme
            .bodyText1
            ?.copyWith(fontWeight: FontWeight.w800),
        suffix: "%",
      ),
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      circularStrokeCap: CircularStrokeCap.round,
      footer: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: Text(
          descriptionProgress,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ),
    );
  }
}
