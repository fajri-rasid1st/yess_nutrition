import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/user_data_entity.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/firestore_usecases/read_user_data.dart';

class ReadUserDataNotifier extends ChangeNotifier {
  final ReadUserData readUserDataUseCase;

  ReadUserDataNotifier({required this.readUserDataUseCase});

  UserState _state = UserState.empty;
  UserState get state => _state;

  late UserDataEntity _userData;
  UserDataEntity get userData => _userData;

  String _error = '';
  String get error => _error;

  Future<void> readUserData(String uid) async {
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
