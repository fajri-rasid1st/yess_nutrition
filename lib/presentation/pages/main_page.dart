import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/presentation/pages/home_page.dart';
import 'package:yess_nutrition/presentation/pages/news_pages/news_page.dart';
import 'package:yess_nutrition/presentation/pages/schedule_pages/nutri_time_page.dart';
import 'package:yess_nutrition/presentation/providers/common_notifiers/bottom_navigation_bar_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:yess_nutrition/presentation/widgets/custom_floating_action_button.dart';

class MainPage extends StatefulWidget {
  final UserEntity user;

  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final _pages = <Widget>[];

  @override
  void initState() {
    _pages.addAll([
      HomePage(user: widget.user),
      const NutriTimePage(),
      NewsPage(uid: widget.user.uid),
      const Scaffold(body: Center(child: Text('NutriShop Page')))
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBarNotifier>(
      builder: (context, navbar, child) {
        return Scaffold(
          body: IndexedStack(
            index: navbar.selectedIndex,
            children: <Widget>[..._pages],
          ),
          backgroundColor: navbar.backgroundColor,
          bottomNavigationBar: CustomBottomNavigationBar(notifier: navbar),
          floatingActionButton: CustomFloatingActionButton(
            onPressed: () => Navigator.pushNamed(
              context,
              checkRoute,
              arguments: widget.user.uid,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        );
      },
    );
  }
}
