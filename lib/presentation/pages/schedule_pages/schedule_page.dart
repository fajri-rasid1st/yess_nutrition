import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/domain/entities/user_food_schedule_entity.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/user_firestore_notifiers/user_food_schedule_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class SchedulePage extends StatefulWidget {
  final String uid;

  const SchedulePage({Key? key, required this.uid}) : super(key: key);

  @override
  State<SchedulePage> createState() => _NutriTimePagePageState();
}

class _NutriTimePagePageState extends State<SchedulePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 86,
        title: const Text(
          'NutriTime',
          style: TextStyle(
            color: primaryColor,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      scheduleAlarmRoute,
                      arguments: widget.uid,
                    ),
                    icon: const Icon(Icons.schedule_outlined),
                    color: primaryColor,
                    tooltip: 'Notification',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () {
          return context.read<UserFoodScheduleNotifier>().refresh(widget.uid);
        },
        child: Consumer<UserFoodScheduleNotifier>(
          builder: ((context, schedule, child) {
            if (schedule.state == UserState.success) {
              // return _buildFoodScheduleList(context, schedule.foodSchedules);
            }

            return Container(
              color: primaryBackgroundColor,
              child: const LoadingIndicator(),
            );
          }),
        ),
      ),
    );
  }

  // Widget _buildFoodScheduleList(
  //   BuildContext context,
  //   List<UserFoodScheduleEntity> foodSchedules,
  // ) {}

  @override
  bool get wantKeepAlive => true;
}
