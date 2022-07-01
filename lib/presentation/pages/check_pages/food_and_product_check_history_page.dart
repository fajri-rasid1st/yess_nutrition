import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/keys.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';
import 'package:yess_nutrition/presentation/providers/food_notifiers/food_history_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_information.dart';
import 'package:yess_nutrition/presentation/widgets/food_list_tile.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class FoodAndProductCheckHistoryPage extends StatefulWidget {
  final String uid;

  const FoodAndProductCheckHistoryPage({
    Key? key,
    required this.uid,
  }) : super(key: key);

  @override
  State<FoodAndProductCheckHistoryPage> createState() =>
      _FoodAndProductCheckHistoryPageState();
}

class _FoodAndProductCheckHistoryPageState
    extends State<FoodAndProductCheckHistoryPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<FoodHistoryNotifier>(context, listen: false)
          .getFoodHistories(widget.uid);
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
          'Riwayat Pencarian',
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
            onPressed: context.watch<FoodHistoryNotifier>().foods.isEmpty
                ? null
                : () {
                    Utilities.showConfirmDialog(
                      context,
                      title: 'Konfirmasi',
                      question: 'Hapus semua riwayat pencarian?',
                      onPressedPrimaryAction: () {
                        clearFoodHistories(context).then((_) {
                          Navigator.pop(context);
                        });
                      },
                      onPressedSecondaryAction: () => Navigator.pop(context),
                    );
                  },
            icon: const Icon(
              Icons.clear_all_rounded,
              size: 28,
            ),
            color: primaryColor,
            tooltip: 'Clear All',
          ),
        ],
      ),
      body: Consumer<FoodHistoryNotifier>(
        builder: (context, historyNotifier, child) {
          if (historyNotifier.state == RequestState.success) {
            if (historyNotifier.foods.isEmpty) {
              return const CustomInformation(
                key: Key('bookmarks_empty'),
                imgPath: 'assets/svg/reading_glasses_cuate.svg',
                title: 'Riwayat pencarian masih kosong',
                subtitle: 'Riwayat pencarian akan muncul di sini.',
              );
            }

            return _buildHistoryList(historyNotifier.foods);
          } else if (historyNotifier.state == RequestState.error) {
            return CustomInformation(
              key: const Key('error_message'),
              imgPath: 'assets/svg/feeling_sorry_cuate.svg',
              title: historyNotifier.message,
              subtitle: 'Silahkan kembali beberapa saat lagi.',
            );
          }

          return const LoadingIndicator();
        },
      ),
    );
  }

  SlidableAutoCloseBehavior _buildHistoryList(List<FoodEntity> foods) {
    return SlidableAutoCloseBehavior(
      child: GroupedListView<FoodEntity, DateTime>(
        elements: foods,
        groupBy: (food) {
          final dateCreated = food.createdAt!;
          return DateTime(dateCreated.year, dateCreated.month, dateCreated.day);
        },
        groupSeparatorBuilder: (dateCreated) {
          return _buildSeparatorGroup(dateCreated);
        },
        groupComparator: (dateTime1, dateTime2) {
          return dateTime1.compareTo(dateTime2) * -1;
        },
        itemBuilder: (context, food) {
          return _buildSlidableListTile(food);
        },
        separator: const Divider(height: 1),
        useStickyGroupSeparators: true,
      ),
    );
  }

  Container _buildSeparatorGroup(DateTime dateCreated) {
    return Container(
      color: scaffoldBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        child: Row(
          children: <Widget>[
            const Icon(
              Icons.history_rounded,
              color: primaryColor,
              size: 22,
            ),
            const SizedBox(width: 8),
            Text(
              Utilities.dateTimeTodMMMy(dateCreated),
              style: const TextStyle(color: primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Slidable _buildSlidableListTile(FoodEntity food) {
    return Slidable(
      groupTag: 0,
      startActionPane: ActionPane(
        extentRatio: 0.3,
        motion: const ScrollMotion(),
        children: <Widget>[
          SlidableAction(
            onPressed: (context) async {
              await deleteFoodHistory(context, food);
            },
            icon: Icons.delete_outline_rounded,
            foregroundColor: primaryBackgroundColor,
            backgroundColor: errorColor,
          ),
        ],
      ),
      child: FoodListTile(
        food: food,
        onPressedTimeIcon: () {
          Utilities.showAddFoodScheduleBottomSheet(
            context,
            uid: widget.uid,
            food: food,
          );
        },
      ),
    );
  }

  Future<void> deleteFoodHistory(BuildContext context, FoodEntity food) async {
    final historyNotifier = context.read<FoodHistoryNotifier>();

    await historyNotifier.deleteFoodHistory(food);

    final message = historyNotifier.message;
    final snackBar = Utilities.createSnackBar(message);

    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    await historyNotifier.getFoodHistories(widget.uid);
  }

  Future<void> clearFoodHistories(BuildContext context) async {
    final historyNotifier = context.read<FoodHistoryNotifier>();

    await historyNotifier.clearFoodHistories(widget.uid);

    final message = historyNotifier.message;
    final snackBar = Utilities.createSnackBar(message);

    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    await historyNotifier.getFoodHistories(widget.uid);
  }
}
