import 'dart:async';
import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/presentation/providers/user/auth_notifiers/sign_out_notifier.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with AfterLayoutMixin<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await context.read<SignOutNotifier>().signOut();

            if (!mounted) return;

            Navigator.popUntil(context, (route) => route.isFirst);
          },
          child: const Text('Log Out'),
        ),
      ),
    );
  }

  @override
  FutureOr<void> afterFirstLayout(BuildContext context) {
    return checkFirstSeen(context);
  }

  Future<void> checkFirstSeen(BuildContext context) async {
    // final userDataNotifier = context.read<ReadUserDataNotifier>();
    // final userStream = userDataNotifier.user;
    // final user = await userStream.first;

    // if (!mounted) return;

    // if (user.isFirstLogin) {
    //   Navigator.pushReplacementNamed(context, additionalInfoRoute);
    // }
  }
}
