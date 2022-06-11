import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import 'common/styles/styles.dart';
import 'common/utils/http_ssl_pinning.dart';
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
          create: (_) => di.locator<SignInNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SignInWithGoogleNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SignUpNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SignOutNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ResetPasswordNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<DeleteUserNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<CreateUserDataNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<ReadUserDataNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<UpdateUserDataNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<DeleteUserDataNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<BookmarkNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<GetBookmarksNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<GetNewsNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchNewsNotifier>(),
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
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: const Wrapper(),
        onGenerateRoute: (settings) {
          switch (settings.name) {
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
            case profileRoute:
              final userData = settings.arguments as UserDataEntity;

              return MaterialPageRoute(
                builder: (_) => ProfilePage(userData: userData),
                settings: settings,
              );
            case updateProfileRoute:
              return MaterialPageRoute(
                builder: (_) => const UpdateProfilePage(),
              );
            case newsDetailRoute:
              return MaterialPageRoute(
                builder: (_) => const NewsDetailPage(),
              );
            case newsBookmarksRoute:
              return MaterialPageRoute(
                builder: (_) => const NewsBookmarksPage(),
              );
            default:
              return null;
          }
        },
      ),
    );
  }
}
