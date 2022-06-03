import 'package:flutter/foundation.dart';
import 'package:yess_nutrition/common/utils/state_enum.dart';

class BottomNavigationBarNotifier extends ChangeNotifier {
  MenuNavBar _selectedMenu = MenuNavBar.Home;

  MenuNavBar get selectedMenu => _selectedMenu;

  void changeMenu(MenuNavBar menu) {
    _selectedMenu = menu;
    notifyListeners();
  }
}
