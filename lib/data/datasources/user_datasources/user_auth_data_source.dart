import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yess_nutrition/data/models/user_models/user_model.dart';

abstract class UserAuthDataSource {
  Stream<UserModel?> getUser();

  Future<UserModel> signIn(String email, String password);

  Future<UserModel> signUp(String email, String password);

  Future<void> signOut();

  Future<void> resetPassword(String email);

  Future<void> deleteUser();

  // OAuth/third party sign in method
  Future<UserModel?> signInWithGoogle();
}

class UserAuthDataSourceImpl implements UserAuthDataSource {
  final FirebaseAuth firebaseAuth;
  final GoogleSignIn googleSignIn;

  UserAuthDataSourceImpl({
    required this.firebaseAuth,
    required this.googleSignIn,
  });

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
      final isSignInWithGoogle = await googleSignIn.isSignedIn();

      if (isSignInWithGoogle) {
        await googleSignIn.disconnect();
      }

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

  @override
  Future<UserModel?> signInWithGoogle() async {
    try {
      final googleAccount = await googleSignIn.signIn();

      if (googleAccount == null) return null;

      final googleAuth = await googleAccount.authentication;

      final oAuthcredential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final userCredential =
          await firebaseAuth.signInWithCredential(oAuthcredential);

      return UserModel.fromUserCredential(userCredential.user!);
    } on FirebaseAuthException catch (e) {
      throw FirebaseAuthException(code: e.code);
    } on PlatformException catch (e) {
      throw PlatformException(code: e.code);
    }
  }
}
