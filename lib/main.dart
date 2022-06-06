import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
<<<<<<< HEAD
=======
import 'package:provider/single_child_widget.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/presentation/pages/additional_info_page.dart';
>>>>>>> 6fb69a623258b7825c8ccda92a0d1e009ffdddcb
import 'package:yess_nutrition/presentation/pages/forgot_password_page.dart';
import 'package:yess_nutrition/presentation/pages/home_page.dart';
import 'package:yess_nutrition/presentation/pages/login_page.dart';
import 'package:yess_nutrition/presentation/pages/auth_page.dart';
import 'package:yess_nutrition/presentation/pages/register_page.dart';
<<<<<<< HEAD
import 'package:yess_nutrition/presentation/providers/bottom_navigation_bar_notifier.dart';
=======
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
>>>>>>> 6fb69a623258b7825c8ccda92a0d1e009ffdddcb
import 'common/styles/color_scheme.dart';
import 'common/styles/text_style.dart';
import 'common/utils/routes.dart';
import 'firebase_options.dart';
<<<<<<< HEAD
import 'package:yess_nutrition/injection.dart' as di;
=======
import 'injection.dart' as di;
>>>>>>> 6fb69a623258b7825c8ccda92a0d1e009ffdddcb

void main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();

  // Prevent landscape orientation
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Change status bar and navigation color
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: primaryBackgroundColor,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  // Initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize service locator
  di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
<<<<<<< HEAD
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<BottomNavigationBarNotifier>(),
=======
      providers: <SingleChildWidget>[
        ChangeNotifierProvider<GetUserNotifier>(
          create: (_) => di.locator<GetUserNotifier>(),
        ),
        ChangeNotifierProvider<SignInNotifier>(
          create: (_) => di.locator<SignInNotifier>(),
        ),
        ChangeNotifierProvider<SignInWithGoogleNotifier>(
          create: (_) => di.locator<SignInWithGoogleNotifier>(),
        ),
        ChangeNotifierProvider<SignUpNotifier>(
          create: (_) => di.locator<SignUpNotifier>(),
        ),
        ChangeNotifierProvider<SignOutNotifier>(
          create: (_) => di.locator<SignOutNotifier>(),
        ),
        ChangeNotifierProvider<ResetPasswordNotifier>(
          create: (_) => di.locator<ResetPasswordNotifier>(),
        ),
        ChangeNotifierProvider<DeleteUserNotifier>(
          create: (_) => di.locator<DeleteUserNotifier>(),
        ),
        ChangeNotifierProvider<CreateUserDataNotifier>(
          create: (_) => di.locator<CreateUserDataNotifier>(),
        ),
        ChangeNotifierProvider<ReadUserDataNotifier>(
          create: (_) => di.locator<ReadUserDataNotifier>(),
        ),
        ChangeNotifierProvider<UpdateUserDataNotifier>(
          create: (_) => di.locator<UpdateUserDataNotifier>(),
        ),
        ChangeNotifierProvider<DeleteUserDataNotifier>(
          create: (_) => di.locator<DeleteUserDataNotifier>(),
>>>>>>> 6fb69a623258b7825c8ccda92a0d1e009ffdddcb
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Yess Nutrition',
        theme: ThemeData(
          fontFamily: 'Plus Jakarta Sans',
          colorScheme: myColorScheme,
          textTheme: myTextTheme,
          dividerColor: dividerColor,
          scaffoldBackgroundColor: scaffoldBackgroundColor,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
<<<<<<< HEAD
        home: const HomePage(),
=======
        home: const AuthPage(),
>>>>>>> 6fb69a623258b7825c8ccda92a0d1e009ffdddcb
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
<<<<<<< HEAD
            case homePageRoute:
              return MaterialPageRoute(
                builder: (_) => const HomePage(),
              );
            default:
              return MaterialPageRoute(
                builder: (_) {
                  return const Scaffold(
                    body: Center(
                      child: Text('Page not found'),
                    ),
                  );
                },
              );
=======
            case additionalInfoRoute:
              final user = settings.arguments as UserEntity;

              return MaterialPageRoute(
                builder: (_) => AdditionalInfoPage(user: user),
                settings: settings,
              );
            case homeRoute:
              final user = settings.arguments as UserEntity;

              return MaterialPageRoute(
                builder: (_) => HomePage(user: user),
                settings: settings,
              );
            default:
              return null;
>>>>>>> 6fb69a623258b7825c8ccda92a0d1e009ffdddcb
          }
        },
      ),
    );
  }
}
