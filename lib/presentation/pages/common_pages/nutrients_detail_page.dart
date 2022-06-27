import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/constants.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/keys.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/domain/entities/user_nutrients_entity.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/user_firestore_notifiers/user_nutrients_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_information.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class NutrientsDetailPage extends StatefulWidget {
  final String uid;

  const NutrientsDetailPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<NutrientsDetailPage> createState() => _NutrientsDetailPageState();
}

class _NutrientsDetailPageState extends State<NutrientsDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<UserNutrientsNotifier>(context, listen: false)
          .readUserNutrients(widget.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: secondaryBackgroundColor,
        shadowColor: Colors.black.withOpacity(0.5),
        toolbarHeight: 64,
        centerTitle: true,
        title: const Text(
          'Nutrisi Harian',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 32,
          ),
          tooltip: 'Back',
        ),
        actions: <IconButton>[
          IconButton(
            onPressed: () {},
            icon: const Icon(MdiIcons.clipboardEditOutline),
            tooltip: 'Edit',
          )
        ],
      ),
      body: Consumer<UserNutrientsNotifier>(
        builder: ((context, notifier, child) {
          if (notifier.state == UserState.success) {
            return _buildDetailNutritionPage(context, notifier.userNutrients);
          }

          if (notifier.state == UserState.error) {
            return _buildDetailError(notifier);
          }

          return Container(
            color: primaryBackgroundColor,
            child: const LoadingIndicator(),
          );
        }),
      ),
    );
  }

  SingleChildScrollView _buildDetailNutritionPage(
    BuildContext context,
    UserNutrientsEntity? userNutrients,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
      child: Column(
        children: <Widget>[
          _buildDetailNutrientsCard(context, userNutrients),
          const SizedBox(height: 20),
          _buildDetailInfoCard(context),
        ],
      ),
    );
  }

  Container _buildDetailNutrientsCard(
    BuildContext context,
    UserNutrientsEntity? userNutrients,
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
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Text(
                  'Detail Nutrisi Harian',
                  style: Theme.of(context).textTheme.headline6!.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Spacer(),
                Text(
                  Utilities.dateTimeToddMMMy(DateTime.now()),
                  style: const TextStyle(
                    color: secondaryTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            _buildNutrientIndicator(
              context,
              nutrientLabel: 'Kalori (Kkal)',
              nutrientTextValue: getNutrientTextValue(
                userNutrients?.currentCalories,
                userNutrients?.maxCalories,
              ),
              nutrientValue: getNutrientValue(
                userNutrients?.currentCalories,
                userNutrients?.maxCalories,
              ),
              progressColor: primaryColor,
              backgroundColor: secondaryColor,
            ),
            const SizedBox(height: 18),
            _buildNutrientIndicator(
              context,
              nutrientLabel: 'Karbohidrat (g)',
              nutrientTextValue: getNutrientTextValue(
                userNutrients?.currentCarbohydrate,
                userNutrients?.maxCarbohydrate,
              ),
              nutrientValue: getNutrientValue(
                userNutrients?.currentCarbohydrate,
                userNutrients?.maxCarbohydrate,
              ),
              progressColor: const Color(0XFF5ECFF2),
              backgroundColor: const Color(0XFF5ECFF2).withOpacity(0.2),
            ),
            const SizedBox(height: 18),
            _buildNutrientIndicator(
              context,
              nutrientLabel: 'Protein (g)',
              nutrientTextValue: getNutrientTextValue(
                userNutrients?.currentProtein,
                userNutrients?.maxProtein,
              ),
              nutrientValue: getNutrientValue(
                userNutrients?.currentProtein,
                userNutrients?.maxProtein,
              ),
              progressColor: const Color(0XFFEF5EF2),
              backgroundColor: const Color(0XFFEF5EF2).withOpacity(0.2),
            ),
            const SizedBox(height: 18),
            _buildNutrientIndicator(
              context,
              nutrientLabel: 'Lemak (g)',
              nutrientTextValue: getNutrientTextValue(
                userNutrients?.currentFat,
                userNutrients?.maxFat,
              ),
              nutrientValue: getNutrientValue(
                userNutrients?.currentFat,
                userNutrients?.maxFat,
              ),
              progressColor: errorColor,
              backgroundColor: errorColor.withOpacity(0.2),
            ),
            const SizedBox(height: 20),
            const Divider(),
            Center(
              child: TextButton(
                onPressed: () {
                  Utilities.showConfirmDialog(
                    context,
                    title: 'Konfirmasi',
                    question: 'Ingin mengatur ulang progress ke nol?',
                    onPressedPrimaryAction: () {
                      resetProgress(context, userNutrients).then((_) {
                        Navigator.pop(context);
                      });
                    },
                    onPressedSecondaryAction: () {
                      Navigator.pop(context);
                    },
                  );
                },
                child: const Text('Reset Progress'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildDetailInfoCard(BuildContext context) {
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
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                const Icon(
                  Icons.info_outline_rounded,
                  color: Colors.blue,
                  size: 28,
                ),
                const SizedBox(width: 8),
                Text(
                  'Info',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return ExpansionTile(
                  tilePadding: EdgeInsets.zero,
                  childrenPadding: const EdgeInsets.only(bottom: 16),
                  title: Text(
                    userNutrientQuestions[index].question,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        color: scaffoldBackgroundColor,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          userNutrientQuestions[index].answer,
                          style: const TextStyle(color: secondaryTextColor),
                        ),
                      ),
                    ),
                  ],
                );
              },
              itemCount: userNutrientQuestions.length,
            ),
          ],
        ),
      ),
    );
  }

  Column _buildNutrientIndicator(
    BuildContext context, {
    required String nutrientLabel,
    required String nutrientTextValue,
    required double nutrientValue,
    required Color progressColor,
    required Color backgroundColor,
  }) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          nutrientLabel,
          style: Theme.of(context)
              .textTheme
              .subtitle1!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 6),
        Text(
          nutrientTextValue,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: secondaryTextColor),
        ),
        const SizedBox(height: 10),
        SizedBox(
          width: double.infinity,
          child: LinearPercentIndicator(
            lineHeight: 10,
            percent: nutrientValue,
            animation: true,
            animationDuration: 1000,
            progressColor: progressColor,
            backgroundColor: backgroundColor,
            barRadius: const Radius.circular(10),
            padding: EdgeInsets.zero,
          ),
        ),
      ],
    );
  }

  Container _buildDetailError(UserNutrientsNotifier notifier) {
    return Container(
      color: primaryBackgroundColor,
      child: CustomInformation(
        key: const Key('error_message'),
        imgPath: 'assets/svg/error_robot_cuate.svg',
        title: notifier.message,
        subtitle: 'Silahkan coba beberapa saat lagi.',
        child: ElevatedButton.icon(
          onPressed: notifier.isReload
              ? null
              : () {
                  // set isReload to true
                  notifier.isReload = true;

                  Future.wait([
                    // create one second delay
                    Future.delayed(const Duration(seconds: 1)),

                    // refresh page
                    notifier.refresh(widget.uid),
                  ]).then((_) {
                    // set isReload to true
                    notifier.isReload = false;
                  });
                },
          icon: notifier.isReload
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: dividerColor,
                  ),
                )
              : const Icon(Icons.refresh_rounded),
          label: notifier.isReload
              ? const Text('Tunggu sebentar...')
              : const Text('Coba lagi'),
        ),
      ),
    );
  }

  String getNutrientTextValue(int? currentValue, int? maxValue) {
    if (currentValue == null || maxValue == null) return 'Belum ditentukan';

    return '$currentValue / $maxValue telah terpenuhi';
  }

  double getNutrientValue(int? currentValue, int? maxValue) {
    if (currentValue == null || maxValue == null) return 0;

    return currentValue / maxValue;
  }

  Future<void> showFormDialog() async {}

  Future<void> resetProgress(
    BuildContext context,
    UserNutrientsEntity? userNutrients,
  ) async {
    if (userNutrients == null) return;

    final userNutrientsNotifier = context.read<UserNutrientsNotifier>();

    await userNutrientsNotifier.updateUserNutrients(
      userNutrients.copyWith(
        currentCalories: 0,
        currentCarbohydrate: 0,
        currentProtein: 0,
        currentFat: 0,
      ),
    );

    final message = userNutrientsNotifier.message;
    final snackBar = Utilities.createSnackBar(message);

    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    await userNutrientsNotifier.refresh(widget.uid);
  }
}
