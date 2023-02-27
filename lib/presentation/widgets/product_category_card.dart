import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/data/models/product_models/product_category_model.dart';
import 'package:yess_nutrition/presentation/pages/shop_pages/products_page.dart';

class ProductCategoryCard extends StatelessWidget {
  final String uid;
  final ProductCategoryModel productCategory;

  const ProductCategoryCard({
    Key? key,
    required this.uid,
    required this.productCategory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () => Navigator.pushNamed(
        context,
        productsRoute,
        arguments: ProductListPageArgs(
          uid,
          productCategory.title,
          productCategory.baseUrl,
        ),
      ),
      style: OutlinedButton.styleFrom(
        fixedSize: const Size(150, 0),
        backgroundColor: primaryBackgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: <Widget>[
            Image.asset(
              productCategory.imgAsset,
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                productCategory.title,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: primaryColor),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
