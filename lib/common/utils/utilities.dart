import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uuid/uuid.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/keys.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';
import 'package:yess_nutrition/domain/entities/user_data_entity.dart';
import 'package:yess_nutrition/domain/entities/user_food_schedule_entity.dart';
import 'package:yess_nutrition/domain/entities/user_nutrients_entity.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/user_firestore_notifiers/user_food_schedule_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_network_image.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class Utilities {
  /// Function to calculate user total daily nutritional needs (BMR)
  /// using the **Harris-Benedict Formula**
  static UserNutrientsEntity calculateUserNutrients(UserDataEntity userData) {
    var maxCalories = 0;

    // first, check user gender
    if (userData.gender == 'Laki-laki') {
      // Man BMR formula
      maxCalories = (655 +
              (9.6 * userData.weight) +
              (1.8 * userData.height) -
              (4.7 * userData.age))
          .toInt();
    } else {
      // Woman BMR formula
      maxCalories = (66.5 +
              (13.7 * userData.weight) +
              (5 * userData.height) -
              (6.8 * userData.age))
          .toInt();
    }

    final maxCarbohydrate = (0.65 * maxCalories) ~/ 4;
    final maxProtein = (0.15 * maxCalories) ~/ 4;
    final maxFat = (0.2 * maxCalories) ~/ 9;

    return UserNutrientsEntity(
      uid: userData.uid,
      maxCalories: maxCalories,
      maxCarbohydrate: maxCarbohydrate,
      maxProtein: maxProtein,
      maxFat: maxFat,
      currentDate: DateTime.now(),
    );
  }

  /// Function to convert [dateTime] to time ago string format
  static String dateTimeToTimeAgo(DateTime dateTime) {
    if (dateTime.year == 0) return '?';

    timeago.setLocaleMessages('id', timeago.IdMessages());

    return toBeginningOfSentenceCase(timeago.format(dateTime, locale: 'id'))!;
  }

  /// Function to format [dateTime] to **d MMM y** string pattern
  static String dateTimeTodMMMy(DateTime dateTime) {
    if (dateTime.year == 0) return '?';

    return DateFormat('d MMM y').format(dateTime);
  }

  /// Function to convert [number] according to [decimalDigit]
  static String numberToIdr(dynamic number, int decimalDigit) {
    final currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: '',
      decimalDigits: decimalDigit,
    );

    return currencyFormatter.format(number);
  }

  /// Function to encrypt [text] with **Salsa20 engine**
  static String encryptText(String text) {
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(8);

    final encrypter = encrypt.Encrypter(encrypt.Salsa20(key));
    final encrypted = encrypter.encrypt(text, iv: iv);

    return encrypted.base64;
  }

  /// Function to create snack bar with [message] as text that will be displayed.
  ///
  /// Its only create snackbar, not showing it.
  static SnackBar createSnackBar(String message) {
    return SnackBar(
      content: Text(message, style: GoogleFonts.plusJakartaSans()),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      duration: const Duration(seconds: 3),
    );
  }

  /// Function to show confirm dialog with two action button
  static void showConfirmDialog(
    BuildContext context, {
    required String title,
    required String question,
    required VoidCallback onPressedPrimaryAction,
    required VoidCallback onPressedSecondaryAction,
  }) {
    showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      transitionBuilder: (context, animStart, animEnd, child) {
        final curvedValue = Curves.ease.transform(animStart.value) - 3.8;
        final height = (MediaQuery.of(context).size.height / 8) * -1;

        return Transform(
          transform: Matrix4.translationValues(0, (curvedValue * height), 0),
          child: Opacity(
            opacity: animStart.value,
            child: Dialog(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      question,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          onPressed: onPressedSecondaryAction,
                          child: const Text(
                            'Batal',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                          child: VerticalDivider(
                            width: 1,
                            thickness: 1,
                          ),
                        ),
                        TextButton(
                          onPressed: onPressedPrimaryAction,
                          child: const Text(
                            'Oke',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animStart, animEnd) => const SizedBox(),
    );
  }

  /// Function to show food schedule bottom sheet for adding user food schedule
  static void showAddFoodScheduleBottomSheet(
    BuildContext context, {
    required String uid,
    required FoodEntity food,
  }) {
    final formKey = GlobalKey<FormBuilderState>();

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      clipBehavior: Clip.antiAlias,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final height = MediaQuery.of(context).viewInsets.bottom;
        final bottom = height > 0 ? 0 : 24 + height;

        return Container(
          padding: EdgeInsets.fromLTRB(20, 24, 20, bottom.toDouble()),
          child: Column(
            mainAxisSize: height > 0 ? MainAxisSize.max : MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Buat Jadwal Makan',
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(height: 16),
              Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CustomNetworkImage(
                      width: 68,
                      height: 68,
                      imgUrl: food.image,
                      placeHolderSize: 34,
                      errorIcon: Icons.fastfood_outlined,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            food.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${toBeginningOfSentenceCase(food.categoryLabel)}, ${food.category}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .caption!
                                .copyWith(color: secondaryTextColor),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${food.nutrients.calories.toStringAsFixed(0)} Kkal per porsi',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: primaryColor),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(),
              ),
              FormBuilder(
                key: formKey,
                child: Column(
                  children: <Widget>[
                    FormBuilderRadioGroup(
                      name: 'scheduleType',
                      activeColor: primaryColor,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.zero,
                        focusColor: primaryColor,
                        border: InputBorder.none,
                        labelText: 'Pilih waktu makan',
                        labelStyle: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(color: primaryColor),
                      ),
                      options: const <FormBuilderFieldOption<String>>[
                        FormBuilderFieldOption(value: 'Sarapan'),
                        FormBuilderFieldOption(value: 'Makan Siang'),
                        FormBuilderFieldOption(value: 'Makan Malam'),
                        FormBuilderFieldOption(value: 'Lainnya'),
                      ],
                      validator: FormBuilderValidators.required(
                        errorText: 'Bagian ini harus diisi',
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Divider(),
                    ),
                    FormBuilderTextField(
                      name: 'totalServing',
                      initialValue: '1',
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        prefixText: 'Jumlah\t',
                        suffixText: 'Porsi',
                      ),
                      inputFormatters: <TextInputFormatter>[
                        LengthLimitingTextInputFormatter(2),
                      ],
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Bagian ini harus diisi.',
                        ),
                        FormBuilderValidators.match(
                          r'^[1-9]\d*$',
                          errorText: 'Minimal 1 Porsi',
                        ),
                      ]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _onPressedSubmitButton(
                    context,
                    uid,
                    food,
                    formKey,
                  ),
                  icon: const Icon(Icons.add_rounded),
                  label: const Text('Buat Jadwal'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  static Future<void> _onPressedSubmitButton(
    BuildContext context,
    String uid,
    FoodEntity food,
    GlobalKey<FormBuilderState> formKey,
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

    formKey.currentState!.save();

    if (formKey.currentState!.validate()) {
      final value = formKey.currentState!.value;
      final foodScheduleNotifier = context.read<UserFoodScheduleNotifier>();

      // Show loading indicator
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoadingIndicator(),
      );

      await foodScheduleNotifier.createUserFoodSchedule(
        UserFoodScheduleEntity(
          id: const Uuid().v4(),
          uid: uid,
          totalServing: int.parse(value['totalServing']),
          scheduleType: value['scheduleType'],
          isDone: false,
          foodName: food.label,
          foodImage: food.image,
          foodNutrients: food.nutrients.multiplyBy(
            value: int.parse(value['totalServing']),
          ),
        ),
      );

      // refresh food schedule list
      await foodScheduleNotifier.refresh(uid);

      // Close loading indicator
      navigatorKey.currentState!.pop();

      // Close dialog
      navigatorKey.currentState!.pop();

      final message = foodScheduleNotifier.message;
      final snackBar = Utilities.createSnackBar(message);

      scaffoldMessengerKey.currentState!
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}
