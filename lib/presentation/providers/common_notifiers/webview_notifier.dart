import 'package:flutter/material.dart';

class WebViewNotifier extends ChangeNotifier {
  double _progress = 0;

  double get progress => _progress;

  set progress(double value) {
    _progress = value;
    notifyListeners();
  }
}
