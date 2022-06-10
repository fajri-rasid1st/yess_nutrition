import 'package:flutter/material.dart';

class FabNotifier extends ChangeNotifier {
  bool _isFabVisible = false;
  bool get isFabVisible => _isFabVisible;

  set isFabVisible(bool value) {
    _isFabVisible = value;
    notifyListeners();
  }
}
