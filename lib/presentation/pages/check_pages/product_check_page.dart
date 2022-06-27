import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/failure.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';
import 'package:yess_nutrition/presentation/providers/food_notifiers/food_history_notifier.dart';
import 'package:yess_nutrition/presentation/providers/food_notifiers/search_product_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_information.dart';
import 'package:yess_nutrition/presentation/widgets/food_list_tile.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';
import 'package:yess_nutrition/presentation/widgets/search_field.dart';

class ProductCheckPage extends StatefulWidget {
  final String uid;

  const ProductCheckPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProductCheckPage> createState() => _ProductCheckPageState();
}

class _ProductCheckPageState extends State<ProductCheckPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: secondaryBackgroundColor,
        shadowColor: Colors.black.withOpacity(0.5),
        toolbarHeight: 64,
        centerTitle: true,
        title: const Text(
          'Product Nutrition Check',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 32,
          ),
          tooltip: 'Back',
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () => Navigator.pushNamed(
              context,
              foodAndProductCheckHistoryRoute,
              arguments: widget.uid,
            ),
            icon: const Icon(Icons.history_rounded),
            tooltip: 'History',
          )
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(68),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: _buildSearchField(),
          ),
        ),
      ),
      body: Consumer<SearchProductNotifier>(
        builder: (context, productNotifier, child) {
          final onChangedQuery = productNotifier.onChangedQuery;
          final onSubmittedQuery = productNotifier.onSubmittedQuery;
          final isOnChangedQueryEmpty = onChangedQuery.isEmpty;
          final isOnSubmittedQueryEmpty = onSubmittedQuery.isEmpty;
          final isTyping = onChangedQuery != onSubmittedQuery;

          if (isOnChangedQueryEmpty || isOnSubmittedQueryEmpty || isTyping) {
            return _buildFirstView();
          }

          if (productNotifier.state == RequestState.success) {
            final results = productNotifier.results;
            final hints = productNotifier.hints;

            return results.isEmpty && hints.isEmpty
                ? _buildSearchEmpty()
                : _buildSearchResults(context, results, hints);
          }

          if (productNotifier.state == RequestState.error) {
            return _buildSearchError(context, productNotifier);
          }

          return const LoadingIndicator();
        },
      ),
    );
  }

  Consumer<SearchProductNotifier> _buildSearchField() {
    return Consumer<SearchProductNotifier>(
      builder: (context, productNotifier, child) {
        return Row(
          children: <Widget>[
            Expanded(
              child: SearchField(
                controller: _searchController,
                query: productNotifier.onChangedQuery,
                hintText: 'Masukkan kode UPC produk...',
                backgroundColor: primaryBackgroundColor,
                textInputType: TextInputType.number,
                onChanged: (value) {
                  productNotifier.onChangedQuery = value.trim();
                },
                onSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    productNotifier.searchProduct(upc: value).then((_) async {
                      // add every search results to history
                      await addSearchedToHistory(context, productNotifier);
                    });
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: IconButton(
                onPressed: () async {
                  // retrieve upc from scanner
                  final upc = await FlutterBarcodeScanner.scanBarcode(
                    '#7165E3',
                    'Kembali',
                    true,
                    ScanMode.DEFAULT,
                  );

                  if (upc != '-1') {
                    // change search field text
                    _searchController.text = upc;

                    // change on changed query
                    productNotifier.onChangedQuery = upc;

                    // search product, according to upc
                    productNotifier.searchProduct(upc: upc).then((_) async {
                      // add every search results to history
                      await addSearchedToHistory(context, productNotifier);
                    });
                  }
                },
                icon: const Icon(Icons.qr_code_scanner_rounded),
                color: primaryBackgroundColor,
                tooltip: 'Scan Barcode/QRcode',
              ),
            ),
          ],
        );
      },
    );
  }

  SingleChildScrollView _buildSearchResults(
    BuildContext context,
    List<FoodEntity> results,
    List<FoodEntity> hints,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Hasil Pencarian:',
              style: Theme.of(context).textTheme.headline6,
            ),
          ),
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: (results.length + hints.length),
            itemBuilder: (context, index) {
              final products = [...results, ...hints];

              return FoodListTile(
                food: products[index],
                onPressedTimeIcon: () {},
              );
            },
            separatorBuilder: (context, index) => const Divider(height: 1),
          ),
        ],
      ),
    );
  }

  CustomInformation _buildFirstView() {
    return const CustomInformation(
      key: Key('first_view'),
      imgPath: 'assets/svg/product_hunt_cuate.svg',
      title: 'Mau cari produk apa?',
      subtitle: 'Hasil pencarian anda akan muncul di sini.',
    );
  }

  CustomInformation _buildSearchEmpty() {
    return const CustomInformation(
      key: Key('upc_not_found'),
      imgPath: 'assets/svg/not_found_cuate.svg',
      title: 'Kode UPC tidak ditemukan',
      subtitle: 'Coba masukkan kode produk yang lain.',
    );
  }

  CustomInformation _buildSearchError(
    BuildContext context,
    SearchProductNotifier productNotifier,
  ) {
    if (productNotifier.failure is ServerFailure) {
      return _buildSearchEmpty();
    }

    return CustomInformation(
      key: const Key('error_message'),
      imgPath: 'assets/svg/error_robot_cuate.svg',
      title: 'Gagal terhubung ke server',
      subtitle: 'Silahkan coba beberapa saat lagi.',
      child: ElevatedButton.icon(
        onPressed: productNotifier.isReload
            ? null
            : () {
                // set isReload to true
                productNotifier.isReload = true;

                Future.wait([
                  // create one second delay
                  Future.delayed(const Duration(seconds: 1)),

                  // refresh page
                  productNotifier.refresh(),
                ]).then((_) async {
                  // add every search results to history
                  await addSearchedToHistory(context, productNotifier);

                  // set isReload to true
                  productNotifier.isReload = false;
                });
              },
        icon: productNotifier.isReload
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: dividerColor,
                ),
              )
            : const Icon(Icons.refresh_rounded),
        label: productNotifier.isReload
            ? const Text('Tunggu sebentar...')
            : const Text('Coba lagi'),
      ),
    );
  }

  Future<void> addSearchedToHistory(
    BuildContext context,
    SearchProductNotifier productNotifier,
  ) async {
    if (productNotifier.state == RequestState.success) {
      final results = productNotifier.results;
      final hints = productNotifier.hints;

      for (var product in [...results, ...hints]) {
        final foodHistory = product.copyWith(
          uid: widget.uid,
          createdAt: DateTime.now(),
        );

        await context.read<FoodHistoryNotifier>().addFoodHistory(foodHistory);
      }
    }
  }
}
