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
          buildNavBarItem(
            context,
            MdiIcons.homeOutline,
            MdiIcons.home,
            MenuNavBar.home,
            scaffoldBackgroundColor,
          ),
          buildNavBarItem(
            context,
            MdiIcons.timerOutline,
            MdiIcons.timer,
            MenuNavBar.nutriTime,
            scaffoldBackgroundColor,
          ),
          SizedBox(
            height: kBottomNavigationBarHeight + 8,
            width: MediaQuery.of(context).size.width / 5,
          ),
          buildNavBarItem(
            context,
            MdiIcons.newspaperVariantOutline,
            MdiIcons.newspaperVariant,
            MenuNavBar.nutriNews,
            primaryBackgroundColor,
          ),
          buildNavBarItem(
            context,
            MdiIcons.shoppingOutline,
            MdiIcons.shopping,
            MenuNavBar.nutriShop,
            scaffoldBackgroundColor,
          ),
        ],
      ),
    );
  }

  GestureDetector buildNavBarItem(
    BuildContext context,
    IconData unselectedIcon,
    IconData selectedIcon,
    MenuNavBar menu,
    Color backgroundColor,
  ) {
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
