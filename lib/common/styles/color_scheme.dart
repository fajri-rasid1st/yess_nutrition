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

  static const List<Color> morning = <Color>[
    secondaryBackgroundColor,
    Color.fromARGB(255, 82, 199, 235),
  ];

  static const List<Color> day = <Color>[
    primaryColor,
    Color.fromARGB(255, 48, 190, 233),
  ];

  static const List<Color> night = <Color>[
    Color(0XFF444974),
    Color.fromARGB(255, 22, 179, 226),
  ];
}

// Gradient template
const gradientTemplates = <GradientColors>[
  GradientColors(GradientColors.morning),
  GradientColors(GradientColors.day),
  GradientColors(GradientColors.night),
];
