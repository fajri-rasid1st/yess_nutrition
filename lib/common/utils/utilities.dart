import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;

class Utilities {
  /// Function to create snack bar with [message] as text that will be displayed
  static SnackBar createSnackBar(String message) {
    return SnackBar(
      content: Text(message, style: GoogleFonts.plusJakartaSans()),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      duration: const Duration(seconds: 3),
    );
  }

  /// Function to encrypt [text] with Salsa20 engine
  static String encryptText(String text) {
    final key = encrypt.Key.fromLength(32);
    final iv = encrypt.IV.fromLength(8);

    final encrypter = encrypt.Encrypter(encrypt.Salsa20(key));
    final encrypted = encrypter.encrypt(text, iv: iv);

    return encrypted.base64;
  }

  /// Function to convert [dateFormat] to time ago format
  static String dateFormatToTimeAgo(String dateFormat) {
    timeago.setLocaleMessages('id', timeago.IdMessages());

    return timeago.format(DateTime.parse(dateFormat), locale: 'id');
  }

  /// Function to convert [number] according to [decimalDigit]
  static String numberToIdr(dynamic number, int decimalDigit) {
    NumberFormat currencyFormatter = NumberFormat.currency(
      locale: 'id',
      symbol: '',
      decimalDigits: decimalDigit,
    );

    return currencyFormatter.format(number);
  }

  /// Function to format [dateFormat] to MMM dd, y pattern
  static String dateFormatToMMMddy(String dateFormat) {
    return dateFormat.isEmpty
        ? '?'
        : DateFormat('MMM dd, y').format(DateTime.parse(dateFormat));
  }
}
