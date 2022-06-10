import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/presentation/pages/news_pages/news_page.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/auth_notifiers/sign_out_notifier.dart';

class HomePage extends StatefulWidget {
  final UserEntity user;

  const HomePage({Key? key, required this.user}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () async {
                  await context.read<SignOutNotifier>().signOut();

                  if (!mounted) return;

                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    loginRoute,
                    ((route) => false),
                  );
                },
                child: const Text('Log Out'),
              ),
              OutlinedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const NewsPage()),
                  );
                },
                child: const Text('News Page'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
