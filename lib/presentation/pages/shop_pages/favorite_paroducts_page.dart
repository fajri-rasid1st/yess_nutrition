import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/keys.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/domain/entities/product_entity.dart';
import 'package:yess_nutrition/presentation/providers/product_notifiers/favorite_product_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/widgets.dart';

class FavoriteProductsPage extends StatefulWidget {
  final String uid;

  const FavoriteProductsPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<FavoriteProductsPage> createState() => _FavoriteProductsPageState();
}

class _FavoriteProductsPageState extends State<FavoriteProductsPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<FavoriteProductNotifier>(context, listen: false)
          .getFavoriteProducts(widget.uid);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        elevation: 0.8,
        toolbarHeight: 64,
        centerTitle: true,
        title: const Text(
          'Produk Favorite',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 32,
          ),
          color: primaryColor,
          tooltip: 'Back',
        ),
        actions: <Widget>[
          IconButton(
            onPressed: context
                    .watch<FavoriteProductNotifier>()
                    .favorites
                    .isEmpty
                ? null
                : () {
                    Utilities.showConfirmDialog(
                      context,
                      title: 'Konfirmasi',
                      question: 'Hapus semua produk favorite?',
                      onPressedPrimaryAction: () {
                        clearFavorites(context).then((_) {
                          Navigator.pop(context);
                        });
                      },
                      onPressedSecondaryAction: () => Navigator.pop(context),
                    );
                  },
            icon: const Icon(
              Icons.clear_all_rounded,
              size: 28,
            ),
            color: primaryColor,
            tooltip: 'Clear All',
          ),
        ],
      ),
      body: Consumer<FavoriteProductNotifier>(
        builder: (context, favoriteNotifier, child) {
          if (favoriteNotifier.state == RequestState.success) {
            if (favoriteNotifier.favorites.isEmpty) {
              return const CustomInformation(
                key: Key('favorite_empty'),
                imgPath: 'assets/svg/groceries_cuate.svg',
                title: 'Produk favorite masih kosong',
                subtitle: 'Produk favorite akan muncul di sini.',
              );
            }

            return _buildFavoriteList(favoriteNotifier.favorites);
          } else if (favoriteNotifier.state == RequestState.error) {
            return CustomInformation(
              key: const Key('error_message'),
              imgPath: 'assets/svg/feeling_sorry_cuate.svg',
              title: favoriteNotifier.message,
              subtitle: 'Silahkan kembali beberapa saat lagi.',
            );
          }

          return const LoadingIndicator();
        },
      ),
    );
  }

  ListView _buildFavoriteList(List<ProductEntity> favorites) {
    return ListView.separated(
      itemCount: favorites.length,
      itemBuilder: (context, index) {
        final favorite = favorites[index];

        return ProductListTile(
          product: favorite,
          onPressedOpenIcon: () => Navigator.pushNamed(
            context,
            webviewRoute,
            arguments: favorite.url,
          ),
          onPressedDeleteIcon: () async {
            await deleteFavorite(context, favorite);
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(height: 1),
    );
  }

  Future<void> deleteFavorite(
    BuildContext context,
    ProductEntity product,
  ) async {
    final favoriteNotifier = context.read<FavoriteProductNotifier>();

    await favoriteNotifier.deleteFavoriteProduct(product);

    final message = favoriteNotifier.message;
    final snackBar = Utilities.createSnackBar(message);

    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    await favoriteNotifier.getFavoriteProducts(widget.uid);
  }

  Future<void> clearFavorites(BuildContext context) async {
    final favoriteNotifier = context.read<FavoriteProductNotifier>();

    await favoriteNotifier.clearFavoriteProducts(widget.uid);

    final message = favoriteNotifier.message;
    final snackBar = Utilities.createSnackBar(message);

    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    await favoriteNotifier.getFavoriteProducts(widget.uid);
  }
}
