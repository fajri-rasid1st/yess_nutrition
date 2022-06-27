import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/presentation/pages/common_pages/home_page.dart';
import 'package:yess_nutrition/presentation/pages/news_pages/news_page.dart';
import 'package:yess_nutrition/presentation/pages/shop_pages/shop_page.dart';
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
  final List<Widget> _pages = <Widget>[];

  late PageController _pageController;

  @override
  void initState() {
    super.initState();

    _pages.addAll([
      HomePage(user: widget.user),
      const Scaffold(),
      NewsPage(uid: widget.user.uid),
      ShopPage(uid: widget.user.uid),
    ]);

    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();

    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBarNotifier>(
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
