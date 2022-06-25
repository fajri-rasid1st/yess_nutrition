import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/presentation/providers/product_notifiers/product_list_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_information.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class ProductListPage extends StatefulWidget {
  final String title;
  final String productBaseUrl;

  const ProductListPage({
    Key? key,
    required this.title,
    required this.productBaseUrl,
  }) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
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
        elevation: 0,
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
            return const SizedBox();
          }

          if (productListNotifier.state == RequestState.error) {
            return _buildPageError(productListNotifier);
          }

          return const LoadingIndicator();
        },
      ),
    );
  }

  CustomInformation _buildPageError(ProductListNotifier notifier) {
    return CustomInformation(
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
    );
  }
}

class ProductListPageArgs {
  final String title;
  final String productBaseUrl;

  ProductListPageArgs(this.title, this.productBaseUrl);
}
