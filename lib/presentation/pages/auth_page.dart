import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/presentation/pages/additional_info_page.dart';
import 'package:yess_nutrition/presentation/pages/home_page.dart';
import 'package:yess_nutrition/presentation/pages/login_page.dart';
import 'package:yess_nutrition/presentation/providers/user/auth_notifiers/get_user_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userNotifier = Provider.of<GetUserNotifier>(context);

    return StreamBuilder<UserEntity?>(
      stream: userNotifier.user,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final UserEntity? user = snapshot.data;

          if (user == null) {
            return const LoginPage();
          } else {
            if (user.isFirstLogin) return const AdditionalInfoPage();

            return const HomePage();
          }
        } else {
          return const Scaffold(body: LoadingIndicator());
        }
      }),
    );
  }
}
