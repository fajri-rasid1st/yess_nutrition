import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/user_auth_usecases/delete_user.dart';

class DeleteUserNotifier extends ChangeNotifier {
  final DeleteUser deleteUserUseCase;

  DeleteUserNotifier({required this.deleteUserUseCase});

  UserState _state = UserState.empty;
  UserState get state => _state;

  String _error = '';
  String get error => _error;

  Future<void> deleteUser() async {
    final result = await deleteUserUseCase.execute();

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
