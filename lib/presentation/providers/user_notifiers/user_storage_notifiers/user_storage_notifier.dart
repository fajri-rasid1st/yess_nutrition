import 'package:flutter/cupertino.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/user_storage_usecases/user_storage_usecases.dart';

class UserStorageNotifier extends ChangeNotifier {
  final UploadProfilePicture uploadProfilePictureUseCase;
  final DeleteProfilePicture deleteProfilePictureUseCase;

  UserStorageNotifier({
    required this.uploadProfilePictureUseCase,
    required this.deleteProfilePictureUseCase,
  });

  UserState _state = UserState.empty;
  UserState get state => _state;

  late String _downloadUrl;
  String get downloadUrl => _downloadUrl;

  String _error = '';
  String get error => _error;

  Future<void> uploadProfilePicture(String path, String name) async {
    final result = await uploadProfilePictureUseCase.execute(path, name);

    result.fold(
      (failure) {
        _error = failure.message;
        _state = UserState.error;
      },
      (url) {
        _downloadUrl = url;
        _state = UserState.success;
      },
    );

    notifyListeners();
  }

  Future<void> deleteProfilePicture(String filename) async {
    final result = await deleteProfilePictureUseCase.execute(filename);

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
