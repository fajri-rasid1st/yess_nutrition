import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
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
    futureProducts = getProducts(widget.url);

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
                    onTap: () async => await openUrl(products[index].id),
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

  Future<List<ProductModel>> getProducts(String uri) async {
    try {
      final url = Uri.parse(uri);

      final response = await http.get(url);

      final html = dom.Document.html(response.body);

      const idSelector = 'div.bl-product-card__description-name > p > a';
      const titleSelector = 'div.bl-product-card__description-name > p > a';
      const priceSelector = 'div.bl-product-card__description-price > p';
      const ratingSelector = 'div.bl-product-card__description-rating > p > a';
      const imgUrlSelector =
          'div.bl-product-card__thumbnail > figure > div > div > a > img';

      final ids = html
          .querySelectorAll(idSelector)
          .map((element) => element.attributes['href']!)
          .toList();

      final titles = html
          .querySelectorAll(titleSelector)
          .map((element) => element.innerHtml.trim())
          .toList();

      final prices = html
          .querySelectorAll(priceSelector)
          .map((element) => element.innerHtml.trim())
          .toList();

      final ratings = html
          .querySelectorAll(ratingSelector)
          .map((element) => element.innerHtml.trim())
          .toList();

      final imgUrls = html
          .querySelectorAll(imgUrlSelector)
          .map((element) => element.attributes['src']!)
          .toList();

      final descs = [
        ids.length,
        titles.length,
        prices.length,
        ratings.length,
        imgUrls.length,
      ];

      var minLength = 0;

      for (var i = 0; i < descs.length - 1; i++) {
        minLength = math.min(descs[i], descs[i + 1]);
      }

      return List<ProductModel>.generate(
        minLength,
        (index) {
          return ProductModel(
            id: ids[index],
            title: titles[index],
            price: prices[index],
            rating: ratings[index],
            imgUrl: imgUrls[index],
          );
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}

class ProductListPageArgs {
  final String title;
  final String url;

  ProductListPageArgs(this.title, this.url);
}
