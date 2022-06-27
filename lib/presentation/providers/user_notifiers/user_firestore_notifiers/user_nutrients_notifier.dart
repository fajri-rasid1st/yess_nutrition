import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/user_nutrients_entity.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/user_firestore_usecases/create_user_nutrients.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/user_firestore_usecases/read_user_nutrients.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/user_firestore_usecases/update_user_nutrients.dart';

class UserNutrientsNotifier extends ChangeNotifier {
  final CreateUserNutrients createUserNutrientsUseCase;
  final ReadUserNutrients readUserNutrientsUseCase;
  final UpdateUserNutrients updateUserNutrientsUseCase;

  UserNutrientsNotifier({
    required this.createUserNutrientsUseCase,
    required this.readUserNutrientsUseCase,
    required this.updateUserNutrientsUseCase,
  });

  UserState _state = UserState.empty;
  UserState get state => _state;

  String _message = '';
  String get message => _message;

  late UserNutrientsEntity? _userNutrients;
  UserNutrientsEntity? get userNutrients => _userNutrients;

  Future<void> createUserNutrients(UserNutrientsEntity userNutrients) async {
    final result = await createUserNutrientsUseCase.execute(userNutrients);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = UserState.error;
      },
      (message) {
        _message = message;
        _state = UserState.success;
      },
    );

    notifyListeners();
  }

  Future<void> readUserNutrients(String uid) async {
    final result = await readUserNutrientsUseCase.execute(uid);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = UserState.error;
      },
      (userNutrients) {
        _userNutrients = userNutrients;
        _state = UserState.success;
      },
    );

    notifyListeners();
  }

  Future<void> updateUserNutrients(UserNutrientsEntity userNutrients) async {
    final result = await updateUserNutrientsUseCase.execute(userNutrients);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = UserState.error;
      },
      (message) {
        _message = message;
        _state = UserState.success;
      },
    );

    notifyListeners();
  }
}
