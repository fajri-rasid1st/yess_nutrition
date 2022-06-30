import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/data/datasources/helpers/notification_helper.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/presentation/pages/common_pages/home_page.dart';
import 'package:yess_nutrition/presentation/pages/news_pages/news_page.dart';
import 'package:yess_nutrition/presentation/pages/schedule_pages/schedule_page.dart';
import 'package:yess_nutrition/presentation/pages/shop_pages/shop_page.dart';
import 'package:yess_nutrition/presentation/providers/common_notifiers/bottom_navbar_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_bottom_navigation_bar.dart';
import 'package:yess_nutrition/presentation/widgets/custom_floating_action_button.dart';

class MainPage extends StatefulWidget {
  final UserEntity user;

  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final List<Widget> _pages = <Widget>[];

  late final NotificationHelper _notificationHelper;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pages.addAll([
      HomePage(uid: widget.user.uid),
      SchedulePage(uid: widget.user.uid),
      NewsPage(uid: widget.user.uid),
      ShopPage(uid: widget.user.uid),
    ]);

    _notificationHelper = NotificationHelper();
    _notificationHelper.configureSelectNotificationSubject(context);

    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavbarNotifier>(
      builder: (context, navbar, child) {
        return Scaffold(
          body: PageView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _pageController,
            children: _pages,
            onPageChanged: (index) => navbar.selectedIndex = index,
          ),
          backgroundColor: navbar.backgroundColor,
          bottomNavigationBar: CustomBottomNavigationBar(
            notifier: navbar,
            pageController: _pageController,
          ),
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
