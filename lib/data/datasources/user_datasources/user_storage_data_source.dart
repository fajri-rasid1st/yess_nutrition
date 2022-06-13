import 'package:firebase_storage/firebase_storage.dart';

abstract class UserStorageDataSource {
  /* create abstract method that required for user storage process
  *  e.g: uploadImage, deleteImage, etc
  *  See documentation: https://firebase.flutter.dev/docs/storage/start
  */
}

class UserStorageDataSourceImpl implements UserStorageDataSource {
  final FirebaseStorage firebaseStorage;

  UserStorageDataSourceImpl({required this.firebaseStorage});

  // implement methods
}
