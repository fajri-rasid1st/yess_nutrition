import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
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
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<UserFoodScheduleNotifier>(context, listen: false)
          .readUserFoodSchedules(widget.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        shadowColor: secondaryBackgroundColor.withOpacity(0.1),
        toolbarHeight: 80,
        title: const Text(
          'NutriTime',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 4),
            child: IconButton(
              onPressed: () => Navigator.pushNamed(
                context,
                scheduleAlarmRoute,
                arguments: widget.uid,
              ),
              icon: const Icon(Icons.schedule_outlined),
              iconSize: 32,
              color: primaryColor,
              tooltip: 'Notification',
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
              return _buildSchedulePage(context, schedule.foodSchedules);
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

  SingleChildScrollView _buildSchedulePage(
    BuildContext context,
    List<UserFoodScheduleEntity> foodSchedules,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: <Widget>[
          _buildProgressCard(context, foodSchedules),
          const SizedBox(height: 20),
          if (foodSchedules.isNotEmpty) ...[],
        ],
      ),
    );
  }

  Container _buildProgressCard(
    BuildContext context,
    List<UserFoodScheduleEntity> foodSchedules,
  ) {
    final schedulesTotal = foodSchedules.length;
    final completeSchedulesTotal = foodSchedules
        .where((schedule) => schedule.isDone == true)
        .toList()
        .length;

    final percentage = completeSchedulesTotal / schedulesTotal;

    return Container(
      decoration: BoxDecoration(
        color: primaryBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(0, 1),
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Progress Makan',
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  DateFormat('E, d MMM').format(DateTime.now()),
                  style: const TextStyle(color: secondaryTextColor),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              percentage.isNaN
                  ? 'Jadwal makan masih kosong'
                  : '$completeSchedulesTotal / $schedulesTotal Telah selesai',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: secondaryTextColor),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: LinearPercentIndicator(
                lineHeight: 12,
                barRadius: const Radius.circular(12),
                animation: true,
                animationDuration: 1000,
                padding: EdgeInsets.zero,
                percent: percentage.isNaN ? 0 : percentage,
                progressColor: primaryColor,
                backgroundColor: secondaryColor,
              ),
            ),
            const SizedBox(height: 16),
            const Divider(),
            Center(
              child: TextButton.icon(
                onPressed: () => Navigator.pushNamed(
                  context,
                  foodCheckRoute,
                  arguments: widget.uid,
                ),
                icon: const Icon(Icons.add_rounded),
                label: const Text('Tambah Jadwal Makan'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildFoodScheduleCard(
    BuildContext context,
    List<UserFoodScheduleEntity> foodSchedules,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: primaryBackgroundColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(0, 1),
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Text(
                'Jadwal Makan',
                style: Theme.of(context)
                    .textTheme
                    .headline6!
                    .copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 12),
            // ListView.builder(
            //   physics: const NeverScrollableScrollPhysics(),
            //   shrinkWrap: true,
            //   itemBuilder: (context, index) {},
            //   itemCount: ,
            // ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
