import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/domain/usecases/firestore_usecases/read_user_data.dart';

class ReadUserDataNotifier extends ChangeNotifier {
  final ReadUserData readUserDataUseCase;

  ReadUserDataNotifier({required this.readUserDataUseCase});

  UserState _state = UserState.empty;
  UserState get state => _state;

  late Stream<UserEntity> _user;
  Stream<UserEntity> get user => _user;

  String _error = '';
  String get error => _error;

  void readUserData(String uid) {
    final result = readUserDataUseCase.execute(uid);

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
