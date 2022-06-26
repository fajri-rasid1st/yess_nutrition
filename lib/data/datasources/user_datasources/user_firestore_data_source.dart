import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/data/models/user_models/user_data_model.dart';
import 'package:yess_nutrition/data/models/user_models/user_nutrients_model.dart';

abstract class UserFirestoreDataSource {
  Future<void> createUserData(UserDataModel userData);

  Future<UserDataModel> readUserData(String uid);

  Future<void> updateUserData(UserDataModel userData);

  Future<void> deleteUserData(String uid);

  Future<bool> isNewUser(String uid);

  Future<String> createUserNutrients(UserNutrientsModel userNutrients);

  Future<UserNutrientsModel?> readUserNutrients(String uid);

  Future<String> updateUserNutrients(UserNutrientsModel userNutrients);
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

      return UserDataModel.fromDocument(snapshot.data()!);
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<void> updateUserData(UserDataModel userData) async {
    try {
      final reference = firebaseFirestore.collection('users').doc(userData.uid);

      final userDocument = userData.toDocument();

      await reference.update(userDocument);
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<void> deleteUserData(String uid) async {
    try {
      final userReference = firebaseFirestore.collection('users').doc(uid);

      await userReference.delete();

      final userNutrientsReference =
          firebaseFirestore.collection('user-nutrients').doc(uid);

      await userNutrientsReference.delete();
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<bool> isNewUser(String uid) async {
    try {
      final result = await firebaseFirestore
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      final docs = result.docs;

      return docs.isEmpty ? true : false;
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<String> createUserNutrients(UserNutrientsModel userNutrients) async {
    try {
      final reference =
          firebaseFirestore.collection('user-nutrients').doc(userNutrients.uid);

      final document = userNutrients.toDocument();

      await reference.set(document);

      return 'Jadwal kebutuhan harian berhasil dibuat';
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<UserNutrientsModel?> readUserNutrients(String uid) async {
    try {
      final reference = firebaseFirestore.collection('user-nutrients').doc(uid);

      final snapshot = await reference.get();

      final document = snapshot.data();

      if (document == null) return null;

      final model = UserNutrientsModel.fromDocument(document);

      if (model.currentDate.day != DateTime.now().day) {
        await reference.update({
          'currentCalories': 0,
          'currentCarbohydrate': 0,
          'currentProtein': 0,
          'currentFat': 0,
          'currentDate': DateTime.now(),
        });
      }

      return model;
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<String> updateUserNutrients(UserNutrientsModel userNutrients) async {
    try {
      final reference =
          firebaseFirestore.collection('user-nutrients').doc(userNutrients.uid);

      final document = userNutrients.toDocument();

      await reference.set(document, SetOptions(merge: true));

      return 'Jadwal kebutuhan harian berhasil diubah';
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }
}
