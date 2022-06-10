import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/user_data_entity.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/firestore_usecases/create_user_data.dart';

class CreateUserDataNotifier extends ChangeNotifier {
  final CreateUserData createUserDataUseCase;

  CreateUserDataNotifier({required this.createUserDataUseCase});

  UserState _state = UserState.empty;
  UserState get state => _state;

  String _error = '';
  String get error => _error;

  Future<void> createUserData(UserDataEntity userData) async {
    final result = await createUserDataUseCase.execute(userData);

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
