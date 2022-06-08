import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:yess_nutrition/common/styles/button_style.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/styles/input_style.dart';
import 'package:yess_nutrition/common/styles/text_style.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/firebase_options.dart';
import 'package:yess_nutrition/presentation/pages/additional_info_page.dart';
import 'package:yess_nutrition/presentation/pages/forgot_password_page.dart';
import 'package:yess_nutrition/presentation/pages/home_page.dart';
import 'package:yess_nutrition/presentation/pages/login_page.dart';
import 'package:yess_nutrition/presentation/pages/auth_page.dart';
import 'package:yess_nutrition/presentation/pages/register_page.dart';
import 'package:yess_nutrition/presentation/providers/input_password_notifier.dart';
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
import 'injection.dart' as di;

void main() async {
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
        ),
        ChangeNotifierProvider<InputPasswordNotifier>(
          create: (_) => InputPasswordNotifier(),
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
        home: const AuthPage(),
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
            case homeRoute:
              final user = settings.arguments as UserEntity;

              return MaterialPageRoute(
                builder: (_) => HomePage(user: user),
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
