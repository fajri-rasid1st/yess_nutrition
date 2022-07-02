import 'package:equatable/equatable.dart';

class ProductEntity extends Equatable {
  final String? uid;
  final String url;
  final String title;
  final String price;
  final double rating;
  final String imgUrl;

  const ProductEntity({
    this.uid,
    required this.url,
    required this.title,
    required this.price,
    required this.rating,
    required this.imgUrl,
  });

  const ProductEntity.favorite({
    required this.uid,
    required this.url,
    required this.title,
    required this.price,
    required this.rating,
    required this.imgUrl,
  });

  ProductEntity copyWith({
    String? uid,
    String? url,
    String? title,
    String? price,
    double? rating,
    String? imgUrl,
  }) {
    return ProductEntity(
      uid: uid ?? this.uid,
      url: url ?? this.url,
      title: title ?? this.title,
      price: price ?? this.price,
      rating: rating ?? this.rating,
      imgUrl: imgUrl ?? this.imgUrl,
    );
  }

  @override
  List<Object?> get props => [uid, url, title, price, rating, imgUrl];
}
