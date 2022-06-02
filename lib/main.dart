import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/styles/text_style.dart';
import 'package:yess_nutrition/presentation/pages/home_page.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Untuk mencegah orientasi landskap
  SystemChrome.setPreferredOrientations(<DeviceOrientation>[
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Mengganti warna status bar dan navigasi
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.transparent,
  ));

  // Initialize firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      home: const HomePage(title: 'Yess Nutrition App'),
    );
  }
}
