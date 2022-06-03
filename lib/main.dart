import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/presentation/pages/forgot_password_page.dart';
import 'package:yess_nutrition/presentation/pages/home_page.dart';
import 'package:yess_nutrition/presentation/pages/login_page.dart';
import 'package:yess_nutrition/presentation/pages/register_page.dart';
import 'package:yess_nutrition/presentation/providers/bottom_navigation_bar_notifier.dart';
import 'common/styles/color_scheme.dart';
import 'common/styles/text_style.dart';
import 'common/utils/routes.dart';
import 'firebase_options.dart';
import 'package:yess_nutrition/injection.dart' as di;

void main() async {
  di.init();
  WidgetsFlutterBinding.ensureInitialized();

  // Untuk mencegah orientasi landscape
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Mengganti warna status bar dan navigasi
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: primaryBackgroundColor,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));

  // Inisialisasi firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<BottomNavigationBarNotifier>(),
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
        home: const HomePage(),
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
          }
        },
      ),
    );
  }
}
