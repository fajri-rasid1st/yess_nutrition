import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
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
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';
import 'package:yess_nutrition/presentation/widgets/nutrient_input_field.dart';

class NutrientsDetailPage extends StatefulWidget {
  final String uid;

  const NutrientsDetailPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<NutrientsDetailPage> createState() => _NutrientsDetailPageState();
}

class _NutrientsDetailPageState extends State<NutrientsDetailPage> {
  late final GlobalKey<FormBuilderState> _formKey;

  @override
  void initState() {
    super.initState();

    _formKey = GlobalKey<FormBuilderState>();

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
        actions: <Consumer>[
          Consumer<UserNutrientsNotifier>(
            builder: (context, notifier, child) {
              return IconButton(
                onPressed: notifier.state == UserState.success
                    ? () => showFormDialog(context, notifier.userNutrients)
                    : null,
                icon: const Icon(MdiIcons.clipboardEditOutline),
                tooltip: 'Edit',
              );
            },
          )
        ],
      ),
      body: Consumer<UserNutrientsNotifier>(
        builder: ((context, notifier, child) {
          if (notifier.state == UserState.success) {
            return _buildDetailNutritionPage(context, notifier.userNutrients);
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
                    'Detail Nutrisi Harian',
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
                    question: 'Atur ulang progress dari nol?',
                    onPressedPrimaryAction: () async {
                      // Reset daily progress
                      await resetDailyProgress(context, userNutrients);
                    },
                    onPressedSecondaryAction: () => Navigator.pop(context),
                  );
                },
                child: Text(
                  'Reset Progress Harian',
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
                  color: primaryColor,
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
                return Theme(
                  data: Theme.of(context)
                      .copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
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
                  ),
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
            barRadius: const Radius.circular(10),
            animation: true,
            animationDuration: 1000,
            padding: EdgeInsets.zero,
            percent: nutrientValue > 1 ? 1 : nutrientValue,
            progressColor: progressColor,
            backgroundColor: backgroundColor,
          ),
        ),
      ],
    );
  }

  String getNutrientTextValue(int? currentValue, int? maxValue) {
    if (currentValue == null || maxValue == null) return 'Belum ditentukan';

    return '$currentValue / $maxValue Telah terpenuhi';
  }

  double getNutrientValue(int? currentValue, int? maxValue) {
    if (currentValue == null || maxValue == null) return 0;

    return currentValue / maxValue;
  }

  void showFormDialog(
    BuildContext context,
    UserNutrientsEntity? userNutrients,
  ) {
    showDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          elevation: 8,
          scrollable: true,
          clipBehavior: Clip.antiAlias,
          contentPadding: const EdgeInsets.fromLTRB(24, 20, 24, 0),
          actionsPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: const Text('Maksimal Kebutuhan Nutrisi Harian'),
          content: FormBuilder(
            key: _formKey,
            child: Column(
              children: <Widget>[
                NutrientInputField(
                  name: 'calories',
                  initialValue: userNutrients?.maxCalories.toString() ?? '',
                  prefixText: 'Kalori:\t',
                  suffixText: 'Kkal',
                  isAutoFocus: true,
                ),
                const SizedBox(height: 10),
                NutrientInputField(
                  name: 'carbohydrate',
                  initialValue: userNutrients?.maxCarbohydrate.toString() ?? '',
                  prefixText: 'Karbohidrat:\t',
                  suffixText: 'gram',
                ),
                const SizedBox(height: 10),
                NutrientInputField(
                  name: 'protein',
                  initialValue: userNutrients?.maxProtein.toString() ?? '',
                  prefixText: 'Protein:\t',
                  suffixText: 'gram',
                ),
                const SizedBox(height: 10),
                NutrientInputField(
                  name: 'fat',
                  initialValue: userNutrients?.maxFat.toString() ?? '',
                  prefixText: 'Lemak:\t',
                  suffixText: 'gram',
                  textInputAction: TextInputAction.done,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Batal',
                    style: TextStyle(color: primaryColor),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    // Create UserNutrientsEntity if userNutrients is null.
                    // otherwise, it will be updated.
                    await onPressedEditSubmitButton(context, userNutrients);
                  },
                  child: const Text(
                    'Simpan',
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  Future<void> onPressedEditSubmitButton(
    BuildContext context,
    UserNutrientsEntity? userNutrients,
  ) async {
    FocusScope.of(context).unfocus();

    if (!await InternetConnectionChecker().hasConnection) {
      Navigator.pop(context);

      scaffoldMessengerKey.currentState!
        ..hideCurrentSnackBar()
        ..showSnackBar(
          Utilities.createSnackBar('Proses gagal. Periksa koneksi internet.'),
        );

      return;
    }

    _formKey.currentState!.save();

    if (_formKey.currentState!.validate()) {
      final value = _formKey.currentState!.value;
      final userNutrientsNotifier = context.read<UserNutrientsNotifier>();

      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingIndicator(),
      );

      if (userNutrients == null) {
        await userNutrientsNotifier.createUserNutrients(
          UserNutrientsEntity(
            uid: widget.uid,
            maxCalories: int.parse(value['calories']),
            maxCarbohydrate: int.parse(value['carbohydrate']),
            maxProtein: int.parse(value['protein']),
            maxFat: int.parse(value['fat']),
            currentDate: DateTime.now(),
          ),
        );
      } else {
        await userNutrientsNotifier.updateUserNutrients(
          userNutrients.copyWith(
            maxCalories: int.parse(value['calories']),
            maxCarbohydrate: int.parse(value['carbohydrate']),
            maxProtein: int.parse(value['protein']),
            maxFat: int.parse(value['fat']),
          ),
        );
      }

      await userNutrientsNotifier.refresh(widget.uid);

      // Close loading indicator
      navigatorKey.currentState!.pop();

      // Close dialog
      navigatorKey.currentState!.pop();

      final message = userNutrientsNotifier.message;
      final snackBar = Utilities.createSnackBar(message);

      scaffoldMessengerKey.currentState!
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }

  Future<void> resetDailyProgress(
    BuildContext context,
    UserNutrientsEntity? userNutrients,
  ) async {
    if (!await InternetConnectionChecker().hasConnection) {
      Navigator.pop(context);

      scaffoldMessengerKey.currentState!
        ..hideCurrentSnackBar()
        ..showSnackBar(
          Utilities.createSnackBar('Proses gagal. Periksa koneksi internet.'),
        );

      return;
    }

    if (userNutrients == null) {
      Navigator.pop(context);

      return;
    }

    // Show loading indicator
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const LoadingIndicator(),
    );

    final userNutrientsNotifier = context.read<UserNutrientsNotifier>();

    await userNutrientsNotifier.updateUserNutrients(
      userNutrients.copyWith(
        currentCalories: 0,
        currentCarbohydrate: 0,
        currentProtein: 0,
        currentFat: 0,
      ),
    );

    await userNutrientsNotifier.refresh(widget.uid);

    // Close loading indicator
    navigatorKey.currentState!.pop();

    // Close dialog
    navigatorKey.currentState!.pop();

    final message = userNutrientsNotifier.message;
    final snackBar = Utilities.createSnackBar(message);

    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
