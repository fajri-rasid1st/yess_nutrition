import 'package:flutter/material.dart';

// Colors
const primaryColor = Color(0XFF7165E3);
const secondaryColor = Color(0XFFE4DFFF);
const primaryBackgroundColor = Color(0XFFFFFFFF);
const secondaryBackgroundColor = Color(0XFF8B80F8);
const scaffoldBackgroundColor = Color(0XFFF5F6FA);
const primaryTextColor = Color(0XFF2E3142);
const secondaryTextColor = Color(0XFF9C9DB9);
const dividerColor = Color(0XFFD2D1E1);
const errorColor = Color(0XFFF9877B);
const clockOutline = Color(0xFFEAECFF);
const clockBG = Color(0xFF444974);

// Color scheme
final colorScheme = ColorScheme.fromSeed(
  seedColor: primaryColor,
  brightness: Brightness.light,
  primary: primaryColor,
  onPrimary: primaryBackgroundColor,
  secondary: secondaryColor,
  onSecondary: primaryColor,
  background: primaryBackgroundColor,
  onBackground: primaryTextColor,
  error: errorColor,
  errorContainer: errorColor,
);

class GradientColors {
  final List<Color> colors;
  GradientColors(this.colors);

  static List<Color> sky = [const Color(0xFF6448FE), const Color(0xFF5FC6FF)];
  static List<Color> sunset = [
    const Color(0xFFFE6197),
    const Color(0xFFFFB463)
  ];
  static List<Color> sea = [const Color(0xFF61A3FE), const Color(0xFF63FFD5)];
  static List<Color> mango = [const Color(0xFFFFA738), const Color(0xFFFFE130)];
  static List<Color> fire = [const Color(0xFFFF5DCD), const Color(0xFFFF8484)];
}

class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
  ];
}

class CustomColors {
  static Color primaryTextColor = Colors.white;
  static Color dividerColor = Colors.white54;
  static Color pageBackgroundColor = const Color(0xFF2D2F41);
  static Color menuBackgroundColor = const Color(0xFF242634);

  static Color clockBG = const Color(0xFF444974);
  static Color clockOutline = const Color(0xFFEAECFF);
  static Color? secHandColor = Colors.orange[300];
  static Color minHandStatColor = const Color(0xFF748EF6);
  static Color minHandEndColor = const Color(0xFF77DDFF);
  static Color hourHandStatColor = const Color(0xFFC279FB);
  static Color hourHandEndColor = const Color(0xFFEA74AB);
}
