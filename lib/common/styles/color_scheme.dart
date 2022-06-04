import 'package:flutter/material.dart';

// Colors
const Color primaryColor = Color(0XFF7165E3);
const Color secondaryColor = Color(0XFFE4DFFF);
const Color primaryBackgroundColor = Color(0XFFFFFFFF);
const Color secondaryBackgroundColor = Color(0XFF8B80F8);
const Color scaffoldBackgroundColor = Color(0XFFF5F6FA);
const Color primaryTextColor = Color(0XFF2E3142);
const Color secondaryTextColor = Color(0XFF9C9DB9);
const Color dividerColor = Color(0XFFC7C7DB);
const Color errorColor = Color(0XFFF9877B);

// Color Scheme
final ColorScheme myColorScheme = ColorScheme.fromSeed(
  seedColor: primaryColor,
  brightness: Brightness.light,
  primary: primaryColor,
  onPrimary: primaryBackgroundColor,
  secondary: secondaryColor,
  onSecondary: primaryColor,
  background: primaryBackgroundColor,
  onBackground: primaryTextColor,
  error: errorColor,
);