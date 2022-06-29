import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';

class BottomNavbarNotifier extends ChangeNotifier {
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }

  Color _backgroundColor = scaffoldBackgroundColor;
  Color get backgroundColor => _backgroundColor;

  set backgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }
}
