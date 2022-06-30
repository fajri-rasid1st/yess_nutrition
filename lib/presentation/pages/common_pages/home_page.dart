import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/presentation/providers/common_notifiers/home_page_notifier.dart';
import 'package:yess_nutrition/presentation/providers/product_notifiers/products_notifier.dart';
import 'package:yess_nutrition/presentation/providers/common_notifiers/bottom_navbar_notifier.dart';
import 'package:yess_nutrition/presentation/providers/news_notifiers/get_news_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/user_firestore_notifiers/user_data_notifier.dart';
import 'package:yess_nutrition/presentation/providers/user_notifiers/user_firestore_notifiers/user_nutrients_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/card_nutri_news_home.dart';
import 'package:yess_nutrition/presentation/widgets/card_nutri_shop_home.dart';
import 'package:yess_nutrition/presentation/widgets/card_nutri_time_task.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';
import 'package:yess_nutrition/presentation/widgets/small_circular_progress.dart';

class HomePage extends StatefulWidget {
  final String uid;
  final PageController pageController;

  const HomePage({
    Key? key,
    required this.uid,
    required this.pageController,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<UserDataNotifier>(context, listen: false)
          .readUserData(widget.uid);

      Provider.of<UserNutrientsNotifier>(context, listen: false)
          .readUserNutrients(widget.uid);

      Provider.of<HomePageNotifier>(context, listen: false)
          .getAllContentHomePage();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _buildHeaderHomePage(context),
          _buildContentHomePage(context),
        ],
      ),
    );
  }

  Consumer<UserDataNotifier> _buildHeaderHomePage(BuildContext context) {
    return Consumer<UserDataNotifier>(
      builder: (context, userDataNotifier, child) {
        if (userDataNotifier.state == UserState.success) {
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
                    vertical: 32,
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Row(
                          children: <Widget>[
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
                              child: userDataNotifier.userData.imgUrl.isEmpty
                                  ? Image.asset(
                                      'assets/img/default_user_pict.png',
                                      fit: BoxFit.cover,
                                    )
                                  : Image.network(
                                      userDataNotifier.userData.imgUrl,
                                      fit: BoxFit.cover,
                                    ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  Text(
                                    'Hai, ${userDataNotifier.userData.name}',
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      color: primaryBackgroundColor,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Selamat Datang",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        ?.copyWith(
                                            color: primaryBackgroundColor),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              profileRoute,
                              arguments: widget.uid,
                            );
                          },
                          icon: const Icon(
                            Icons.settings_outlined,
                            color: primaryBackgroundColor,
                            size: 28,
                          ),
                          tooltip: 'Pengaturan',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }

        return const LoadingIndicator();
      },
    );
  }

  double getNutrientValue(int? currentValue, int? maxValue) {
    if (currentValue == null || maxValue == null) return 0;

    return currentValue / maxValue;
  }

  Container _buildContentHomePage(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 132),
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        color: scaffoldBackgroundColor,
      ),
      clipBehavior: Clip.hardEdge,
      child: RefreshIndicator(
        onRefresh: () {
          return Future.microtask(() {
            context.read<HomePageNotifier>().refresh();
            context.read<UserNutrientsNotifier>().refresh(widget.uid);
          });
        },
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              const SizedBox(height: 24),
              _buildCardSummary(context),
              const SizedBox(height: 20),
              _buildCardNutriTime(context),
              const SizedBox(height: 20),
              _buildTitleContent(
                context,
                "NutriNews",
                () => widget.pageController.jumpToPage(2),
              ),
              const SizedBox(height: 8),
              _buildListNutriNews(),
              const SizedBox(height: 20),
              _buildTitleContent(
                context,
                "NutriShop",
                () => widget.pageController.jumpToPage(3),
              ),
              const SizedBox(height: 8),
              _buildListNutriShop(),
              const SizedBox(height: 60),
            ],
          ),
        ),
      ),
    );
  }

  Container _buildCardNutriTime(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: primaryBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(0.0, 0.0),
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 18.0,
          left: 18.0,
          right: 18.0,
          bottom: 10.0,
        ),
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
            const SizedBox(height: 4),
            Text(
              "4 dari 8",
              style: Theme.of(context)
                  .textTheme
                  .caption
                  ?.copyWith(color: secondaryTextColor),
            ),
            const SizedBox(height: 8),
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
            const SizedBox(height: 16),
            ListView.separated(
              primary: false,
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return const CardNutriTimeTask();
              },
              separatorBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6),
                  child: Divider(),
                );
              },
              itemCount: 2,
            ),
            const SizedBox(height: 16),
            const Divider(),
            Center(
              child: TextButton(
                onPressed: () {},
                child: const Text('Lihat Detail'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _buildCardSummary(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: primaryBackgroundColor,
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        boxShadow: <BoxShadow>[
          BoxShadow(
            offset: const Offset(0.0, 0.0),
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 18.0,
          left: 18.0,
          right: 18.0,
          bottom: 10.0,
        ),
        child: Consumer<UserNutrientsNotifier>(
          builder: (context, result, child) {
            if (result.state == UserState.success) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Ringkasan Nutrisi Harian",
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1
                        ?.copyWith(fontWeight: FontWeight.w800),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SmallCircularProgress(
                        backgroundColor: secondaryColor,
                        descriptionProgress: "Kalori",
                        progressColor: secondaryBackgroundColor,
                        progress: getNutrientValue(
                          result.userNutrients?.currentCalories,
                          result.userNutrients?.maxCalories,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SmallCircularProgress(
                        backgroundColor:
                            const Color(0XFF5ECFF2).withOpacity(0.2),
                        descriptionProgress: "Karbo",
                        progressColor: const Color(0XFF5ECFF2),
                        progress: getNutrientValue(
                          result.userNutrients?.currentCarbohydrate,
                          result.userNutrients?.maxCarbohydrate,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SmallCircularProgress(
                        backgroundColor:
                            const Color(0XFFEF5EF2).withOpacity(0.2),
                        descriptionProgress: "Protein",
                        progressColor: const Color(0XFFEF5EF2),
                        progress: getNutrientValue(
                          result.userNutrients?.currentProtein,
                          result.userNutrients?.maxProtein,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SmallCircularProgress(
                        backgroundColor:
                            const Color(0XFFFB958B).withOpacity(0.2),
                        descriptionProgress: "Lemak",
                        progressColor: errorColor,
                        progress: getNutrientValue(
                          result.userNutrients?.currentFat,
                          result.userNutrients?.maxFat,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: TextButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        nutrientsDetailRoute,
                        arguments: widget.uid,
                      ),
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
              );
            }

            return Container(
              color: primaryBackgroundColor,
              child: const LoadingIndicator(),
            );
          },
        ),
      ),
    );
  }

  Padding _buildTitleContent(
    BuildContext context,
    String title,
    VoidCallback onTap,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.bold),
          ),
          const Spacer(),
          InkWell(
            onTap: onTap,
            child: Row(
              children: <Widget>[
                Text(
                  "Selengkapnya",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: primaryColor,
                        letterSpacing: 0.25,
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

  Padding _buildListNutriNews() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Consumer<HomePageNotifier>(
        builder: (context, result, child) {
          if (result.state == RequestState.success) {
            return ListView.separated(
              primary: false,
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                final news = result.news[index];

                return CardNutriNewsHome(
                  news: news.copyWith(uid: widget.uid),
                  heroTag: 'home:${news.url}',
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(height: 10);
              },
              itemCount: result.news.length,
            );
          }

          return const LoadingIndicator();
        },
      ),
    );
  }

  SizedBox _buildListNutriShop() {
    return SizedBox(
      height: 200,
      child: Consumer<HomePageNotifier>(
        builder: (context, result, child) {
          if (result.state == RequestState.success) {
            final productsMap = result.products;
            return ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final products = productsMap;

                return CardNutriShopHome(product: products[index]);
              },
              separatorBuilder: (context, index) {
                return const SizedBox(width: 8);
              },
              itemCount: productsMap.length,
            );
          }

          return const LoadingIndicator();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
