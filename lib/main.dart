import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'common/styles/styles.dart';
import 'common/utils/http_ssl_pinning.dart';
import 'common/utils/keys.dart';
import 'common/utils/routes.dart';
import 'data/datasources/helpers/notification_helper.dart';
import 'domain/entities/entities.dart';
import 'firebase_options.dart';
import 'injection.dart' as di;
import 'presentation/pages/pages.dart';
import 'presentation/providers/providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Prevent landscape orientation
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Change status bar and navigation color
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: primaryBackgroundColor,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  // Initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize ssl pinning
  await HttpSslPinning.init();

  // Initialize service locator
  di.init();

  // Initialize notification
  await di.locator<NotificationHelper>().initNotifications();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: <SingleChildWidget>[
        ChangeNotifierProvider(
          create: (_) => di.locator<GetUserNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<UserAuthNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<UserDataNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<UserNutrientsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<UserFoodScheduleNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<UserStorageNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ScheduleNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchFoodNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchProductNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<FoodHistoryNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchRecipesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<GetRecipeDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<RecipeBookmarkNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<GetNewsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchNewsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<NewsBookmarkNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ProductsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ProductListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<FavoriteProductNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => BottomNavbarNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => PasswordFieldNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => WebViewNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => ScheduleTimeNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => NewsFabNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<HomePageNotifier>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Yess Nutrition',
        theme: ThemeData(
          fontFamily: 'Plus Jakarta Sans',
          colorScheme: colorScheme,
          textTheme: textTheme,
          dividerColor: dividerColor,
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          inputDecorationTheme: inputDecorationTheme,
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: elevatedButtonStyle,
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: outlinedButtonStyle,
          ),
          textButtonTheme: TextButtonThemeData(
            style: textButtonStyle,
          ),
          pageTransitionsTheme: const PageTransitionsTheme(
            builders: {
              TargetPlatform.android: FadeUpwardsPageTransitionsBuilder()
            },
          ),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        navigatorKey: navigatorKey,
        scaffoldMessengerKey: scaffoldMessengerKey,
        navigatorObservers: [routeObserver],
        home: const Wrapper(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case loginRoute:
              return MaterialPageRoute(
                builder: (_) => LoginPage(),
              );
            case registerRoute:
              return MaterialPageRoute(
                builder: (_) => RegisterPage(),
              );
            case forgotPasswordRoute:
              final email = settings.arguments as String?;

              return MaterialPageRoute(
                builder: (_) => ForgotPasswordPage(email: email),
              );
            case additionalInfoRoute:
              final user = settings.arguments as UserEntity;

              return MaterialPageRoute(
                builder: (_) => AdditionalInfoPage(user: user),
                settings: settings,
              );
            case webviewRoute:
              final url = settings.arguments as String;

              return MaterialPageRoute(
                builder: (_) => WebViewPage(url: url),
                settings: settings,
              );
            case mainRoute:
              final user = settings.arguments as UserEntity;

              return MaterialPageRoute(
                builder: (_) => MainPage(user: user),
                settings: settings,
              );

            case nutrientsDetailRoute:
              final uid = settings.arguments as String;

              return MaterialPageRoute(
                builder: (_) => NutrientsDetailPage(uid: uid),
                settings: settings,
              );

            case profileRoute:
              final uid = settings.arguments as String;

              return MaterialPageRoute(
                builder: (_) => ProfilePage(uid: uid),
                settings: settings,
              );
            case updateProfileRoute:
              final userData = settings.arguments as UserDataEntity;

              return MaterialPageRoute(
                builder: (_) => UpdateProfilePage(userData: userData),
                settings: settings,
              );
            case scheduleAlarmRoute:
              final uid = settings.arguments as String;

              return MaterialPageRoute(
                builder: (_) => ScheduleAlarmPage(uid: uid),
                settings: settings,
              );
            case checkRoute:
              final uid = settings.arguments as String;

              return MaterialPageRoute(
                builder: (_) => CheckPage(uid: uid),
                settings: settings,
              );
            case foodCheckRoute:
              final uid = settings.arguments as String;

              return MaterialPageRoute(
                builder: (_) => FoodCheckPage(uid: uid),
                settings: settings,
              );
            case productCheckRoute:
              final uid = settings.arguments as String;

              return MaterialPageRoute(
                builder: (_) => ProductCheckPage(uid: uid),
                settings: settings,
              );
            case recipeCheckRoute:
              final uid = settings.arguments as String;

              return MaterialPageRoute(
                builder: (_) => RecipeCheckPage(uid: uid),
                settings: settings,
              );
            case foodAndProductCheckHistoryRoute:
              final uid = settings.arguments as String;

              return MaterialPageRoute(
                builder: (_) => FoodAndProductCheckHistoryPage(uid: uid),
                settings: settings,
              );
            case recipeDetailRoute:
              final arguments = settings.arguments as RecipeDetailPageArgs;

              return MaterialPageRoute(
                builder: (_) => RecipeDetailPage(
                  recipe: arguments.recipe,
                  heroTag: arguments.heroTag,
                ),
                settings: settings,
              );
            case recipeBookmarksRoute:
              final uid = settings.arguments as String;

              return MaterialPageRoute(
                builder: (_) => RecipeBookmarksPage(uid: uid),
                settings: settings,
              );
            case newsDetailRoute:
              final arguments = settings.arguments as NewsDetailPageArgs;

              return MaterialPageRoute(
                builder: (_) => NewsDetailPage(
                  news: arguments.news,
                  heroTag: arguments.heroTag,
                ),
                settings: settings,
              );
            case newsBookmarksRoute:
              final uid = settings.arguments as String;

              return MaterialPageRoute(
                builder: (_) => NewsBookmarksPage(uid: uid),
                settings: settings,
              );
            case productsRoute:
              final arguments = settings.arguments as ProductListPageArgs;

              return MaterialPageRoute(
                builder: (_) => ProductsPage(
                  uid: arguments.uid,
                  title: arguments.title,
                  productBaseUrl: arguments.productBaseUrl,
                ),
                settings: settings,
              );
            case favoriteProductsRoute:
              final uid = settings.arguments as String;

              return MaterialPageRoute(
                builder: (_) => FavoriteProductsPage(uid: uid),
                settings: settings,
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}
