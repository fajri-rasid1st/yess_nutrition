import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/domain/usecases/auth_usecases/sign_in.dart';

class SignInNotifier extends ChangeNotifier {
  final SignIn signInUseCase;

  SignInNotifier({required this.signInUseCase});

  AuthState _state = AuthState.empty;
  AuthState get state => _state;

  late UserEntity _user;
  UserEntity get user => _user;

  String _error = '';
  String get error => _error;

  Future<void> signIn(String email, String password) async {
    final result = await signInUseCase.execute(email, password);

    result.fold(
      (failure) {
        _error = failure.message;
        _state = AuthState.error;
        notifyListeners();
      },
      (user) {
        _user = user;
        _state = AuthState.success;
        notifyListeners();
      },
    );
  }
}
