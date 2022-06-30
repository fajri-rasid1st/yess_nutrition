import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/constants.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/data/models/product_models/product_category_model.dart';
import 'package:yess_nutrition/presentation/pages/shop_pages/products_page.dart';
import 'package:yess_nutrition/presentation/providers/product_notifiers/products_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_information.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';
import 'package:yess_nutrition/presentation/widgets/product_category_card.dart';
import 'package:yess_nutrition/presentation/widgets/product_list_card.dart';

class ShopPage extends StatefulWidget {
  final String uid;

  const ShopPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<ProductsNotifier>(context, listen: false).getProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: secondaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 104,
        title: Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Text(
                'NutriShop',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Belanja kebutuhan makanan atau kesehatan',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: primaryBackgroundColor),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 36, 16, 0),
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: BoxDecoration(
                    color: secondaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      favoriteProductsRoute,
                      arguments: widget.uid,
                    ),
                    icon: const Icon(Icons.favorite),
                    color: primaryColor,
                    tooltip: 'Favorite',
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: Consumer<ProductsNotifier>(
        builder: (context, productsNotifier, child) {
          if (productsNotifier.state == RequestState.success) {
            return _buildMainPage(context, productsNotifier);
          }

          if (productsNotifier.state == RequestState.error) {
            return _buildPageError(productsNotifier);
          }

          return Container(
            color: scaffoldBackgroundColor,
            child: const LoadingIndicator(),
          );
        },
      ),
    );
  }

  ClipRRect _buildMainPage(BuildContext context, ProductsNotifier notifier) {
    final productsMap = notifier.productsMap;

    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      child: Container(
        color: scaffoldBackgroundColor,
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                child: Image.asset('assets/img/shop_frame_2.png'),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: Text(
                  'Kategori Kesehatan',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 170,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ProductCategoryCard(
                      uid: widget.uid,
                      productCategory: healthProductCategories[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 16);
                  },
                  itemCount: healthProductCategories.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                child: Text(
                  'Kategori Makanan & Minuman',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 170,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return ProductCategoryCard(
                      uid: widget.uid,
                      productCategory: foodProductCategories[index],
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 16);
                  },
                  itemCount: foodProductCategories.length,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 28, 16, 32),
                child: Image.asset('assets/img/shop_frame_1.png'),
              ),
              _buildTitleContent(
                context,
                'Produk kesehatan terlaris!',
                () => Navigator.pushNamed(
                  context,
                  productsRoute,
                  arguments: ProductListPageArgs(
                    widget.uid,
                    'Kesehatan terlaris',
                    healthProductBaseUrls[notifier.randIndex],
                  ),
                ),
              ),
              SizedBox(
                height: 270,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final products = productsMap['health']!;

                    return ProductListCard(product: products[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 8);
                  },
                  itemCount: productsMap['health']!.length,
                ),
              ),
              const SizedBox(height: 24),
              _buildTitleContent(
                context,
                'Produk makanan terlaris!',
                () => Navigator.pushNamed(
                  context,
                  productsRoute,
                  arguments: ProductListPageArgs(
                    widget.uid,
                    'Makanan terlaris',
                    foodProductBaseUrls[notifier.randIndex],
                  ),
                ),
              ),
              SizedBox(
                height: 270,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final products = productsMap['food']!;

                    return ProductListCard(product: products[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 8);
                  },
                  itemCount: productsMap['food']!.length,
                ),
              ),
              const SizedBox(height: 24),
              _buildTitleContent(
                context,
                'Rekomendasi untukmu!',
                () => Navigator.pushNamed(
                  context,
                  productsRoute,
                  arguments: ProductListPageArgs(
                    widget.uid,
                    'Produk rekomendasi',
                    recommendationProductBaseUrl,
                  ),
                ),
              ),
              SizedBox(
                height: 270,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    final products = productsMap['recommendation']!;

                    return ProductListCard(product: products[index]);
                  },
                  separatorBuilder: (context, index) {
                    return const SizedBox(width: 8);
                  },
                  itemCount: productsMap['recommendation']!.length,
                ),
              ),
            ],
          ),
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
      padding: const EdgeInsets.fromLTRB(16, 0, 10, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                  "Lihat semua",
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Icon(
                  MdiIcons.chevronRight,
                  color: primaryColor,
                  size: 20,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Container _buildPageError(ProductsNotifier notifier) {
    return Container(
      color: scaffoldBackgroundColor,
      child: CustomInformation(
        key: const Key('error_message'),
        imgPath: 'assets/svg/error_robot_cuate.svg',
        title: notifier.message,
        subtitle: 'Silahkan coba beberapa saat lagi.',
        child: ElevatedButton.icon(
          onPressed: notifier.isReload
              ? null
              : () {
                  // set isReload to true
                  notifier.isReload = true;

                  Future.wait([
                    // create one second delay
                    Future.delayed(const Duration(seconds: 1)),

                    // refresh page
                    notifier.getProducts(),
                  ]).then((_) {
                    // set isReload to true
                    notifier.isReload = false;
                  });
                },
          icon: notifier.isReload
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: dividerColor,
                  ),
                )
              : const Icon(Icons.refresh_rounded),
          label: notifier.isReload
              ? const Text('Tunggu sebentar...')
              : const Text('Coba lagi'),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
