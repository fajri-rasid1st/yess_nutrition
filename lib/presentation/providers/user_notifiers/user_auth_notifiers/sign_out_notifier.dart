import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/user_auth_usecases/sign_out.dart';

class SignOutNotifier extends ChangeNotifier {
  final SignOut signOutUseCase;

  SignOutNotifier({required this.signOutUseCase});

  UserState _state = UserState.empty;
  UserState get state => _state;

  String _error = '';
  String get error => _error;

  Future<void> signOut() async {
    final result = await signOutUseCase.execute();

    result.fold(
      (failure) {
        _error = failure.message;
        _state = UserState.error;
      },
      (_) {
        _state = UserState.success;
      },
    );

    notifyListeners();
  }
}
