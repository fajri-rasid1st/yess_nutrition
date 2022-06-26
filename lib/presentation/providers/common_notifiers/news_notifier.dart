import 'package:flutter/material.dart';

class NewsNotifier extends ChangeNotifier {
  bool _isFabVisible = false;

  bool get isFabVisible => _isFabVisible;

  set isFabVisible(bool value) {
    _isFabVisible = value;
    notifyListeners();
  }
}
