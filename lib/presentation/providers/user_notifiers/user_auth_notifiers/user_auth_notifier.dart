import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/user_auth_usecases/delete_user.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/user_auth_usecases/reset_password.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/user_auth_usecases/sign_in.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/user_auth_usecases/sign_in_with_google.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/user_auth_usecases/sign_out.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/user_auth_usecases/sign_up.dart';

class UserAuthNotifier extends ChangeNotifier {
  final SignIn signInUseCase;
  final SignInWithGoogle signInWithGoogleUseCase;
  final SignUp signUpUseCase;
  final ResetPassword resetPasswordUseCase;
  final SignOut signOutUseCase;
  final DeleteUser deleteUserUseCase;

  UserAuthNotifier({
    required this.signInUseCase,
    required this.signInWithGoogleUseCase,
    required this.signUpUseCase,
    required this.resetPasswordUseCase,
    required this.signOutUseCase,
    required this.deleteUserUseCase,
  });

  UserState _state = UserState.empty;
  UserState get state => _state;

  late UserEntity _user;
  UserEntity get user => _user;

  late UserEntity? _userFromGoogle;
  UserEntity? get userFromGoogle => _userFromGoogle;

  String _success = '';
  String get success => _success;

  String _error = '';
  String get error => _error;

  Future<void> signIn(String email, String password) async {
    final result = await signInUseCase.execute(email, password);

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

  Future<void> signInWithGoogle() async {
    final result = await signInWithGoogleUseCase.execute();

    result.fold(
      (failure) {
        _error = failure.message;
        _state = UserState.error;
      },
      (userFromGoogle) {
        _userFromGoogle = userFromGoogle;

        if (_userFromGoogle != null) {
          _state = UserState.success;
        } else {
          _error = 'Pilih setidaknya satu akun untuk melanjutkan.';
          _state = UserState.error;
        }
      },
    );

    notifyListeners();
  }

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

  Future<void> resetPassword(String email) async {
    final result = await resetPasswordUseCase.execute(email);

    result.fold(
      (failure) {
        _error = failure.message;
        _state = UserState.error;
      },
      (_) {
        _success = 'Tautan untuk mengubah password telah dikirim ke email anda';
        _state = UserState.success;
      },
    );

    notifyListeners();
  }

  Future<void> signOut() async {
    final result = await signOutUseCase.execute();

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

  Future<void> deleteUser() async {
    final result = await deleteUserUseCase.execute();

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
}
