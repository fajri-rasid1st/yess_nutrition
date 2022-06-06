import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';

SnackBar createSnackBar(String message) {
  return SnackBar(
    content: Text(message, style: GoogleFonts.plusJakartaSans()),
    backgroundColor: secondaryBackgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    duration: const Duration(seconds: 3),
  );
}
