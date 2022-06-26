import 'package:equatable/equatable.dart';
import 'package:yess_nutrition/common/utils/constants.dart';

class ProductCategoryModel extends Equatable {
  final String title;
  final String imgAsset;
  final String baseUrl;

  const ProductCategoryModel({
    required this.title,
    required this.imgAsset,
    required this.baseUrl,
  });

  @override
  List<Object> get props => [title, imgAsset, baseUrl];
}

/// list of food product category urls
final foodProductCategories = <ProductCategoryModel>[
  ProductCategoryModel(
    title: 'Makanan',
    imgAsset: 'assets/img/food_category_food.png',
    baseUrl: foodProductBaseUrls[0],
  ),
  ProductCategoryModel(
    title: 'Makanan Beku',
    imgAsset: 'assets/img/food_category_frozen_food.png',
    baseUrl: foodProductBaseUrls[1],
  ),
  ProductCategoryModel(
    title: 'Makanan Jadi',
    imgAsset: 'assets/img/food_category_prepared_food.png',
    baseUrl: foodProductBaseUrls[2],
  ),
  ProductCategoryModel(
    title: 'Minuman',
    imgAsset: 'assets/img/food_category_beverage.png',
    baseUrl: foodProductBaseUrls[3],
  ),
  ProductCategoryModel(
    title: 'Buah & Sayur',
    imgAsset: 'assets/img/food_category_fruit_and_vegetable.png',
    baseUrl: foodProductBaseUrls[4],
  ),
  ProductCategoryModel(
    title: 'Telur & Protein',
    imgAsset: 'assets/img/food_category_egg.png',
    baseUrl: foodProductBaseUrls[5],
  ),
  ProductCategoryModel(
    title: 'Bumbu',
    imgAsset: 'assets/img/food_category_seasoning.png',
    baseUrl: foodProductBaseUrls[6],
  ),
  ProductCategoryModel(
    title: 'Beras',
    imgAsset: 'assets/img/food_category_rice.png',
    baseUrl: foodProductBaseUrls[7],
  ),
  ProductCategoryModel(
    title: 'Bahan Kue',
    imgAsset: 'assets/img/food_category_cake_ingredient.png',
    baseUrl: foodProductBaseUrls[8],
  ),
  ProductCategoryModel(
    title: 'Kue',
    imgAsset: 'assets/img/food_category_cake.png',
    baseUrl: foodProductBaseUrls[9],
  ),
];

/// list of health product categories urls
final healthProductCategories = <ProductCategoryModel>[
  ProductCategoryModel(
    title: 'Alat Kesehatan',
    imgAsset: 'assets/img/health_category_medical_tool.png',
    baseUrl: healthProductBaseUrls[0],
  ),
  ProductCategoryModel(
    title: 'Essential Oil',
    imgAsset: 'assets/img/health_category_essential_oil.png',
    baseUrl: healthProductBaseUrls[1],
  ),
  ProductCategoryModel(
    title: 'Masker',
    imgAsset: 'assets/img/health_category_mask.png',
    baseUrl: healthProductBaseUrls[2],
  ),
  ProductCategoryModel(
    title: 'Kesehatan Mata',
    imgAsset: 'assets/img/health_category_eye.png',
    baseUrl: healthProductBaseUrls[3],
  ),
  ProductCategoryModel(
    title: 'Kesehatan Mulut & Gigi',
    imgAsset: 'assets/img/health_category_mouth_and_teeth.png',
    baseUrl: healthProductBaseUrls[4],
  ),
  ProductCategoryModel(
    title: 'Kesehatan Telinga',
    imgAsset: 'assets/img/health_category_ear.png',
    baseUrl: healthProductBaseUrls[5],
  ),
  ProductCategoryModel(
    title: 'Kesehatan Wanita',
    imgAsset: 'assets/img/health_category_female.png',
    baseUrl: healthProductBaseUrls[6],
  ),
  ProductCategoryModel(
    title: 'Obat & Vitamin',
    imgAsset: 'assets/img/health_category_drug_and_vitamin.png',
    baseUrl: healthProductBaseUrls[7],
  ),
];
