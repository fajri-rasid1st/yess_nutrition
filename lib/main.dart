import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'common/styles/styles.dart';
import 'common/utils/http_ssl_pinning.dart';
import 'common/utils/keys.dart';
import 'common/utils/routes.dart';
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
          create: (_) => di.locator<UserFirestoreNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<UserStorageNotifier>(),
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
          create: (_) => BottomNavigationBarNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => InputPasswordNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => NewsFabNotifier(),
        ),
        ChangeNotifierProvider(
          create: (_) => NewsWebViewNotifier(),
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
            // -------------- Auth and common routes and pages ---------------
            case loginRoute:
              return MaterialPageRoute(
                builder: (_) => const LoginPage(),
              );

            case registerRoute:
              return MaterialPageRoute(
                builder: (_) => const RegisterPage(),
              );

            case forgotPasswordRoute:
              return MaterialPageRoute(
                builder: (_) => const ForgotPasswordPage(),
              );

            case additionalInfoRoute:
              final user = settings.arguments as UserEntity;

              return MaterialPageRoute(
                builder: (_) => AdditionalInfoPage(user: user),
                settings: settings,
              );

            case mainRoute:
              final user = settings.arguments as UserEntity;

              return MaterialPageRoute(
                builder: (_) => MainPage(user: user),
                settings: settings,
              );

            case webviewRoute:
              final url = settings.arguments as String;

              return MaterialPageRoute(
                builder: (_) => WebViewPage(url: url),
                settings: settings,
              );

            // -------------- Profile routes and pages ---------------
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

            // -------------- NutriCheck routes and pages ---------------
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

            // -------------- NutriNews routes and pages ---------------
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

            // -------------- NutriNews routes and pages ---------------
            case productListRoute:
              final arguments = settings.arguments as ProductListPageArgs;

              return MaterialPageRoute(
                builder: (_) => ProductListPage(
                  title: arguments.title,
                  url: arguments.url,
                ),
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
