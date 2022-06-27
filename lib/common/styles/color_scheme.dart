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
const clockOutlineColor = Color(0XFFEAECFF);
const clockBackgroundColor = Color(0XFF444974);

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

// Gradient color used for alarm schedule background color
class GradientColors {
  final List<Color> colors;

  const GradientColors(this.colors);

  static List<Color> sky = [
    const Color(0XFF6448FE),
    const Color(0XFF5FC6FF),
  ];

  static List<Color> sunset = [
    const Color(0XFFFE6197),
    const Color(0XFFFFB463),
  ];

  static List<Color> sea = [
    const Color(0XFF61A3FE),
    const Color(0XFF63FFD5),
  ];

  static List<Color> mango = [
    const Color(0XFFFFA738),
    const Color(0XFFFFE130),
  ];

  static List<Color> fire = [
    const Color(0XFFFF5DCD),
    const Color(0XFFFF8484),
  ];
}

// Gradient color template
class GradientTemplate {
  static List<GradientColors> gradientTemplate = [
    GradientColors(GradientColors.sky),
    GradientColors(GradientColors.sunset),
    GradientColors(GradientColors.sea),
    GradientColors(GradientColors.mango),
    GradientColors(GradientColors.fire),
  ];
}
