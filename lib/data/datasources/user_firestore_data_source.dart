import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/data/models/user_model.dart';

abstract class UserFirestoreDataSource {
  Future<void> createUserData(UserModel user);

  Stream<UserModel> readUserData(String uid);

  Future<void> updateUserData(UserModel user);

  Future<void> deleteUserData(UserModel user);
}

class UserFirestoreDataSourceImpl implements UserFirestoreDataSource {
  final FirebaseFirestore firebaseFirestore;

  UserFirestoreDataSourceImpl({required this.firebaseFirestore});

  @override
  Future<void> createUserData(UserModel user) async {
    try {
      final reference = firebaseFirestore.collection('users').doc(user.uid);

      final userDocument = user.toDocument();

      await reference.set(userDocument);
    } catch (e) {
      throw FirestoreException('Something went wrong');
    }
  }

  @override
  Stream<UserModel> readUserData(String uid) {
    try {
      final reference = firebaseFirestore.collection('users').doc(uid);

      final snapshots = reference.snapshots();

      final userStream = snapshots.map((snapshot) {
        return UserModel.fromDocument(snapshot.data()!);
      });

      return userStream;
    } catch (e) {
      throw FirestoreException('Something went wrong');
    }
  }

  @override
  Future<void> updateUserData(UserModel user) {
    // TODO: implement updateUserData
    throw UnimplementedError();
  }

  @override
  Future<void> deleteUserData(UserModel user) {
    // TODO: implement deleteUserData
    throw UnimplementedError();
  }
}
