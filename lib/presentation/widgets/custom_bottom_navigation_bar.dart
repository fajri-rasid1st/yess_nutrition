import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/presentation/providers/common_notifiers/bottom_navigation_bar_notifier.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final BottomNavigationBarNotifier notifier;

  const CustomBottomNavigationBar({
    Key? key,
    required this.notifier,
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
            selectedIcon: MdiIcons.home,
            unselectedIcon: MdiIcons.homeOutline,
            menu: MenuNavBar.home,
            backgroundColor: scaffoldBackgroundColor,
          ),
          _buildNavBarItem(
            context,
            selectedIcon: MdiIcons.timer,
            unselectedIcon: MdiIcons.timerOutline,
            menu: MenuNavBar.nutriTime,
            backgroundColor: scaffoldBackgroundColor,
          ),
          SizedBox(
            height: kBottomNavigationBarHeight + 8,
            width: MediaQuery.of(context).size.width / 5,
          ),
          _buildNavBarItem(
            context,
            selectedIcon: MdiIcons.newspaperVariant,
            unselectedIcon: MdiIcons.newspaperVariantOutline,
            menu: MenuNavBar.nutriNews,
            backgroundColor: primaryBackgroundColor,
          ),
          _buildNavBarItem(
            context,
            selectedIcon: MdiIcons.shopping,
            unselectedIcon: MdiIcons.shoppingOutline,
            menu: MenuNavBar.nutriShop,
            backgroundColor: scaffoldBackgroundColor,
          ),
        ],
      ),
    );
  }

  GestureDetector _buildNavBarItem(
    BuildContext context, {
    required IconData selectedIcon,
    required IconData unselectedIcon,
    required MenuNavBar menu,
    required Color backgroundColor,
  }) {
    return GestureDetector(
      onTap: () {
        notifier.selectedMenu = menu;
        notifier.backgroundColor = backgroundColor;
      },
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 5,
        height: kBottomNavigationBarHeight + 8,
        child: Icon(
          menu == notifier.selectedMenu ? selectedIcon : unselectedIcon,
          color: menu == notifier.selectedMenu ? primaryColor : secondaryColor,
          size: 28,
        ),
      ),
    );
  }
}
