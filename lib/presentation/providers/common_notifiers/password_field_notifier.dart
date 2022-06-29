import 'package:flutter/material.dart';

class PasswordFieldNotifier extends ChangeNotifier {
  bool _isSignInPasswordVisible = false;
  bool get isSignInPasswordVisible => _isSignInPasswordVisible;

  bool _isSignUpPasswordVisible = false;
  bool get isSignUpPasswordVisible => _isSignUpPasswordVisible;

  bool _isSignUpConfirmPasswordVisible = false;
  bool get isSignUpConfirmPasswordVisible => _isSignUpConfirmPasswordVisible;

  String _signUpPasswordValue = '';
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
