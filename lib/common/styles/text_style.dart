import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_scheme.dart';

// Text Theme
// Based on: https://material.io/design/typography/the-type-system.html#type-scale
final myTextTheme = TextTheme(
  headline1: GoogleFonts.plusJakartaSans(
    fontSize: 94,
    fontWeight: FontWeight.w300,
    letterSpacing: -1.5,
  ),
  headline2: GoogleFonts.plusJakartaSans(
    fontSize: 59,
    fontWeight: FontWeight.w300,
    letterSpacing: -0.5,
  ),
  headline3: GoogleFonts.plusJakartaSans(
    fontSize: 47,
    fontWeight: FontWeight.w400,
  ),
  headline4: GoogleFonts.plusJakartaSans(
    fontSize: 33,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  headline5: GoogleFonts.plusJakartaSans(
    fontSize: 24,
    fontWeight: FontWeight.w400,
  ),
  headline6: GoogleFonts.plusJakartaSans(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.15,
  ),
  subtitle1: GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.15,
  ),
  subtitle2: GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
  ),
  bodyText1: GoogleFonts.plusJakartaSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
  ),
  bodyText2: GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
  ),
  button: GoogleFonts.plusJakartaSans(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.25,
  ),
  caption: GoogleFonts.plusJakartaSans(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
  ),
  overline: GoogleFonts.plusJakartaSans(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    letterSpacing: 1.5,
  ),
).apply(
  bodyColor: primaryTextColor,
  displayColor: primaryTextColor,
);
