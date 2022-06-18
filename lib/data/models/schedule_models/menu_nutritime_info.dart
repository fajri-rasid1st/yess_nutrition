
import 'package:flutter/foundation.dart';
import 'package:yess_nutrition/common/utils/nutritime_enum.dart';

class MenuInfo extends ChangeNotifier {
  MenuType menuType;
  String title;
  String imageSource;
  MenuInfo(this.menuType, {required this.title, required this.imageSource});

  updateMenu(MenuInfo menuInfo) {
    this.menuType = menuInfo.menuType;
    this.title = menuInfo.title;
    this.imageSource = menuInfo.imageSource;

//Important
    notifyListeners();
  }
}
