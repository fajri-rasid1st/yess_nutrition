import 'package:flutter/material.dart';
import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:yess_nutrition/data/models/shop_models/shop_product_list.dart';

class ProductListPage extends StatefulWidget {
  static const routeName = '/product_list_page';
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
  late Future<List<Produk>> futureProducts;

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
      body: FutureBuilder<List<Produk>>(
        future: futureProducts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final products = snapshot.data!;

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      openUrl(products[index].id,
                          forceWebview: true, enableJavaScript: true);
                    },
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

  Future<void> openUrl(String url,
      {bool forceWebview = false, bool enableJavaScript = false}) async {
    if (await canLaunch(url)) {
      await launch(url,
          forceWebView: forceWebview, enableJavaScript: enableJavaScript);
    }
  }

  Future<List<Produk>> getProducts(String uri) async {
    try {
      final url = Uri.parse(uri);
      final response = await http.get(url);

      dom.Document html = dom.Document.html(response.body);

      const idSelector = 'div.bl-thumbnail--slider > div > a ';
      const titleSelector = 'div.bl-product-card__description-name > p > a';
      const priceSelector = 'div.bl-product-card__description-price > p';
      const imgUrlSelector = 'div.bl-thumbnail--slider > div > a > img';

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

      final imgUrls = html
          .querySelectorAll(imgUrlSelector)
          .map((element) => element.attributes['src']!)
          .toList();

      return List<Produk>.generate(
        10,
        (index) {
          return Produk(
            id: ids[index],
            title: titles[index],
            price: prices[index],
            imgUrl: imgUrls[index],
          );
        },
      );
    } catch (e) {
      rethrow;
    }
  }
}
