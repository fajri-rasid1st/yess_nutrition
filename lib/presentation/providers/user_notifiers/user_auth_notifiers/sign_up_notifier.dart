import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/user_auth_usecases/sign_up.dart';

class SignUpNotifier extends ChangeNotifier {
  final SignUp signUpUseCase;

  SignUpNotifier({required this.signUpUseCase});

  UserState _state = UserState.empty;
  UserState get state => _state;

  late UserEntity _user;
  UserEntity get user => _user;

  String _error = '';
  String get error => _error;

  Future<void> signUp(String email, String password) async {
    final result = await signUpUseCase.execute(email, password);

    result.fold(
      (failure) {
        _error = failure.message;
        _state = UserState.error;
      },
      (user) {
        _user = user;
        _state = UserState.success;
      },
    );

    notifyListeners();
  }
}
