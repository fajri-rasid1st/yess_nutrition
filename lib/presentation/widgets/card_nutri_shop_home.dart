import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/common/utils/utils.dart';
import 'package:yess_nutrition/domain/entities/entities.dart';

class CardNutriShopHome extends StatelessWidget {
  final ProductEntity product;

  const CardNutriShopHome({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: <Widget>[
          Container(
            width: 130,
            height: 190,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryBackgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                  color: const Color.fromARGB(255, 139, 127, 127)
                      .withOpacity(0.05),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 110,
                  height: 110,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Image.network(
                    product.imgUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Kesehatan",
                  style: TextStyle(
                    color: secondaryTextColor,
                    fontWeight: FontWeight.w400,
                    fontSize: 9,
                  ),
                ),
                Text(
                  product.title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: primaryTextColor,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  product.price,
                  style: Theme.of(context).textTheme.bodyText2?.copyWith(
                        fontWeight: FontWeight.w900,
                        color: errorColor,
                      ),
                )
              ],
            ),
          ),
          Positioned.fill(
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  webviewRoute,
                  arguments: product.url,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
