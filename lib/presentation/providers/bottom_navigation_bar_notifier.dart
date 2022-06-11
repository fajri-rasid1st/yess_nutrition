import 'package:flutter/foundation.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';

class BottomNavigationBarNotifier extends ChangeNotifier {
  MenuNavBar _selectedMenu = MenuNavBar.home;

  MenuNavBar get selectedMenu => _selectedMenu;

  void changeMenu(MenuNavBar menu) {
    _selectedMenu = menu;
    notifyListeners();
  }
}
