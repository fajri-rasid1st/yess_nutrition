import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/firestore_usecases/get_user_status.dart';

class UserStatusNotifier extends ChangeNotifier {
  final GetUserStatus getUserStatusUseCase;

  UserStatusNotifier({required this.getUserStatusUseCase});

  UserState _state = UserState.empty;
  UserState get state => _state;

  late bool _isNewUser;
  bool get isNewUser => _isNewUser;

  String _error = '';
  String get error => _error;

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
}
