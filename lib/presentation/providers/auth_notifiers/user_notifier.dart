import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/domain/usecases/auth_usecases/get_user.dart';

class UserNotifier extends ChangeNotifier {
  final GetUser getUserUseCase;

  UserNotifier({required this.getUserUseCase}) {
    getUser();
  }

  AuthState _state = AuthState.empty;
  AuthState get state => _state;

  late Stream<UserEntity?> _user;
  Stream<UserEntity?> get user => _user;

  String _error = '';
  String get error => _error;

  void getUser() {
    final result = getUserUseCase.execute();

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
