import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/usecases/auth_usecases/delete_user.dart';

class DeleteUserNotifier extends ChangeNotifier {
  final DeleteUser deleteUserUseCase;

  DeleteUserNotifier({required this.deleteUserUseCase});

  AuthState _state = AuthState.empty;
  AuthState get state => _state;

  String _error = '';
  String get error => _error;

  Future<void> deleteUser() async {
    final result = await deleteUserUseCase.execute();

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
