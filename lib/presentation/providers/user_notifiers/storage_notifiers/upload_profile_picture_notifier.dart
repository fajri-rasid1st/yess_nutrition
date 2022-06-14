import 'package:flutter/cupertino.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/usecases/user_usecases/storage_usecases/storage_usecases.dart';

class UploadProfilePictureNotifier extends ChangeNotifier {
  final UploadProfilePicture uploadProfilePictureUseCase;

  UploadProfilePictureNotifier({required this.uploadProfilePictureUseCase});

  UserState _state = UserState.empty;
  UserState get state => _state;

  String _error = '';
  String get error => _error;

  late String _downloadURL;
  String get downloadURL => _downloadURL;

  Future<void> uploadProfilePicture(String path, String name) async {
    final result = await uploadProfilePictureUseCase.execute(path, name);

    result.fold(
      (failure) {
        _error = failure.message;
        _state = UserState.error;
      },
      (url) {
        _state = UserState.success;
        _downloadURL = url;
      },
    );

    notifyListeners();
  }
}
