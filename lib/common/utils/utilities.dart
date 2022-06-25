import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:yess_nutrition/common/styles/color_scheme.dart';

class Utilities {
  /// Function to convert [dateTime] to time ago string format
  static String dateTimeToTimeAgo(DateTime dateTime) {
    if (dateTime.year == 0) return '?';

    timeago.setLocaleMessages('id', timeago.IdMessages());

    return toBeginningOfSentenceCase(timeago.format(dateTime, locale: 'id'))!;
  }

  /// Function to format [dateTime] to **dd MMM y** string pattern
  static String dateTimeToddMMMy(DateTime dateTime) {
    if (dateTime.year == 0) return '?';

    return DateFormat('dd MMM y').format(dateTime);
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

  /// Function to encrypt [text] with Salsa20 engine
  static String encryptText(String text) {
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(8);

    final encrypter = encrypt.Encrypter(encrypt.Salsa20(key));
    final encrypted = encrypter.encrypt(text, iv: iv);

    return encrypted.base64;
  }

  /// Function to create snack bar with [message] as text that will be displayed
  static SnackBar createSnackBar(String message) {
    return SnackBar(
      content: Text(message, style: GoogleFonts.plusJakartaSans()),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      duration: const Duration(seconds: 3),
    );
  }

  /// Function to show confirm dialog with two action button
  static Future<void> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String question,
    VoidCallback? onPressedPrimaryAction,
    VoidCallback? onPressedSecondaryAction,
  }) async {
    showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      transitionBuilder: (context, animStart, animEnd, child) {
        final curvedValue = Curves.ease.transform(animStart.value) - 3.75;
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
                          onPressed: onPressedPrimaryAction,
                          child: const Text(
                            'Oke',
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
                          onPressed: onPressedSecondaryAction,
                          child: const Text(
                            'Batal',
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
}
