import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:yess_nutrition/data/datasources/user_auth_data_source.dart';
import 'package:yess_nutrition/data/repositories/user_auth_repository_impl.dart';
import 'package:yess_nutrition/domain/repositories/user_auth_repository.dart';
import 'package:yess_nutrition/domain/usecases/auth_usecases/delete_user.dart';
import 'package:yess_nutrition/domain/usecases/auth_usecases/get_user.dart';
import 'package:yess_nutrition/domain/usecases/auth_usecases/reset_password.dart';
import 'package:yess_nutrition/domain/usecases/auth_usecases/sign_in.dart';
import 'package:yess_nutrition/domain/usecases/auth_usecases/sign_out.dart';
import 'package:yess_nutrition/domain/usecases/auth_usecases/sign_up.dart';
import 'package:yess_nutrition/presentation/providers/auth_notifiers/delete_user_notifier.dart';
import 'package:yess_nutrition/presentation/providers/auth_notifiers/reset_password_notifier.dart';
import 'package:yess_nutrition/presentation/providers/auth_notifiers/sign_in_notifier.dart';
import 'package:yess_nutrition/presentation/providers/auth_notifiers/sign_out_notifier.dart';
import 'package:yess_nutrition/presentation/providers/auth_notifiers/sign_up_notifier.dart';
import 'package:yess_nutrition/presentation/providers/auth_notifiers/user_notifier.dart';

final locator = GetIt.instance;

void init() {
  // Auth provider
  locator.registerFactory(
    () => UserNotifier(getUserUseCase: locator()),
  );
  locator.registerFactory(
    () => SignInNotifier(signInUseCase: locator()),
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

  // Auth usecases
  locator.registerLazySingleton(() => GetUser(locator()));
  locator.registerLazySingleton(() => SignIn(locator()));
  locator.registerLazySingleton(() => SignUp(locator()));
  locator.registerLazySingleton(() => SignOut(locator()));
  locator.registerLazySingleton(() => ResetPassword(locator()));
  locator.registerLazySingleton(() => DeleteUser(locator()));

  // Repositories
  locator.registerLazySingleton<UserAuthRepository>(
    () => UserAuthRepositoryImpl(userAuthDataSource: locator()),
  );

  // Data sources
  locator.registerLazySingleton<UserAuthDataSource>(
    () => UserAuthDataSourceImpl(firebaseAuth: locator()),
  );

  // External
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseStorage.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
}
