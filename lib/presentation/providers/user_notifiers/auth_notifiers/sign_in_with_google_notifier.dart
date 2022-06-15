import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/auth_usecases/sign_in_with_google.dart';

class SignInWithGoogleNotifier extends ChangeNotifier {
  final SignInWithGoogle signInWithGoogleUseCase;

  SignInWithGoogleNotifier({required this.signInWithGoogleUseCase});

  UserState _state = UserState.empty;
  UserState get state => _state;

  late UserEntity? _user;
  UserEntity? get user => _user;

  String _error = '';
  String get error => _error;

  Future<void> signInWithGoogle() async {
    final result = await signInWithGoogleUseCase.execute();

    result.fold(
      (failure) {
        _error = failure.message;
        _state = UserState.error;
      },
      (user) {
        _user = user;

        if (user != null) {
          _state = UserState.success;
        } else {
          _error = 'Pilih setidaknya satu akun untuk melanjutkan.';
          _state = UserState.error;
        }
      },
    );

    notifyListeners();
  }
}
