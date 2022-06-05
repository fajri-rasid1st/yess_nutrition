import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/domain/usecases/firestore_usecases/create_user_data.dart';

class CreateUserDataNotifier extends ChangeNotifier {
  final CreateUserData createUserDataUseCase;

  CreateUserDataNotifier({required this.createUserDataUseCase});

  UserState _state = UserState.empty;
  UserState get state => _state;

  String _error = '';
  String get error => _error;

  Future<void> createUserData(UserEntity user) async {
    final result = await createUserDataUseCase.execute(user);

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
