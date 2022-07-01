import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/keys.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/domain/entities/user_food_schedule_entity.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/user_firestore_notifiers/user_food_schedule_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/user_firestore_notifiers/user_nutrients_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/food_schedule_list_tile.dart';
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
      body: Consumer<UserFoodScheduleNotifier>(
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
    );
  }

  SingleChildScrollView _buildSchedulePage(
    BuildContext context,
    List<UserFoodScheduleEntity> foodSchedules,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
      child: Column(
        children: <Widget>[
          _buildProgressCard(context, foodSchedules),
          const SizedBox(height: 16),
          if (foodSchedules.isNotEmpty) ...[
            _buildFoodScheduleCard(context, foodSchedules),
          ],
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
                    'Progres Makan',
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
                label: Text(
                  'Tambah Jadwal Makan',
                  style: Theme.of(context).textTheme.button!.copyWith(
                        color: primaryColor,
                        letterSpacing: 0.5,
                      ),
                ),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 10, 4, 4),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    'Jadwal Makan',
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: () => Utilities.showConfirmDialog(
                    context,
                    title: 'Konfirmasi',
                    question: 'Hapus semua jadwal makan?',
                    onPressedPrimaryAction: () async {
                      await resetFoodSchedules(context);
                    },
                    onPressedSecondaryAction: () => Navigator.pop(context),
                  ),
                  padding: const EdgeInsets.all(0),
                  icon: const Icon(Icons.clear_all_rounded),
                  iconSize: 22,
                  tooltip: 'Clear All',
                ),
              ],
            ),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: _buildFoodScheduleList(foodSchedules),
          ),
        ],
      ),
    );
  }

  SlidableAutoCloseBehavior _buildFoodScheduleList(
    List<UserFoodScheduleEntity> foodSchedules,
  ) {
    return SlidableAutoCloseBehavior(
      child: ListView.separated(
        primary: false,
        padding: const EdgeInsets.only(bottom: 18),
        itemBuilder: (context, index) {
          return _buildSlidableListTile(context, foodSchedules[index]);
        },
        separatorBuilder: (context, index) => const Divider(height: 1),
        itemCount: foodSchedules.length,
      ),
    );
  }

  Slidable _buildSlidableListTile(
    BuildContext context,
    UserFoodScheduleEntity foodSchedule,
  ) {
    return Slidable(
      groupTag: 0,
      startActionPane: ActionPane(
        extentRatio: 0.25,
        motion: const ScrollMotion(),
        children: <Widget>[
          SlidableAction(
            onPressed: (_) async {
              await deleteFoodSchedule(context, foodSchedule);
            },
            icon: Icons.delete_outline_rounded,
            foregroundColor: primaryBackgroundColor,
            backgroundColor: errorColor,
          ),
        ],
      ),
      child: FoodScheduleListTile(
        foodSchedule: foodSchedule,
        onPressedChecklistButton: () async {
          await updateFoodSchedule(context, foodSchedule);
        },
      ),
    );
  }

  Future<void> updateFoodSchedule(
    BuildContext context,
    UserFoodScheduleEntity foodSchedule,
  ) async {
    // If no internet connection, return
    if (!await InternetConnectionChecker().hasConnection) {
      scaffoldMessengerKey.currentState!
        ..hideCurrentSnackBar()
        ..showSnackBar(
          Utilities.createSnackBar('Proses gagal. Periksa koneksi internet.'),
        );

      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingIndicator(),
    );

    final userFoodScheduleNotifier = context.read<UserFoodScheduleNotifier>();
    final userNutrientsNotifier = context.read<UserNutrientsNotifier>();

    // Update status of food schedule from isDone = false, to isDone = true
    await userFoodScheduleNotifier.updateUserFoodSchedule(
      foodSchedule.copyWith(isDone: !foodSchedule.isDone),
    );

    // Refresh user food schedule list
    await userFoodScheduleNotifier.refresh(widget.uid);

    // Read user nutrients notifier, without changing state to empty
    await userNutrientsNotifier.refresh(widget.uid);

    final userNutrients = userNutrientsNotifier.userNutrients;

    if (userNutrients != null) {
      final foodNutrients = foodSchedule.foodNutrients;

      // Update user nutrients
      await userNutrientsNotifier.updateUserNutrients(
        userNutrients.copyWith(
          currentCalories:
              (foodNutrients.calories.toInt() + userNutrients.currentCalories),
          currentCarbohydrate: (foodNutrients.carbohydrate.toInt() +
              userNutrients.currentCarbohydrate),
          currentProtein:
              (foodNutrients.protein.toInt() + userNutrients.currentProtein),
          currentFat: (foodNutrients.fat.toInt() + userNutrients.currentFat),
        ),
      );
    }

    // Refresh user nutrients
    await userNutrientsNotifier.refresh(widget.uid);

    // Close loading indicator
    navigatorKey.currentState!.pop();

    const message = 'Selesai. Progress makan dan nutrisi telah bertambah.';
    final snackBar = Utilities.createSnackBar(message);

    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  Future<void> deleteFoodSchedule(
    BuildContext context,
    UserFoodScheduleEntity foodSchedule,
  ) async {
    // If no internet connection, return
    if (!await InternetConnectionChecker().hasConnection) {
      scaffoldMessengerKey.currentState!
        ..hideCurrentSnackBar()
        ..showSnackBar(
          Utilities.createSnackBar(
            'Gagal menghapus item. Periksa koneksi internet.',
          ),
        );

      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingIndicator(),
    );

    final foodScheduleNotifier = context.read<UserFoodScheduleNotifier>();

    // Remove specific food schedule
    await foodScheduleNotifier.deleteUserFoodSchedule(foodSchedule);

    // Refresh user food schedule list
    await foodScheduleNotifier.refresh(widget.uid);

    // Close loading indicator
    navigatorKey.currentState!.pop();

    final message = foodScheduleNotifier.message;
    final snackBar = Utilities.createSnackBar(message);

    // Show snackbar
    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  Future<void> resetFoodSchedules(BuildContext context) async {
    // If no internet connection, return
    if (!await InternetConnectionChecker().hasConnection) {
      Navigator.pop(context);

      scaffoldMessengerKey.currentState!
        ..hideCurrentSnackBar()
        ..showSnackBar(
          Utilities.createSnackBar(
            'Gagal menghapus semua item. Periksa koneksi internet.',
          ),
        );

      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingIndicator(),
    );

    final foodScheduleNotifier = context.read<UserFoodScheduleNotifier>();

    // Clear/reset all user food schedules
    await foodScheduleNotifier.resetUserFoodSchedules(widget.uid);

    // Refresh user food schedule list
    await foodScheduleNotifier.refresh(widget.uid);

    // Close loading indicator
    navigatorKey.currentState!.pop();

    // Close dialog
    navigatorKey.currentState!.pop();

    final message = foodScheduleNotifier.message;
    final snackBar = Utilities.createSnackBar(message);

    // Show snackbar
    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  @override
  bool get wantKeepAlive => true;
}
