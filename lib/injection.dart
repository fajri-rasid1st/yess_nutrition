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
  /*
  * Provider section
  */

  // User auth providers
  locator.registerFactory(
    () => UserAuthNotifier(
      signInUseCase: locator(),
      signInWithGoogleUseCase: locator(),
      signUpUseCase: locator(),
      resetPasswordUseCase: locator(),
      signOutUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => GetUserNotifier(getUserUseCase: locator()),
  );

  // User firestore providers
  locator.registerFactory(
    () => UserDataNotifier(
      createUserDataUseCase: locator(),
      readUserDataUseCase: locator(),
      updateUserDataUseCase: locator(),
      getUserStatusUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => UserNutrientsNotifier(
      createUserNutrientsUseCase: locator(),
      readUserNutrientsUseCase: locator(),
      updateUserNutrientsUseCase: locator(),
    ),
  );
  locator.registerFactory(
    () => UserFoodScheduleNotifier(
      createUserFoodScheduleUseCase: locator(),
      readUserFoodSchedulesUseCase: locator(),
      updateUserFoodScheduleUseCase: locator(),
      deleteUserFoodScheduleUseCase: locator(),
      resetUserFoodSchedulesUseCase: locator(),
    ),
  );

  // User storage providers
  locator.registerFactory(
    () => UserStorageNotifier(
      uploadProfilePictureUseCase: locator(),
      deleteProfilePictureUseCase: locator(),
    ),
  );

  // Home Page Provider
  locator.registerFactory(
    () => HomePageNotifier(
      getNewsUseCase: locator(),
      getProductsUseCase: locator(),
    ),
  );

  // Schedule providers
  locator.registerFactory(
    () => ScheduleNotifier(
      createAlarmUseCase: locator(),
      getAlarmsUseCase: locator(),
      updateAlarmUseCase: locator(),
      deleteAlarmUseCase: locator(),
    ),
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

  // Recipe providers
  locator.registerFactory(
    () => SearchRecipesNotifier(searchRecipesUseCase: locator()),
  );
  locator.registerFactory(
    () => GetRecipeDetailNotifier(getRecipeDetailUseCase: locator()),
  );
  locator.registerFactory(
    () => RecipeBookmarkNotifier(
      createRecipeBookmarkUseCase: locator(),
      deleteRecipeBookmarkUseCase: locator(),
      getRecipeBookmarkStatusUseCase: locator(),
      getRecipeBookmarksUseCase: locator(),
      clearRecipeBookmarksUseCase: locator(),
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
      createNewsBookmarkUseCase: locator(),
      deleteNewsBookmarkUseCase: locator(),
      getNewsBookmarkStatusUseCase: locator(),
      getNewsBookmarksUseCase: locator(),
      clearNewsBookmarksUseCase: locator(),
    ),
  );

  // Product providers
  locator.registerFactory(
    () => ProductsNotifier(getProductsUseCase: locator()),
  );
  locator.registerFactory(
    () => ProductListNotifier(getProductsUseCase: locator()),
  );

  locator.registerFactory(
    () => FavoriteProductNotifier(
      createFavoriteProductUseCase: locator(),
      deleteFavoriteProductUseCase: locator(),
      getFavoriteProductStatusUseCase: locator(),
      getFavoriteProductsUseCase: locator(),
      clearFavoriteProductsUseCase: locator(),
    ),
  );

  /*
  * Use cases section
  */

  // User auth usecases
  locator.registerLazySingleton(() => GetUser(locator()));
  locator.registerLazySingleton(() => SignIn(locator()));
  locator.registerLazySingleton(() => SignInWithGoogle(locator()));
  locator.registerLazySingleton(() => SignUp(locator()));
  locator.registerLazySingleton(() => SignOut(locator()));
  locator.registerLazySingleton(() => ResetPassword(locator()));

  // User firestore usecases
  locator.registerLazySingleton(() => CreateUserData(locator()));
  locator.registerLazySingleton(() => ReadUserData(locator()));
  locator.registerLazySingleton(() => UpdateUserData(locator()));
  locator.registerLazySingleton(() => GetUserStatus(locator()));
  locator.registerLazySingleton(() => CreateUserNutrients(locator()));
  locator.registerLazySingleton(() => ReadUserNutrients(locator()));
  locator.registerLazySingleton(() => UpdateUserNutrients(locator()));
  locator.registerLazySingleton(() => CreateUserFoodSchedule(locator()));
  locator.registerLazySingleton(() => ReadUserFoodSchedules(locator()));
  locator.registerLazySingleton(() => UpdateUserFoodSchedule(locator()));
  locator.registerLazySingleton(() => DeleteUserFoodSchedule(locator()));
  locator.registerLazySingleton(() => ResetUserFoodSchedules(locator()));

  // User storage usecases
  locator.registerLazySingleton(() => UploadProfilePicture(locator()));
  locator.registerLazySingleton(() => DeleteProfilePicture(locator()));

  // Schedule usecases
  locator.registerLazySingleton(() => CreateAlarm(locator()));
  locator.registerLazySingleton(() => GetAlarms(locator()));
  locator.registerLazySingleton(() => UpdateAlarm(locator()));
  locator.registerLazySingleton(() => DeleteAlarm(locator()));

  // Food usecases
  locator.registerLazySingleton(() => SearchFoods(locator()));
  locator.registerLazySingleton(() => AddFoodHistory(locator()));
  locator.registerLazySingleton(() => GetFoodHistories(locator()));
  locator.registerLazySingleton(() => DeleteFoodHistory(locator()));
  locator.registerLazySingleton(() => ClearFoodHistories(locator()));

  // Recipe usecases
  locator.registerLazySingleton(() => SearchRecipes(locator()));
  locator.registerLazySingleton(() => GetRecipeDetail(locator()));
  locator.registerLazySingleton(() => CreateRecipeBookmark(locator()));
  locator.registerLazySingleton(() => DeleteRecipeBookmark(locator()));
  locator.registerLazySingleton(() => GetRecipeBookmarkStatus(locator()));
  locator.registerLazySingleton(() => GetRecipeBookmarks(locator()));
  locator.registerLazySingleton(() => ClearRecipeBookmarks(locator()));

  // News usecases
  locator.registerLazySingleton(() => GetNews(locator()));
  locator.registerLazySingleton(() => SearchNews(locator()));
  locator.registerLazySingleton(() => CreateNewsBookmark(locator()));
  locator.registerLazySingleton(() => DeleteNewsBookmark(locator()));
  locator.registerLazySingleton(() => GetNewsBookmarkStatus(locator()));
  locator.registerLazySingleton(() => GetNewsBookmarks(locator()));
  locator.registerLazySingleton(() => ClearNewsBookmarks(locator()));

  // Product usecases
  locator.registerLazySingleton(() => GetProducts(locator()));
  locator.registerLazySingleton(() => CreateFavoriteProduct(locator()));
  locator.registerLazySingleton(() => DeleteFavoriteProduct(locator()));
  locator.registerLazySingleton(() => GetFavoriteProductStatus(locator()));
  locator.registerLazySingleton(() => GetFavoriteProducts(locator()));
  locator.registerLazySingleton(() => ClearFavoriteProducts(locator()));

  /*
  * Repositories section
  */

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

  // Schedule repositories
  locator.registerLazySingleton<ScheduleRepository>(
    () => ScheduleRepositoryImpl(scheduleDataSource: locator()),
  );

  // Food repositories
  locator.registerLazySingleton<FoodRepository>(
    () => FoodRepositoryImpl(
      foodLocalDataSource: locator(),
      foodRemoteDataSource: locator(),
    ),
  );

  // Recipe repositories
  locator.registerLazySingleton<RecipeRepository>(
    () => RecipeRepositoryImpl(
      recipeLocalDataSource: locator(),
      recipeRemoteDataSource: locator(),
    ),
  );

  // News repositories
  locator.registerLazySingleton<NewsRepository>(
    () => NewsRepositoryImpl(
      newsLocalDataSource: locator(),
      newsRemoteDataSource: locator(),
    ),
  );

  // Product repositories
  locator.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(
      productLocalDataSource: locator(),
      productRemoteDataSource: locator(),
    ),
  );

  /*
  * Data sources section
  */

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

  // Schedule data sources
  locator.registerLazySingleton<ScheduleDataSource>(
    () => ScheduleDataSourceImpl(databaseHelper: locator()),
  );

  // Food data sources
  locator.registerLazySingleton<FoodLocalDataSource>(
    () => FoodLocalDataSourceImpl(databaseHelper: locator()),
  );
  locator.registerLazySingleton<FoodRemoteDataSource>(
    () => FoodRemoteDataSourceImpl(client: locator()),
  );

  // Recipe data sources
  locator.registerLazySingleton<RecipeLocalDataSource>(
    () => RecipeLocalDataSourceImpl(databaseHelper: locator()),
  );
  locator.registerLazySingleton<RecipeRemoteDataSource>(
    () => RecipeRemoteDataSourceImpl(client: locator()),
  );

  // News data sources
  locator.registerLazySingleton<NewsLocalDataSource>(
    () => NewsLocalDataSourceImpl(databaseHelper: locator()),
  );
  locator.registerLazySingleton<NewsRemoteDataSource>(
    () => NewsRemoteDataSourceImpl(client: locator()),
  );

  // News data sources
  locator.registerLazySingleton<ProductLocalDataSource>(
    () => ProductLocalDataSourceImpl(databaseHelper: locator()),
  );
  locator.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(client: locator()),
  );

  /*
  * Common services section
  */

  // Helper
  locator.registerLazySingleton(() => DatabaseHelper());
  locator.registerLazySingleton(() => NotificationHelper());

  // Services
  locator.registerLazySingleton(() => FirebaseAuth.instance);
  locator.registerLazySingleton(() => FirebaseFirestore.instance);
  locator.registerLazySingleton(() => FirebaseStorage.instance);
  locator.registerLazySingleton(() => GoogleSignIn());

  // client w/ SSL pinning certified
  locator.registerLazySingleton(() => HttpSslPinning.client);
}
