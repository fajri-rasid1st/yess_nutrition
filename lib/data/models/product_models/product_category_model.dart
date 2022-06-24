import 'package:equatable/equatable.dart';

class ProductCategoryModel extends Equatable {
  final String title;
  final String imgAsset;

  const ProductCategoryModel({required this.title, required this.imgAsset});

  @override
  List<Object> get props => [title, imgAsset];
}
