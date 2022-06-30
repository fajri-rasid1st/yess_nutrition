import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/data/models/user_models/user_data_model.dart';
import 'package:yess_nutrition/data/models/user_models/user_food_schedule_model.dart';
import 'package:yess_nutrition/data/models/user_models/user_nutrients_model.dart';

abstract class UserFirestoreDataSource {
  /*
  * User Data Firestore Datasource
  */
  Future<void> createUserData(UserDataModel userData);

  Future<UserDataModel> readUserData(String uid);

  Future<void> updateUserData(UserDataModel userData);

  Future<bool> isNewUser(String uid);

  /*
  * User Nutrients Firestore Datasource
  */
  Future<String> createUserNutrients(UserNutrientsModel userNutrients);

  Future<UserNutrientsModel?> readUserNutrients(String uid);

  Future<String> updateUserNutrients(UserNutrientsModel userNutrients);

  /*
  * User Food Schedule Firestore Datasource
  */
  Future<String> createUserFoodSchedule(UserFoodScheduleModel schedule);

  Future<List<UserFoodScheduleModel>> readUserFoodSchedules(String uid);

  Future<String> updateUserFoodSchedule(UserFoodScheduleModel schedule);

  Future<String> deleteUserFoodSchedule(UserFoodScheduleModel schedule);

  Future<String> resetUserFoodSchedules(String uid);
}

class UserFirestoreDataSourceImpl implements UserFirestoreDataSource {
  final FirebaseFirestore firebaseFirestore;

  UserFirestoreDataSourceImpl({required this.firebaseFirestore});

  /*
  * User Data Firestore Datasource Implementations
  */
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

  /*
  * User Nutrients Firestore Datasource Implementations
  */
  @override
  Future<String> createUserNutrients(UserNutrientsModel userNutrients) async {
    try {
      final reference =
          firebaseFirestore.collection('user-nutrients').doc(userNutrients.uid);

      final document = userNutrients.toDocument();

      await reference.set(document);

      return 'Jadwal kebutuhan harian telah dibuat';
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

        final newSnapshot = await reference.get();

        return UserNutrientsModel.fromDocument(newSnapshot.data()!);
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

      await reference.update(document);

      return 'Jadwal kebutuhan harian berhasil diubah';
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  /*
  * User Food Schedule Firestore Datasource Implementations
  */
  @override
  Future<String> createUserFoodSchedule(UserFoodScheduleModel schedule) async {
    try {
      final reference = firebaseFirestore
          .collection('user-food-schedules')
          .doc(schedule.uid)
          .collection('food-schedules')
          .doc(schedule.id);

      final document = schedule.toDocument();

      await reference.set(document);

      return 'Berhasil membuat jadwal makan';
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<List<UserFoodScheduleModel>> readUserFoodSchedules(String uid) async {
    try {
      final reference = firebaseFirestore
          .collection('user-food-schedules')
          .doc(uid)
          .collection('food-schedules');

      final snapshot = await reference.get();

      final documents = snapshot.docs.map((doc) {
        return doc.data();
      }).toList();

      final models = documents.map((doc) {
        return UserFoodScheduleModel.fromDocument(doc);
      }).toList();

      return models;
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<String> updateUserFoodSchedule(UserFoodScheduleModel schedule) async {
    try {
      final reference = firebaseFirestore
          .collection('user-food-schedules')
          .doc(schedule.uid)
          .collection('food-schedules')
          .doc(schedule.id);

      final document = schedule.toDocument();

      await reference.update(document);

      return 'Jadwal makan telah diupdate';
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<String> deleteUserFoodSchedule(UserFoodScheduleModel schedule) async {
    try {
      final reference = firebaseFirestore
          .collection('user-food-schedules')
          .doc(schedule.uid)
          .collection('food-schedules')
          .doc(schedule.id);

      await reference.delete();

      return 'Jadwal berhasil dihapus dari list';
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }

  @override
  Future<String> resetUserFoodSchedules(String uid) async {
    try {
      final batch = firebaseFirestore.batch();

      final reference = firebaseFirestore
          .collection('user-food-schedules')
          .doc(uid)
          .collection('food-schedules');

      final snapshot = await reference.get();

      for (var doc in snapshot.docs) {
        batch.delete(doc.reference);
      }

      await batch.commit();

      return 'Semua jadwal makan telah berhasil dihapus';
    } catch (e) {
      throw FirestoreException(e.toString());
    }
  }
}
