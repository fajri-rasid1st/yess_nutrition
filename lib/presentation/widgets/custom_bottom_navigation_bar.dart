import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/presentation/providers/common_notifiers/bottom_navigation_bar_notifier.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final BottomNavigationBarNotifier notifier;
  final PageController pageController;

  const CustomBottomNavigationBar({
    Key? key,
    required this.notifier,
    required this.pageController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kBottomNavigationBarHeight + 8,
      decoration: BoxDecoration(
        color: primaryBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: secondaryColor.withOpacity(0.6),
            offset: const Offset(0.0, -4.0),
            blurRadius: 24,
          )
        ],
      ),
      child: Row(
        children: <Widget>[
          _buildNavBarItem(
            context,
            index: 0,
            selectedIcon: MdiIcons.home,
            unselectedIcon: MdiIcons.homeOutline,
            backgroundColor: scaffoldBackgroundColor,
          ),
          _buildNavBarItem(
            context,
            index: 1,
            selectedIcon: MdiIcons.timer,
            unselectedIcon: MdiIcons.timerOutline,
            backgroundColor: primaryBackgroundColor,
          ),
          SizedBox(
            height: kBottomNavigationBarHeight + 8,
            width: MediaQuery.of(context).size.width / 5,
          ),
          _buildNavBarItem(
            context,
            index: 2,
            selectedIcon: MdiIcons.newspaperVariant,
            unselectedIcon: MdiIcons.newspaperVariantOutline,
            backgroundColor: primaryBackgroundColor,
          ),
          _buildNavBarItem(
            context,
            index: 3,
            selectedIcon: MdiIcons.shopping,
            unselectedIcon: MdiIcons.shoppingOutline,
            backgroundColor: scaffoldBackgroundColor,
          ),
        ],
      ),
    );
  }

  GestureDetector _buildNavBarItem(
    BuildContext context, {
    required int index,
    required IconData selectedIcon,
    required IconData unselectedIcon,
    required Color backgroundColor,
  }) {
    final isSelected = index == notifier.selectedIndex;

    return GestureDetector(
      onTap: () {
        notifier.backgroundColor = backgroundColor;
        pageController.jumpToPage(index);
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 5,
        height: kBottomNavigationBarHeight + 8,
        child: Icon(
          isSelected ? selectedIcon : unselectedIcon,
          color: isSelected ? primaryColor : secondaryColor,
          size: 28,
        ),
      ),
    );
  }
}
