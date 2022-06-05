import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/utils/state_enum.dart';
import 'package:yess_nutrition/presentation/providers/bottom_navigation_bar_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_button_navigation_bar.dart';

import 'nutri_time_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late MenuNavBar _selectedPage;

  @override
  Widget build(BuildContext context) {
    _selectedPage =
        Provider.of<BottomNavigationBarNotifier>(context, listen: false)
            .selectedMenu;
    return Scaffold(
      bottomNavigationBar: CustomButtonNavigationBar(),
      body: Consumer<BottomNavigationBarNotifier>(
          builder: (context, result, child) {
        if (result.selectedMenu == MenuNavBar.Home) {
          return const Center(
            child: Text("Ini Halaman Home"),
          );
        } else if (result.selectedMenu == MenuNavBar.NutriTime) {
          return NutriTimePage();
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
