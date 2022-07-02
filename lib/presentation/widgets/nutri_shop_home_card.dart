import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/utils.dart';
import 'package:yess_nutrition/domain/entities/entities.dart';
import 'package:yess_nutrition/presentation/widgets/custom_network_image.dart';

class NutriShopHomeCard extends StatelessWidget {
  final ProductEntity product;

  const NutriShopHomeCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: <Widget>[
          Container(
            width: 130,
            height: 200,
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
                  child: CustomNetworkImage(
                    imgUrl: product.imgUrl,
                    fit: BoxFit.cover,
                    placeHolderSize: 55,
                    errorIcon: Icons.motion_photos_off_outlined,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  product.title,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2!
                      .copyWith(color: primaryTextColor),
                ),
                const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Icon(
                      Icons.star_rate_rounded,
                      color: Colors.orange[400],
                      size: 14,
                    ),
                    Text(
                      product.rating.toString(),
                      style: Theme.of(context).textTheme.subtitle2!.copyWith(
                            color: Colors.orange[400],
                            fontSize: 12,
                          ),
                    )
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  product.price,
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontWeight: FontWeight.bold,
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
