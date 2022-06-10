import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/firestore_usecases/delete_user_data.dart';

class DeleteUserDataNotifier extends ChangeNotifier {
  final DeleteUserData deleteUserDataUseCase;

  DeleteUserDataNotifier({required this.deleteUserDataUseCase});

  UserState _state = UserState.empty;
  UserState get state => _state;

  String _error = '';
  String get error => _error;

  Future<void> deleteUserData(String uid) async {
    final result = await deleteUserDataUseCase.execute(uid);

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
