import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/presentation/pages/home_page.dart';
import 'package:yess_nutrition/presentation/pages/news_pages/news_page.dart';
import 'package:yess_nutrition/presentation/pages/schedule_pages/nutri_time_page.dart';
import 'package:yess_nutrition/presentation/providers/common_notifiers/bottom_navigation_bar_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:yess_nutrition/presentation/widgets/custom_floating_action_button.dart';

class MainPage extends StatelessWidget {
  final UserEntity user;

  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBarNotifier>(
      builder: (context, navBar, child) {
        return Scaffold(
          body: Builder(
            builder: (context) {
              switch (navBar.selectedMenu) {
                case MenuNavBar.home:
                  return HomePage(user: user);
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
          backgroundColor: navBar.backgroundColor,
          bottomNavigationBar: CustomBottomNavigationBar(notifier: navBar),
          floatingActionButton: CustomFloatingActionButton(onPressed: () {}),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
