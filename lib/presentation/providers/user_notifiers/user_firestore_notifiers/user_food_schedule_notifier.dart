import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/user_food_schedule_entity.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/user_firestore_usecases/user_firestore_usecases.dart';

class UserFoodScheduleNotifier extends ChangeNotifier {
  final CreateUserFoodSchedule createUserFoodScheduleUseCase;
  final ReadUserFoodSchedules readUserFoodSchedulesUseCase;
  final UpdateUserFoodSchedule updateUserFoodScheduleUseCase;
  final DeleteUserFoodSchedule deleteUserFoodScheduleUseCase;
  final ResetUserFoodSchedules resetUserFoodSchedulesUseCase;

  UserFoodScheduleNotifier({
    required this.createUserFoodScheduleUseCase,
    required this.readUserFoodSchedulesUseCase,
    required this.updateUserFoodScheduleUseCase,
    required this.deleteUserFoodScheduleUseCase,
    required this.resetUserFoodSchedulesUseCase,
  });

  UserState _state = UserState.empty;
  UserState get state => _state;

  String _message = '';
  String get message => _message;

  List<UserFoodScheduleEntity> _foodSchedules = <UserFoodScheduleEntity>[];
  List<UserFoodScheduleEntity> get foodSchedules => _foodSchedules;

  bool _isReload = false;
  bool get isReload => _isReload;

  set isReload(bool value) {
    _isReload = value;
    notifyListeners();
  }

  Future<void> createUserFoodSchedule(UserFoodScheduleEntity schedule) async {
    final result = await createUserFoodScheduleUseCase.execute(schedule);

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

  Future<void> readUserFoodSchedules(String uid, {bool refresh = false}) async {
    if (!refresh) {
      _state = UserState.empty;
      notifyListeners();
    }

    final result = await readUserFoodSchedulesUseCase.execute(uid);

    result.fold(
      (failure) {
        _message = failure.message;
        _state = UserState.error;
      },
      (foodSchedules) {
        _foodSchedules = foodSchedules;
        _state = UserState.success;
      },
    );

    notifyListeners();
  }

  Future<void> updateUserFoodSchedule(UserFoodScheduleEntity schedule) async {
    final result = await updateUserFoodScheduleUseCase.execute(schedule);

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

  Future<void> deleteUserFoodSchedule(UserFoodScheduleEntity schedule) async {
    final result = await deleteUserFoodScheduleUseCase.execute(schedule);

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

  Future<void> resetUserFoodSchedules(String uid) async {
    final result = await resetUserFoodSchedulesUseCase.execute(uid);

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
