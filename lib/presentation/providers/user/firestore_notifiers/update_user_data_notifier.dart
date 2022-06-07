import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/user_data_entity.dart';
import 'package:yess_nutrition/domain/usecases/user/firestore_usecases/update_user_data.dart';

class UpdateUserDataNotifier extends ChangeNotifier {
  final UpdateUserData updateUserDataUseCase;

  UpdateUserDataNotifier({required this.updateUserDataUseCase});

  UserState _state = UserState.empty;
  UserState get state => _state;

  String _error = '';
  String get error => _error;

  Future<void> updateUserData(UserDataEntity userData) async {
    final result = await updateUserDataUseCase.execute(userData);

    result.fold(
      (failure) {
        _error = failure.message;
        _state = UserState.error;
        notifyListeners();
      },
      (_) {
        _state = UserState.success;
        notifyListeners();
      },
    );
  }
}
