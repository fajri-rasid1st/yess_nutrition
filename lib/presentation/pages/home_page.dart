import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/utils/keys.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/presentation/providers/user/auth_notifiers/sign_out_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: ElevatedButton(
            onPressed: () async {
              await context.read<SignOutNotifier>().signOut();

              navigatorKey.currentState!.pushReplacementNamed(loginRoute);
            },
            child: const Text('Log Out'),
          ),
        ),
      ),
    );
  }
}
