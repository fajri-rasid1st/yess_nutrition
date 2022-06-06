import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/presentation/providers/bottom_navigation_bar_notifier.dart';

class CustomButtonNavigationBar extends StatefulWidget {
  const CustomButtonNavigationBar({Key? key}) : super(key: key);

  @override
  State<CustomButtonNavigationBar> createState() =>
      _CustomButtonNavigationBarState();
}

class _CustomButtonNavigationBarState extends State<CustomButtonNavigationBar> {
  late MenuNavBar _selectedMenu;

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNavigationBarNotifier>(
        builder: (context, result, child) {
      _selectedMenu = result.selectedMenu;
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Container(
            height: 66,
            width: MediaQuery.of(context).size.width,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                color: primaryBackgroundColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: secondaryColor.withOpacity(0.4),
                    offset: const Offset(0.0, -4.0),
                    blurRadius: 20,
                  )
                ]),
            child: Row(
              children: <Widget>[
                buildNavBarItem(
                  MdiIcons.homeOutline,
                  MdiIcons.home,
                  MenuNavBar.Home,
                ),
                buildNavBarItem(
                  MdiIcons.timerOutline,
                  MdiIcons.timer,
                  MenuNavBar.NutriTime,
                ),
                SizedBox(
                  height: 66,
                  width: MediaQuery.of(context).size.width / 5,
                ),
                buildNavBarItem(
                  MdiIcons.newspaperVariantOutline,
                  MdiIcons.newspaperVariant,
                  MenuNavBar.NutriNews,
                ),
                buildNavBarItem(
                  MdiIcons.shoppingOutline,
                  MdiIcons.shopping,
                  MenuNavBar.NutriShop,
                ),
              ],
            ),
          ),
          Container(
            height: 76,
            width: 76,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(200)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0XFF8B80F8),
                  Color(0XFF5C51C6),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: secondaryColor,
                  offset: Offset(0.0, 8.0),
                  blurRadius: 10,
                )
              ],
            ),
            padding: const EdgeInsets.only(
              left: 22,
              right: 19,
              top: 5,
            ),
            child: SvgPicture.asset(
              'assets/svg/nutri_check.svg',
              fit: BoxFit.fitWidth,
            ),
          ),
        ],
      );
    });
  }

  Widget buildNavBarItem(
    IconData icon,
    IconData iconActivated,
    MenuNavBar menu,
  ) {
    return InkWell(
      onTap: () {
        Provider.of<BottomNavigationBarNotifier>(context, listen: false)
            .changeMenu(menu);
      },
      child: SizedBox(
        height: 66,
        width: MediaQuery.of(context).size.width / 5,
        child: Icon(
          menu == _selectedMenu ? iconActivated : icon,
          size: 30,
          color: menu == _selectedMenu ? primaryColor : secondaryColor,
        ),
      ),
    );
  }
}
