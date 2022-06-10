import 'package:flutter/material.dart';

class InputPasswordNotifier extends ChangeNotifier {
  bool _isSignInPasswordVisible = false;
  bool _isSignUpPasswordVisible = false;
  bool _isSignUpConfirmPasswordVisible = false;
  String _signUpPasswordValue = '';

  bool get isSignInPasswordVisible => _isSignInPasswordVisible;
  bool get isSignUpPasswordVisible => _isSignUpPasswordVisible;
  bool get isSignUpConfirmPasswordVisible => _isSignUpConfirmPasswordVisible;
  String get signUpPasswordValue => _signUpPasswordValue;

  set isSignInPasswordVisible(bool value) {
    _isSignInPasswordVisible = value;
    notifyListeners();
  }

  set isSignUpPasswordVisible(bool value) {
    _isSignUpPasswordVisible = value;
    notifyListeners();
  }

  set isSignUpConfirmPasswordVisible(bool value) {
    _isSignUpConfirmPasswordVisible = value;
    notifyListeners();
  }

  set signUpPasswordValue(String value) {
    _signUpPasswordValue = value;
    notifyListeners();
  }
}
