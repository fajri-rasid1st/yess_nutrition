import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:uuid/uuid.dart';

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

  /// Function to convert [dateFormat] to time ago format
  static String dateFormatToTimeAgo(String dateFormat) {
    timeago.setLocaleMessages('id', timeago.IdMessages());

    return timeago.format(DateTime.parse(dateFormat), locale: 'id');
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

  /// Function to format [dateFormat] to **MMM dd, y** pattern
  static String dateFormatToMMMddy(String dateFormat) {
    if (dateFormat.isEmpty) return '?';

    final dateTime = DateTime.parse(dateFormat);

    return DateFormat('MMM dd, y').format(dateTime);
  }

  /// Function to generate [url] to uuid v5 (name-based)
  static String generateUuidV5(String url) {
    return const Uuid().v5(Uuid.NAMESPACE_URL, url);
  }
}
