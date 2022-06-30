import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/user_data_entity.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/user_firestore_usecases/create_user_data.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/user_firestore_usecases/get_user_status.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/user_firestore_usecases/read_user_data.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/user_firestore_usecases/update_user_data.dart';

class UserDataNotifier extends ChangeNotifier {
  final CreateUserData createUserDataUseCase;
  final ReadUserData readUserDataUseCase;
  final UpdateUserData updateUserDataUseCase;
  final GetUserStatus getUserStatusUseCase;

  UserDataNotifier({
    required this.createUserDataUseCase,
    required this.readUserDataUseCase,
    required this.updateUserDataUseCase,
    required this.getUserStatusUseCase,
  });

  UserState _state = UserState.empty;
  UserState get state => _state;

  String _error = '';
  String get error => _error;

  late UserDataEntity _userData;
  UserDataEntity get userData => _userData;

  late bool _isNewUser;
  bool get isNewUser => _isNewUser;

  bool _isReload = false;
  bool get isReload => _isReload;

  set isReload(bool value) {
    _isReload = value;
    notifyListeners();
  }

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

  Future<void> readUserData(String uid) async {
    _state = UserState.empty;
    notifyListeners();

    final result = await readUserDataUseCase.execute(uid);

    result.fold(
      (failure) {
        _error = failure.message;
        _state = UserState.error;
      },
      (userData) {
        _userData = userData;
        _state = UserState.success;
      },
    );

    notifyListeners();
  }

  Future<void> updateUserData(UserDataEntity userData) async {
    final result = await updateUserDataUseCase.execute(userData);

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

  Future<void> getUserStatus(String uid) async {
    final result = await getUserStatusUseCase.execute(uid);

    result.fold(
      (failure) {
        _error = failure.message;
        _state = UserState.error;
      },
      (isNewUser) {
        _isNewUser = isNewUser;
        _state = UserState.success;
      },
    );

    notifyListeners();
  }

  Future<void> refresh(String uid) async {
    final result = await readUserDataUseCase.execute(uid);

    result.fold(
      (failure) {
        _error = failure.message;
        _state = UserState.error;
      },
      (userData) {
        _userData = userData;
        _state = UserState.success;
      },
    );

    notifyListeners();
  }
}
