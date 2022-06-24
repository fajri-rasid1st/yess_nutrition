import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/product_entity.dart';

const productFavoriteTable = 'product_favorite_table';

class ProductTable extends Equatable {
  final String uid;
  final String url;
  final String title;
  final String price;
  final num rating;
  final String imgUrl;

  const ProductTable({
    required this.uid,
    required this.url,
    required this.title,
    required this.price,
    required this.rating,
    required this.imgUrl,
  });

  factory ProductTable.fromEntity(ProductEntity product) {
    return ProductTable(
      uid: product.uid!,
      url: product.url,
      title: product.title,
      price: product.price,
      rating: product.rating,
      imgUrl: product.imgUrl,
    );
  }

  factory ProductTable.fromMap(Map<String, dynamic> product) {
    return ProductTable(
      uid: product['uid'] as String,
      url: product['url'] as String,
      title: product['title'] as String,
      price: product['price'] as String,
      rating: product['rating'] as num,
      imgUrl: product['imgUrl'] as String,
    );
  }

  ProductEntity toEntity() {
    return ProductEntity.favorite(
      uid: uid,
      url: url,
      title: title,
      price: price,
      rating: rating.toDouble(),
      imgUrl: imgUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'url': url,
      'title': title,
      'price': price,
      'rating': rating,
      'imgUrl': imgUrl,
    };
  }

  @override
  List<Object?> get props => [uid, url, title, price, rating, imgUrl];
}
