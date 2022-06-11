import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'common/utils/http_ssl_pinning.dart';
import 'data/datasources/datasources.dart';
import 'data/repositories/repositories.dart';
import 'domain/repositories/repositories.dart';
import 'domain/usecases/usecases.dart';
import 'presentation/providers/providers.dart';

final locator = GetIt.instance;

void init() {
  // Auth providers
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

  // Firestore providers
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
  
  // News providers
  locator.registerFactory(
    () => BookmarkNotifier(
      createBookmarkUseCase: locator(),
      deleteBookmarkUseCase: locator(),
      getBookmarkStatusUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => GetBookmarksNotifier(getBookmarksUseCase: locator()),
  );
  locator.registerFactory(
    () => GetNewsNotifier(getNewsUseCase: locator()),
  );
  locator.registerFactory(
    () => SearchNewsNotifier(searchNewsUseCase: locator()),
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

  // News usecases
  locator.registerLazySingleton(() => CreateBookmark(locator()));
  locator.registerLazySingleton(() => DeleteBookmark(locator()));
  locator.registerLazySingleton(() => GetBookmarkStatus(locator()));
  locator.registerLazySingleton(() => GetBookmarks(locator()));
  locator.registerLazySingleton(() => GetNews(locator()));
  locator.registerLazySingleton(() => SearchNews(locator()));

  // Repositories
  locator.registerLazySingleton<UserAuthRepository>(
    () => UserAuthRepositoryImpl(userAuthDataSource: locator()),
  );
  locator.registerLazySingleton<UserFirestoreRepository>(
    () => UserFirestoreRepositoryImpl(userFirestoreDataSource: locator()),
  );
  locator.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      newsLocalDataSource: locator(),
      newsRemoteDataSource: locator(),
    ),
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
  locator.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSourceImpl(newsDatabase: locator()),
  );
  locator.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(client: locator()),
  );

  // Databases
  locator.registerLazySingleton<NewsDatabase>(() => NewsDatabase());

  // Services
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
  locator.registerLazySingleton(() => FirebaseStorage.instance);
  locator.registerLazySingleton(() => GoogleSignIn());

  // client w/ SSL pinning certified
  locator.registerLazySingleton(() => HttpSslPinning.client);
}
