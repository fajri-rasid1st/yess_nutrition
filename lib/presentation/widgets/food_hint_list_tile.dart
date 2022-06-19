import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';
import 'package:yess_nutrition/presentation/widgets/custom_network_image.dart';

class FoodHintListTile extends StatelessWidget {
  final FoodEntity food;
  final VoidCallback? onPressedSearchIcon;
  final VoidCallback? onPressedTimeIcon;

  const FoodHintListTile({
    Key? key,
    required this.food,
    this.onPressedSearchIcon,
    this.onPressedTimeIcon,
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
              width: 60,
              height: 60,
              fit: BoxFit.cover,
              imgUrl: food.image,
              placeHolderSize: 36,
              errorIcon: Icons.fastfood_outlined,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    food.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${food.categoryLabel}, ${food.category}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: secondaryTextColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${food.nutrients.calories.toStringAsFixed(0)} Kkal',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: primaryColor),
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
                  onPressed: onPressedSearchIcon,
                  icon: const Icon(
                    Icons.search_outlined,
                    size: 20,
                  ),
                  color: primaryColor,
                  tooltip: 'Search',
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
                  onPressed: onPressedTimeIcon,
                  icon: const Icon(
                    MdiIcons.timerOutline,
                    size: 20,
                  ),
                  color: primaryColor,
                  tooltip: 'Add to journal',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
