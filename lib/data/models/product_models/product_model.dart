import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/domain/entities/product_entity.dart';

class ProductModel extends Equatable {
  final String url;
  final String title;
  final String price;
  final double rating;
  final String imgUrl;

  const ProductModel({
    required this.url,
    required this.title,
    required this.price,
    required this.rating,
    required this.imgUrl,
  });

  ProductEntity toEntity() {
    return ProductEntity(
      url: url,
      title: title,
      price: price,
      rating: rating,
      imgUrl: imgUrl,
    );
  }

  @override
  List<Object?> get props => [url, title, price, rating, imgUrl];
}
