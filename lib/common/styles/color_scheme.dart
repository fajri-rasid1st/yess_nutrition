import 'package:flutter/material.dart';

// Colors
const primaryColor = Color(0XFF7165E3);
const secondaryColor = Color(0XFFE4DFFF);
const primaryBackgroundColor = Color(0XFFFFFFFF);
const secondaryBackgroundColor = Color(0XFF8B80F8);
const scaffoldBackgroundColor = Color(0XFFF5F6FA);
const primaryTextColor = Color(0XFF2E3142);
const secondaryTextColor = Color(0XFF9C9DB9);
const dividerColor = Color(0XFFC7C7DB);
const errorColor = Color(0XFFF9877B);

// Color Scheme
final myColorScheme = ColorScheme.fromSeed(
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
