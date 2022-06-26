import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';

class MenuInfoNotifier extends ChangeNotifier {
  MenuType menuType;
  String title;
  String imageSource;

  MenuInfoNotifier({
    required this.menuType,
    required this.title,
    required this.imageSource,
  });

  updateMenu(MenuInfoNotifier menuInfo) {
    menuType = menuInfo.menuType;
    title = menuInfo.title;
    imageSource = menuInfo.imageSource;

    notifyListeners();
  }
}
