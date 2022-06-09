import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/auth_usecases/reset_password.dart';

class ResetPasswordNotifier extends ChangeNotifier {
  final ResetPassword resetPasswordUseCase;

  ResetPasswordNotifier({required this.resetPasswordUseCase});

  UserState _state = UserState.empty;
  UserState get state => _state;

  String _error = '';
  String get error => _error;

  String _success = '';
  String get success => _success;

  Future<void> resetPassword(String email) async {
    final result = await resetPasswordUseCase.execute(email);

    result.fold(
      (failure) {
        _error = failure.message;
        _state = UserState.error;
        notifyListeners();
      },
      (_) {
        _success = 'Tautan untuk mengubah password telah dikirim ke email anda';
        _state = UserState.success;
        notifyListeners();
      },
    );
  }
}
