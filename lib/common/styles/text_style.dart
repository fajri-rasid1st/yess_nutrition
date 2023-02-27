import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';

// Text theme
// Based on: https://material.io/design/typography/the-type-system.html#type-scale
final textTheme = TextTheme(
  displayLarge: GoogleFonts.plusJakartaSans(
    fontSize: 94,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  displayMedium: GoogleFonts.plusJakartaSans(
    fontSize: 59,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  displaySmall: GoogleFonts.plusJakartaSans(
    fontSize: 47,
    fontWeight: FontWeight.w400,
  ),
  headlineMedium: GoogleFonts.plusJakartaSans(
    fontSize: 33,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  headlineSmall: GoogleFonts.plusJakartaSans(
    fontSize: 24,
    fontWeight: FontWeight.w400,
  ),
  titleLarge: GoogleFonts.plusJakartaSans(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  titleMedium: GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  titleSmall: GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyLarge: GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyMedium: GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  labelLarge: GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  bodySmall: GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  labelSmall: GoogleFonts.plusJakartaSans(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
).apply(
  bodyColor: primaryTextColor,
  displayColor: primaryTextColor,
);
