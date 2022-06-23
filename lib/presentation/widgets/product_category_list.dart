import 'package:flutter/material.dart';
import 'package:yess_nutrition/data/models/product_models/product_category_model.dart';
import 'package:yess_nutrition/presentation/widgets/product_category_card.dart';

class ProductCategoryList extends StatelessWidget {
  final List<ProductCategoryModel> productCategories;

  const ProductCategoryList({
    Key? key,
    required this.productCategories,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: productCategories.length,
      itemBuilder: (context, index) => ProductCategoryCard(
        imgAsset: productCategories[index].imgAsset,
        title: productCategories[index].title,
        onPressed: () {},
      ),
      separatorBuilder: (context, index) => const SizedBox(width: 16),
    );
  }
}
