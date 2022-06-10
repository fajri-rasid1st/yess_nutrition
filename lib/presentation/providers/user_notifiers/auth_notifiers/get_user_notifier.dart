import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/auth_usecases/get_user.dart';

class GetUserNotifier extends ChangeNotifier {
  final GetUser getUserUseCase;

  GetUserNotifier({required this.getUserUseCase}) {
    getUser();
  }

  UserState _state = UserState.empty;
  UserState get state => _state;

  late Stream<UserEntity?> _user;
  Stream<UserEntity?> get user => _user;

  String _error = '';
  String get error => _error;

  void getUser() {
    final result = getUserUseCase.execute();

    result.fold(
      (failure) {
        _error = failure.message;
        _state = UserState.error;
        notifyListeners();
      },
      (user) {
        _user = user;
        _state = UserState.success;
        notifyListeners();
      },
    );
  }
}
