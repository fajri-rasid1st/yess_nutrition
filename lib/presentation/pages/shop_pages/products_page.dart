import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/keys.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/domain/entities/product_entity.dart';
import 'package:yess_nutrition/presentation/providers/product_notifiers/favorite_product_notifier.dart';
import 'package:yess_nutrition/presentation/providers/product_notifiers/product_list_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/widgets.dart';

class ProductsPage extends StatefulWidget {
  final String uid;
  final String title;
  final String productBaseUrl;

  const ProductsPage({
    Key? key,
    required this.uid,
    required this.title,
    required this.productBaseUrl,
  }) : super(key: key);

  @override
  State<ProductsPage> createState() => _ProductsPageState();
}

class _ProductsPageState extends State<ProductsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<ProductListNotifier>(context, listen: false)
          .getProducts(productBaseUrl: widget.productBaseUrl);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(0.5),
        toolbarHeight: 64,
        centerTitle: true,
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 32,
          ),
          tooltip: 'Back',
        ),
      ),
      body: Consumer<ProductListNotifier>(
        builder: (context, productListNotifier, child) {
          if (productListNotifier.state == RequestState.success) {
            final productsWithUid = productListNotifier.products.map((product) {
              return product.copyWith(uid: widget.uid);
            }).toList();

            return _buildGridProducts(productsWithUid);
          }

          if (productListNotifier.state == RequestState.error) {
            return _buildPageError(productListNotifier);
          }

          return Container(
            color: primaryBackgroundColor,
            child: const LoadingIndicator(),
          );
        },
      ),
    );
  }

  GridView _buildGridProducts(List<ProductEntity> products) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 12,
        crossAxisSpacing: 6,
        childAspectRatio: 0.58,
      ),
      itemBuilder: (context, index) {
        return ProductGridCard(
          product: products[index],
          onPressedAddIcon: () => onPressedAddIcon(context, products[index]),
        );
      },
      itemCount: products.length,
    );
  }

  Container _buildPageError(ProductListNotifier notifier) {
    return Container(
      color: primaryBackgroundColor,
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
                    notifier.refresh(),
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

  void onPressedAddIcon(BuildContext context, ProductEntity product) async {
    final favoriteNotifier = context.read<FavoriteProductNotifier>();

    await favoriteNotifier.getFavoriteProductStatus(product);

    final isExist = favoriteNotifier.isExist;

    if (isExist) {
      const message = 'Sudah ada di daftar favorit anda';
      final snackBar = Utilities.createSnackBar(message);

      scaffoldMessengerKey.currentState!
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    } else {
      await favoriteNotifier.createFavoriteProduct(product);

      final message = favoriteNotifier.message;
      final snackBar = Utilities.createSnackBar(message);

      scaffoldMessengerKey.currentState!
        ..hideCurrentSnackBar()
        ..showSnackBar(snackBar);
    }
  }
}

class ProductListPageArgs {
  final String uid;
  final String title;
  final String productBaseUrl;

  ProductListPageArgs(this.uid, this.title, this.productBaseUrl);
}
