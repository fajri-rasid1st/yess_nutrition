import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/usecases/auth_usecases/sign_out.dart';

class SignOutNotifier extends ChangeNotifier {
  final SignOut signOutUseCase;

  SignOutNotifier({required this.signOutUseCase});

  AuthState _state = AuthState.empty;
  AuthState get state => _state;

  String _error = '';
  String get error => _error;

  Future<void> signOut() async {
    final result = await signOutUseCase.execute();

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
