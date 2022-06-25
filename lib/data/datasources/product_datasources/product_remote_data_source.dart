import 'package:html/dom.dart' as dom;
import 'package:http/http.dart' as http;
import 'package:yess_nutrition/common/utils/exception.dart';
import 'package:yess_nutrition/data/models/product_models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts(String productBaseUrl);
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProducts(String productBaseUrl) async {
    final uri = Uri.parse(productBaseUrl);

    final response = await client.get(uri);

    if (response.statusCode == 200) {
      final html = dom.Document.html(response.body);

      const urlTitleSelector = 'div.bl-product-card__description-name > p > a';
      const priceSelector = 'div.bl-product-card__description-price > p';
      const ratingSelector = 'div.bl-product-card__description-rating > p > a';
      const imgUrlSelector =
          'div.bl-product-card__thumbnail > figure > div > div > a > img';

      final urls = html
          .querySelectorAll(urlTitleSelector)
          .map((element) => element.attributes['href']!)
          .toList();

      final titles = html
          .querySelectorAll(urlTitleSelector)
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

      final minLengths = [
        urls.length,
        titles.length,
        prices.length,
        ratings.length,
        imgUrls.length,
      ]..sort();

      return List<ProductModel>.generate(
        minLengths[0],
        (index) {
          return ProductModel(
            url: urls[index],
            title: titles[index],
            price: prices[index],
            rating: double.parse(ratings[index]),
            imgUrl: imgUrls[index],
          );
        },
      );
    }

    throw ServerException('Internal server error');
  }
}
