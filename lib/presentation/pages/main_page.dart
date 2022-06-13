import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/presentation/pages/home_page.dart';
import 'package:yess_nutrition/presentation/pages/news_pages/news_page.dart';
import 'package:yess_nutrition/presentation/pages/schedule_pages/nutri_time_page.dart';
import 'package:yess_nutrition/presentation/providers/common_notifiers/bottom_navigation_bar_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/firestore_notifiers/read_user_data_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:yess_nutrition/presentation/widgets/custom_floating_action_button.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class MainPage extends StatefulWidget {
  final UserEntity user;

  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    Future.microtask(() {
      Provider.of<ReadUserDataNotifier>(context, listen: false)
          .readUserData(widget.user.uid);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<BottomNavigationBarNotifier, ReadUserDataNotifier>(
      builder: (context, navbar, user, child) {
        if (user.state == UserState.success) {
          return Scaffold(
            backgroundColor: navbar.backgroundColor,
            body: Builder(
              builder: (context) {
                switch (navbar.selectedMenu) {
                  case MenuNavBar.home:
                    return HomePage(userData: user.userData);
                  case MenuNavBar.nutriTime:
                    return const NutriTimePage();
                  case MenuNavBar.nutriNews:
                    return const NewsPage();
                  case MenuNavBar.nutriShop:
                    return const Scaffold(
                      body: Center(child: Text('NutriShop Page')),
                    );
                }
              },
            ),
            bottomNavigationBar: CustomBottomNavigationBar(
              notifier: navbar,
            ),
            floatingActionButton: CustomFloatingActionButton(
              onPressed: () {},
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
          );
        }

        return const Scaffold(body: LoadingIndicator());
      },
    );
  }
}
