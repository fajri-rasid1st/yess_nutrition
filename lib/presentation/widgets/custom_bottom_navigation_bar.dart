import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/presentation/providers/bottom_navigation_bar_notifier.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final BottomNavigationBarNotifier notifier;
  final VoidCallback onTapCircleButton;

  const CustomBottomNavigationBar({
    Key? key,
    required this.onTapCircleButton,
    required this.notifier,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[
        Container(
          height: kBottomNavigationBarHeight + 8,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: primaryBackgroundColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: secondaryColor.withOpacity(0.5),
                offset: const Offset(0.0, -4.0),
                blurRadius: 20,
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
              ),
              buildNavBarItem(
                context,
                MdiIcons.timerOutline,
                MdiIcons.timer,
                MenuNavBar.nutriTime,
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
              ),
              buildNavBarItem(
                context,
                MdiIcons.shoppingOutline,
                MdiIcons.shopping,
                MenuNavBar.nutriShop,
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: onTapCircleButton,
          child: Container(
            height: 68,
            width: 68,
            margin: const EdgeInsets.only(bottom: 20),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(200)),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: <Color>[
                  Color(0XFF8B80F8),
                  Color(0XFF5C51C6),
                ],
              ),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: secondaryColor,
                  offset: Offset(0.0, 8.0),
                  blurRadius: 10,
                )
              ],
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 4, left: 4),
                child: SvgPicture.asset(
                  'assets/svg/nutri_check.svg',
                  width: 28,
                  height: 28,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  GestureDetector buildNavBarItem(
    BuildContext context,
    IconData icon,
    IconData iconActive,
    MenuNavBar menu,
  ) {
    return GestureDetector(
      onTap: () => notifier.selectedMenu = menu,
      child: SizedBox(
        width: MediaQuery.of(context).size.width / 5,
        height: kBottomNavigationBarHeight + 8,
        child: Icon(
          menu == notifier.selectedMenu ? iconActive : icon,
          color: menu == notifier.selectedMenu ? primaryColor : secondaryColor,
          size: 28,
        ),
      ),
    );
  }
}
