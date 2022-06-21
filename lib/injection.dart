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
  // User auth providers
  locator.registerFactory(
    () => UserAuthNotifier(
      signInUseCase: locator(),
      signInWithGoogleUseCase: locator(),
      signUpUseCase: locator(),
      resetPasswordUseCase: locator(),
      signOutUseCase: locator(),
      deleteUserUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => GetUserNotifier(getUserUseCase: locator()),
  );

  // User firestore providers
  locator.registerFactory(
    () => UserFirestoreNotifier(
      createUserDataUseCase: locator(),
      readUserDataUseCase: locator(),
      updateUserDataUseCase: locator(),
      deleteUserDataUseCase: locator(),
      getUserStatusUseCase: locator(),
    ),
  );

  // User storage providers
  locator.registerFactory(
    () => UserStorageNotifier(uploadProfilePictureUseCase: locator()),
  );

  // Food providers
  locator.registerFactory(
    () => SearchFoodNotifier(searchFoodsUseCase: locator()),
  );
  locator.registerFactory(
    () => SearchProductNotifier(searchFoodsUseCase: locator()),
  );
  locator.registerFactory(
    () => FoodHistoryNotifier(
      addFoodHistoryUseCase: locator(),
      getFoodHistoriesUseCase: locator(),
      deleteFoodHistoryUseCase: locator(),
      clearFoodHistoriesUseCase: locator(),
    ),
  );

  // News providers
  locator.registerFactory(
    () => GetNewsNotifier(getNewsUseCase: locator()),
  );
  locator.registerFactory(
    () => SearchNewsNotifier(searchNewsUseCase: locator()),
  );
  locator.registerFactory(
    () => NewsBookmarkNotifier(
      createBookmarkUseCase: locator(),
      deleteBookmarkUseCase: locator(),
      getBookmarkStatusUseCase: locator(),
      getBookmarksUseCase: locator(),
      clearBookmarksUseCase: locator(),
    ),
  );

  // User auth usecases
  locator.registerLazySingleton(() => GetUser(locator()));
  locator.registerLazySingleton(() => SignIn(locator()));
  locator.registerLazySingleton(() => SignInWithGoogle(locator()));
  locator.registerLazySingleton(() => SignUp(locator()));
  locator.registerLazySingleton(() => SignOut(locator()));
  locator.registerLazySingleton(() => ResetPassword(locator()));
  locator.registerLazySingleton(() => DeleteUser(locator()));

  // User firestore usecases
  locator.registerLazySingleton(() => CreateUserData(locator()));
  locator.registerLazySingleton(() => ReadUserData(locator()));
  locator.registerLazySingleton(() => UpdateUserData(locator()));
  locator.registerLazySingleton(() => DeleteUserData(locator()));
  locator.registerLazySingleton(() => GetUserStatus(locator()));

  // User storage usecases
  locator.registerLazySingleton(() => UploadProfilePicture(locator()));

  // Food usecases
  locator.registerLazySingleton(() => SearchFoods(locator()));
  locator.registerLazySingleton(() => AddFoodHistory(locator()));
  locator.registerLazySingleton(() => GetFoodHistories(locator()));
  locator.registerLazySingleton(() => DeleteFoodHistory(locator()));
  locator.registerLazySingleton(() => ClearFoodHistories(locator()));

  // News usecases
  locator.registerLazySingleton(() => GetNews(locator()));
  locator.registerLazySingleton(() => SearchNews(locator()));
  locator.registerLazySingleton(() => CreateNewsBookmark(locator()));
  locator.registerLazySingleton(() => DeleteNewsBookmark(locator()));
  locator.registerLazySingleton(() => GetNewsBookmarkStatus(locator()));
  locator.registerLazySingleton(() => GetNewsBookmarks(locator()));
  locator.registerLazySingleton(() => ClearNewsBookmarks(locator()));

  // User repositories
  locator.registerLazySingleton<UserAuthRepository>(
    () => UserAuthRepositoryImpl(userAuthDataSource: locator()),
  );
  locator.registerLazySingleton<UserFirestoreRepository>(
    () => UserFirestoreRepositoryImpl(userFirestoreDataSource: locator()),
  );
  locator.registerLazySingleton<UserStorageRepository>(
    () => UserStorageRepositoryImpl(userStorageDataSource: locator()),
  );

  // Food repositories
  locator.registerLazySingleton<FoodRepository>(
    () => FoodRepositoryImpl(
      foodLocalDataSource: locator(),
      foodRemoteDataSource: locator(),
    ),
  );

  // News repositories
  locator.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      newsLocalDataSource: locator(),
      newsRemoteDataSource: locator(),
    ),
  );

  // User data sources
  locator.registerLazySingleton<UserAuthDataSource>(
    () => UserAuthDataSourceImpl(
      firebaseAuth: locator(),
      googleSignIn: locator(),
    ),
  );
  locator.registerLazySingleton<UserFirestoreDataSource>(
    () => UserFirestoreDataSourceImpl(firebaseFirestore: locator()),
  );
  locator.registerLazySingleton<UserStorageDataSource>(
    () => UserStorageDataSourceImpl(firebaseStorage: locator()),
  );

  // Food data sources
  locator.registerLazySingleton<FoodLocalDataSource>(
    () => FoodLocalDataSourceImpl(databaseHelper: locator()),
  );
  locator.registerLazySingleton<FoodRemoteDataSource>(
    () => FoodRemoteDataSourceImpl(client: locator()),
  );

  // News data sources
  locator.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSourceImpl(databaseHelper: locator()),
  );
  locator.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(client: locator()),
  );

  // Databases
  locator.registerLazySingleton(() => DatabaseHelper());

  // Services
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
  locator.registerLazySingleton(() => FirebaseStorage.instance);
  locator.registerLazySingleton(() => GoogleSignIn());

  // client w/ SSL pinning certified
  locator.registerLazySingleton(() => HttpSslPinning.client);
}
