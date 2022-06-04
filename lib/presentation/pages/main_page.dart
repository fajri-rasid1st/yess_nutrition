import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/presentation/pages/home_page.dart';
import 'package:yess_nutrition/presentation/pages/login_page.dart';
import 'package:yess_nutrition/presentation/providers/auth_notifiers/user_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class MainPage extends StatelessWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<UserNotifier>(context);

    return StreamBuilder<UserEntity?>(
      stream: userNotifier.user,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final UserEntity? user = snapshot.data;

          return user == null ? const LoginPage() : const HomePage();
        } else {
          return const Scaffold(body: LoadingIndicator());
        }
      }),
    );
  }
}
