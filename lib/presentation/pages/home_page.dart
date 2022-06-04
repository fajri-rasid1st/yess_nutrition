import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/state_enum.dart';
import 'package:yess_nutrition/presentation/providers/bottom_navigation_bar_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_button_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: const CustomButtonNavigationBar(),
      body: Consumer<BottomNavigationBarNotifier>(
          builder: (context, result, child) {
        if (result.selectedMenu == MenuNavBar.Home) {
          return const BodyHomePage();
        } else if (result.selectedMenu == MenuNavBar.NutriTime) {
          return const Center(
            child: Text("Ini Halaman NutriTime"),
          );
        } else if (result.selectedMenu == MenuNavBar.NutriNews) {
          return const Center(
            child: Text("Ini Halaman NutriNews"),
          );
        } else if (result.selectedMenu == MenuNavBar.NutriShop) {
          return const Center(
            child: Text("Ini Halaman NutriShop"),
          );
        } else {
          return const Center(
            child: Text("Halaman tidak ditemukan"),
          );
        }
      }),
    );
  }
}

class BodyHomePage extends StatelessWidget {
  const BodyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Stack(
          alignment: AlignmentDirectional.topStart,
          clipBehavior: Clip.none,
          children: <Widget>[
            SvgPicture.asset(
              'assets/svg/header_background.svg',
              alignment: Alignment.topCenter,
              fit: BoxFit.fitWidth,
              width: MediaQuery.of(context).size.width,
            ),
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 36,
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Container(
                          width: 50,
                          height: 50,
                          margin: const EdgeInsets.only(right: 12),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(8),
                            ),
                          ),
                          clipBehavior: Clip.hardEdge,
                          child: Image.asset(
                            'assets/img/test_avatar.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Text(
                              "Hai, Brandon!",
                              style: TextStyle(
                                color: primaryBackgroundColor,
                                fontSize: 20,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              "Selamat Datang",
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  ?.copyWith(color: primaryBackgroundColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        width: 44,
                        height: 44,
                        decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: const Icon(
                          Icons.settings_outlined,
                          color: primaryBackgroundColor,
                          size: 22,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        Positioned(
          top: 140,
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
              color: scaffoldBackgroundColor,
            ),
          ),
        )
      ],
    );
  }
}
