import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:yess_nutrition/common/utils/exception.dart';

abstract class UserStorageDataSource {
  Future<void> uploadProfilePicture(String path, String name);
}

class UserStorageDataSourceImpl implements UserStorageDataSource {
  final FirebaseStorage firebaseStorage;

  UserStorageDataSourceImpl({required this.firebaseStorage});

  @override
  Future<void> uploadProfilePicture(String path, String name) async {
    File file = File(path);

    try {
      await firebaseStorage.ref('profile_picture/$name').putFile(file);
    } catch (e) {
      throw StorageException(e.toString());
    }
  }
}
