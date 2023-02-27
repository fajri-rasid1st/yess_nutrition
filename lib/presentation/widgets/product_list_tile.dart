import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/domain/entities/product_entity.dart';
import 'package:yess_nutrition/presentation/widgets/custom_network_image.dart';

class ProductListTile extends StatelessWidget {
  final ProductEntity product;
  final VoidCallback onPressedOpenIcon;
  final VoidCallback onPressedDeleteIcon;

  const ProductListTile({
    Key? key,
    required this.product,
    required this.onPressedOpenIcon,
    required this.onPressedDeleteIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CustomNetworkImage(
              width: 90,
              height: 90,
              imgUrl: product.imgUrl,
              placeHolderSize: 40,
              errorIcon: Icons.motion_photos_off_outlined,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    product.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    product.price,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium!.copyWith(
                          fontWeight: FontWeight.bold,
                          color: primaryColor,
                        ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Icon(
                        Icons.star_rate_rounded,
                        color: Colors.orange[400],
                        size: 20,
                      ),
                      Text(
                        product.rating.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: Colors.orange[400]),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: onPressedOpenIcon,
                  icon: const Icon(
                    Icons.open_in_new_rounded,
                    size: 20,
                  ),
                  color: primaryColor,
                  tooltip: 'Buka',
                ),
              ),
              const SizedBox(width: 6),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: onPressedDeleteIcon,
                  icon: const Icon(
                    Icons.delete_outline_rounded,
                    size: 20,
                  ),
                  color: primaryColor,
                  tooltip: 'Hapus',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
