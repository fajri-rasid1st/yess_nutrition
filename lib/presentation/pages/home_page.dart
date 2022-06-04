import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/presentation/providers/auth_notifiers/sign_out_notifier.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          child: ElevatedButton(
            onPressed: () async {
              await context.read<SignOutNotifier>().signOut();
            },
            child: const Text('Log Out'),
          ),
        ),
      ),
    );
  }
}
