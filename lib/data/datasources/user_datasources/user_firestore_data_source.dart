import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/data/models/user_models/user_data_model.dart';

abstract class UserFirestoreDataSource {
  Future<void> createUserData(UserDataModel userData);

  Future<UserDataModel> readUserData(String uid);

  Future<void> updateUserData(UserDataModel userData);

  Future<void> deleteUserData(String uid);
}

class UserFirestoreDataSourceImpl implements UserFirestoreDataSource {
  final FirebaseFirestore firebaseFirestore;

  UserFirestoreDataSourceImpl({required this.firebaseFirestore});

  @override
  Future<void> createUserData(UserDataModel userData) async {
    try {
      final reference = firebaseFirestore.collection('users').doc(userData.uid);

      final userDocument = userData.toDocument();

      await reference.set(userDocument);
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<UserDataModel> readUserData(String uid) async {
    try {
      final reference = firebaseFirestore.collection('users').doc(uid);

      final snapshot = await reference.get();

      return UserDataModel.fromDocument(snapshot.data() ?? {});
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<void> updateUserData(UserDataModel userData) async {
    try {
      final reference = firebaseFirestore.collection('users').doc(userData.uid);

      await reference.update(userData.toDocument());
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<void> deleteUserData(String uid) async {
    try {
      final reference = firebaseFirestore.collection('users').doc(uid);

      await reference.delete();
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }
}
