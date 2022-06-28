import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:yess_nutrition/common/utils/exception.dart';

abstract class UserStorageDataSource {
  Future<String> uploadProfilePicture(String path, String name);
  Future<void> deleteProfilePicture(String filename);
}

class UserStorageDataSourceImpl implements UserStorageDataSource {
  final FirebaseStorage firebaseStorage;

  UserStorageDataSourceImpl({required this.firebaseStorage});

  @override
  Future<String> uploadProfilePicture(String path, String name) async {
    File file = File(path);

    try {
      final upload =
          await firebaseStorage.ref('profile_picture/$name').putFile(file);

      return upload.ref.getDownloadURL();
    } catch (e) {
      throw StorageException(e.toString());
    }
  }

  @override
  Future<void> deleteProfilePicture(String filename) async {
    try {
      await firebaseStorage.ref('profile_picture/$filename.jpg').delete();
    } catch (e) {
      throw StorageException(e.toString());
    }
  }
}
