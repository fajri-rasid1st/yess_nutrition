import 'package:firebase_auth/firebase_auth.dart';
import 'package:yess_nutrition/data/models/user_model.dart';

abstract class UserAuthDataSource {
  Stream<UserModel?> getUser();

  Future<UserModel> signIn(String email, String password);

  Future<UserModel> signUp(String email, String password);

  Future<void> signOut();

  Future<void> resetPassword(String email);

  Future<void> deleteUser();
}

class UserAuthDataSourceImpl implements UserAuthDataSource {
  final FirebaseAuth firebaseAuth;

  UserAuthDataSourceImpl({required this.firebaseAuth});

  @override
  Stream<UserModel?> getUser() {
    try {
      return firebaseAuth.authStateChanges().map((user) {
        if (user == null) return null;

        return UserModel.fromUserCredential(user);
      });
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    }
  }

  @override
  Future<UserModel> signIn(String email, String password) async {
    try {
      final credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return UserModel.fromUserCredential(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    }
  }

  @override
  Future<UserModel> signUp(String email, String password) async {
    try {
      final credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return UserModel.fromUserCredential(credential.user!);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    }
  }

  @override
  Future<void> signOut() async {
    try {
      return await firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      return await firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    }
  }

  @override
  Future<void> deleteUser() async {
    try {
      return await firebaseAuth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    }
  }
}
