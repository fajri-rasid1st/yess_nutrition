import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yess_nutrition/data/models/product_models/product_model.dart';

class ProductListPage extends StatefulWidget {
  final String title;
  final String url;

  const ProductListPage({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  late Future<List<ProductModel>> futureProducts;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<ProductModel>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final products = snapshot.data!;

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () async => await openUrl(products[index].url),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          products[index].imgUrl,
                          width: 60,
                          height: 60,
                          fit: BoxFit.fill,
                        ),
                      ),
                      // trailing: LoveButton(),
                      title: Text(products[index].title),
                      subtitle: Text(products[index].price),
                    ),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: products.length,
              );
            }

            return Center(child: Text(snapshot.error.toString()));
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<bool> openUrl(String url) async {
    final uri = Uri.parse(url);

    final isValidUrl = await canLaunchUrl(uri);

    if (isValidUrl) await launchUrl(uri);

    return Future.value(false);
  }
}

class ProductListPageArgs {
  final String title;
  final String url;

  ProductListPageArgs(this.title, this.url);
}
