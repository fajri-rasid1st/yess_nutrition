import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:yess_nutrition/data/datasources/user_auth_data_source.dart';
import 'package:yess_nutrition/data/datasources/user_firestore_data_source.dart';
import 'package:yess_nutrition/data/repositories/user_auth_repository_impl.dart';
import 'package:yess_nutrition/data/repositories/user_firestore_repository_impl.dart';
import 'package:yess_nutrition/domain/repositories/user_auth_repository.dart';
import 'package:yess_nutrition/domain/repositories/user_firestore_repository.dart';
import 'package:yess_nutrition/domain/usecases/user/auth_usecases/delete_user.dart';
import 'package:yess_nutrition/domain/usecases/user/auth_usecases/get_user.dart';
import 'package:yess_nutrition/domain/usecases/user/auth_usecases/reset_password.dart';
import 'package:yess_nutrition/domain/usecases/user/auth_usecases/sign_in.dart';
import 'package:yess_nutrition/domain/usecases/user/auth_usecases/sign_in_with_google.dart';
import 'package:yess_nutrition/domain/usecases/user/auth_usecases/sign_out.dart';
import 'package:yess_nutrition/domain/usecases/user/auth_usecases/sign_up.dart';
import 'package:yess_nutrition/domain/usecases/user/firestore_usecases/create_user_data.dart';
import 'package:yess_nutrition/domain/usecases/user/firestore_usecases/delete_user_data.dart';
import 'package:yess_nutrition/domain/usecases/user/firestore_usecases/read_user_data.dart';
import 'package:yess_nutrition/domain/usecases/user/firestore_usecases/update_user_data.dart';
import 'package:yess_nutrition/presentation/providers/user/auth_notifiers/delete_user_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user/auth_notifiers/reset_password_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user/auth_notifiers/sign_in_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user/auth_notifiers/sign_in_with_google_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user/auth_notifiers/sign_out_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user/auth_notifiers/sign_up_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user/auth_notifiers/get_user_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user/firestore_notifiers/create_user_data_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user/firestore_notifiers/delete_user_data_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user/firestore_notifiers/read_user_data_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user/firestore_notifiers/update_user_data_notifier.dart';

final locator = GetIt.instance;

void init() {
  // Auth provider
  locator.registerFactory(
    () => GetUserNotifier(getUserUseCase: locator()),
  );
  locator.registerFactory(
    () => SignInNotifier(signInUseCase: locator()),
  );
  locator.registerFactory(
    () => SignInWithGoogleNotifier(signInWithGoogleUseCase: locator()),
  );
  locator.registerFactory(
    () => SignUpNotifier(signUpUseCase: locator()),
  );
  locator.registerFactory(
    () => SignOutNotifier(signOutUseCase: locator()),
  );
  locator.registerFactory(
    () => ResetPasswordNotifier(resetPasswordUseCase: locator()),
  );
  locator.registerFactory(
    () => DeleteUserNotifier(deleteUserUseCase: locator()),
  );

  // Firestore provider
  locator.registerFactory(
    () => CreateUserDataNotifier(createUserDataUseCase: locator()),
  );
  locator.registerFactory(
    () => ReadUserDataNotifier(readUserDataUseCase: locator()),
  );
  locator.registerFactory(
    () => UpdateUserDataNotifier(updateUserDataUseCase: locator()),
  );
  locator.registerFactory(
    () => DeleteUserDataNotifier(deleteUserDataUseCase: locator()),
  );

  // Auth usecases
  locator.registerLazySingleton(() => GetUser(locator()));
  locator.registerLazySingleton(() => SignIn(locator()));
  locator.registerLazySingleton(() => SignInWithGoogle(locator()));
  locator.registerLazySingleton(() => SignUp(locator()));
  locator.registerLazySingleton(() => SignOut(locator()));
  locator.registerLazySingleton(() => ResetPassword(locator()));
  locator.registerLazySingleton(() => DeleteUser(locator()));

  // Firestore usecases
  locator.registerLazySingleton(() => CreateUserData(locator()));
  locator.registerLazySingleton(() => ReadUserData(locator()));
  locator.registerLazySingleton(() => UpdateUserData(locator()));
  locator.registerLazySingleton(() => DeleteUserData(locator()));

  // Repositories
  locator.registerLazySingleton<UserAuthRepository>(
    () => UserAuthRepositoryImpl(userAuthDataSource: locator()),
  );
  locator.registerLazySingleton<UserFirestoreRepository>(
    () => UserFirestoreRepositoryImpl(userFirestoreDataSource: locator()),
  );

  // Data sources
  locator.registerLazySingleton<UserAuthDataSource>(
    () => UserAuthDataSourceImpl(
      firebaseAuth: locator(),
      googleSignIn: locator(),
    ),
  );
  locator.registerLazySingleton<UserFirestoreDataSource>(
    () => UserFirestoreDataSourceImpl(firebaseFirestore: locator()),
  );

  // External
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
  locator.registerLazySingleton(() => FirebaseStorage.instance);
  locator.registerLazySingleton(() => GoogleSignIn());
}
