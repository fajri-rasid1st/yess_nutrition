import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';

class BottomNavigationBarNotifier extends ChangeNotifier {
  MenuNavBar _selectedMenu = MenuNavBar.home;
  MenuNavBar get selectedMenu => _selectedMenu;

  set selectedMenu(MenuNavBar menu) {
    _selectedMenu = menu;
    notifyListeners();
  }

  Color _backgroundColor = scaffoldBackgroundColor;
  Color get backgroundColor => _backgroundColor;

  set backgroundColor(Color color) {
    _backgroundColor = color;
    notifyListeners();
  }
}
