import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/usecases/auth_usecases/reset_password.dart';

class ResetPasswordNotifier extends ChangeNotifier {
  final ResetPassword resetPasswordUseCase;

  ResetPasswordNotifier({required this.resetPasswordUseCase});

  AuthState _state = AuthState.empty;
  AuthState get state => _state;

  String _error = '';
  String get error => _error;

  Future<void> resetPassword(String email) async {
    final result = await resetPasswordUseCase.execute(email);

    result.fold(
      (failure) {
         _error = failure.message;
        _state = AuthState.error;
        notifyListeners();
      },
      (_) {
        _state = AuthState.success;
        notifyListeners();
      },
    );
  }
}
