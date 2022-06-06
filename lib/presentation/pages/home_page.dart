import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/state_enum.dart';
import 'package:yess_nutrition/presentation/providers/bottom_navigation_bar_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/card_nutri_news_home.dart';
import 'package:yess_nutrition/presentation/widgets/card_nutri_shop_home.dart';
import 'package:yess_nutrition/presentation/widgets/card_nutri_time_task.dart';
import 'package:yess_nutrition/presentation/widgets/custom_button_navigation_bar.dart';
import 'package:yess_nutrition/presentation/widgets/large_circular_progress.dart';
import 'package:yess_nutrition/presentation/widgets/small_circular_progress.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}
=======
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/domain/entities/user_entity.dart';
import 'package:yess_nutrition/presentation/providers/user/auth_notifiers/sign_out_notifier.dart';

class HomePage extends StatefulWidget {
  final UserEntity user;

  const HomePage({Key? key, required this.user}) : super(key: key);
>>>>>>> 6fb69a623258b7825c8ccda92a0d1e009ffdddcb

class _HomePageState extends State<HomePage> {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
<<<<<<< HEAD
      body: Stack(
        children: [
          Consumer<BottomNavigationBarNotifier>(
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
          const Positioned(
            bottom: 0,
            child: CustomButtonNavigationBar(),
          ),
        ],
      ),
    );
  }
}

class BodyHomePage extends StatelessWidget {
  const BodyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: <Widget>[
        _buildHeaderHomePage(context),
        _buildContentHomePage(context)
      ],
    );
  }

  Widget _buildHeaderHomePage(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topStart,
      clipBehavior: Clip.none,
      children: <Widget>[
        SvgPicture.asset(
          'assets/svg/header_background.svg',
          alignment: Alignment.topCenter,
          fit: BoxFit.fitWidth,
          width: double.infinity,
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
                  onTap: () {
                    const snackBar = SnackBar(
                      content: Text('Yay! A SnackBar!'),
                    );

                    // Find the ScaffoldMessenger in the widget tree
                    // and use it to show a SnackBar.
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
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
    );
  }

  Widget _buildContentHomePage(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 130),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        color: scaffoldBackgroundColor,
      ),
      clipBehavior: Clip.hardEdge,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 24,
            ),
            _buildCardRingkasan(context),
            const SizedBox(
              height: 20,
            ),
            _buildCardNutriTime(context),
            const SizedBox(
              height: 20,
            ),
            _buildTitleContent(context, "NutriNews"),
            const SizedBox(
              height: 8,
            ),
            _buildListNutriNews(),
            const SizedBox(
              height: 20,
            ),
            _buildTitleContent(context, "NutriShop"),
            const SizedBox(
              height: 8,
            ),
            _buildListNutriShop(),
            const SizedBox(
              height: 120,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardNutriTime(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: primaryBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(0.0, 0.0),
            color: const Color(0XFF000000).withOpacity(0.05),
            blurRadius: 20,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 18.0, left: 18.0, right: 18.0, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              "NutriTime",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 4,
            ),
            Text(
              "4 dari 8",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: secondaryTextColor),
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              width: double.infinity,
              child: LinearPercentIndicator(
                lineHeight: 8,
                percent: 4 / 8,
                animation: true,
                animationDuration: 1000,
                progressColor: primaryColor,
                backgroundColor: secondaryColor,
                barRadius: const Radius.circular(10),
                padding: EdgeInsets.zero,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            ListView.separated(
              primary: false,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const CardNutriTimeTask();
              },
              itemCount: 2,
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 6,
                  ),
                  child: Divider(
                    color: dividerColor.withOpacity(0.6),
                  ),
                );
              },
            ),
            const SizedBox(
              height: 16,
            ),
            Divider(
              color: dividerColor.withOpacity(0.6),
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Lihat Detail",
                  style: Theme.of(context).textTheme.button?.copyWith(
                        color: primaryColor,
                        letterSpacing: 0.5,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardRingkasan(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: primaryBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(0.0, 0.0),
            color: const Color(0XFF000000).withOpacity(0.05),
            blurRadius: 20,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
            top: 18.0, left: 18.0, right: 18.0, bottom: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Ringkasan Nutrisi Harian",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const <Widget>[
                LargeCircularProgress(
                  backgroundColor: secondaryColor,
                  descriptionProgress: "Kalori",
                  progressColor: secondaryBackgroundColor,
                  progress: 0.25,
                ),
                SizedBox(
                  width: 24,
                ),
                LargeCircularProgress(
                  backgroundColor: secondaryColor,
                  descriptionProgress: "Air",
                  progressColor: secondaryBackgroundColor,
                  progress: 1,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SmallCircularProgress(
                  backgroundColor: const Color(0XFF5ECFF2).withOpacity(0.2),
                  descriptionProgress: "Protein",
                  progressColor: const Color(0XFF5ECFF2),
                  progress: 0.5,
                ),
                const SizedBox(
                  width: 24,
                ),
                SmallCircularProgress(
                  backgroundColor: const Color(0XFFEF5EF2).withOpacity(0.2),
                  descriptionProgress: "Protein",
                  progressColor: const Color(0XFFEF5EF2),
                  progress: 0.75,
                ),
                const SizedBox(
                  width: 24,
                ),
                SmallCircularProgress(
                  backgroundColor: const Color(0XFFFB958B).withOpacity(0.2),
                  descriptionProgress: "Lemak",
                  progressColor: errorColor,
                  progress: 0.8,
                ),
              ],
            ),
            const SizedBox(
              height: 16,
            ),
            Divider(
              color: dividerColor.withOpacity(0.6),
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  "Lihat Detail",
                  style: Theme.of(context).textTheme.button?.copyWith(
                        color: primaryColor,
                        letterSpacing: 0.5,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTitleContent(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .subtitle1
                ?.copyWith(fontWeight: FontWeight.w800),
          ),
          const Spacer(),
          InkWell(
            onTap: () {},
            child: Row(
              children: [
                Text(
                  "Selengkapnya",
                  style: Theme.of(context).textTheme.overline?.copyWith(
                        color: primaryColor,
                        letterSpacing: 0.25,
                        fontSize: 12,
                      ),
                ),
                const Icon(
                  MdiIcons.chevronRight,
                  size: 20,
                  color: primaryColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListNutriNews() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return const CardNutriNewsHome(
            picture:
                'https://s3.theasianparent.com/cdn-cgi/image/height=250/tap-assets-prod/wp-content/uploads/sites/6/2013/03/healthy-foods.jpg',
            title:
                'Tak Perlu Minum Obat, Cukup Konsumsi 5 Makanan Penghilang Bau Mulut',
            time: '2 jam lalu',
            show: '1080 dilihat',
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 8,
          );
        },
        itemCount: 3,
      ),
    );
  }

  Widget _buildListNutriShop() {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const CardNutriShopHome(
            picture:
                'https://images.pexels.com/photos/3766180/pexels-photo-3766180.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500',
            category: 'Minuman',
            title: 'Air Jeruk',
            price: 30000,
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            width: 8,
          );
        },
        itemCount: 5,
=======
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            await context.read<SignOutNotifier>().signOut();

            if (!mounted) return;

            Navigator.pushNamedAndRemoveUntil(
              context,
              loginRoute,
              ((route) => false),
            );
          },
          child: const Text('Log Out'),
        ),
>>>>>>> 6fb69a623258b7825c8ccda92a0d1e009ffdddcb
      ),
    );
  }
}
