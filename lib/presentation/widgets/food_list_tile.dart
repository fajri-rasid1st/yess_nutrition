import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/domain/entities/food_entity.dart';
import 'package:yess_nutrition/presentation/widgets/custom_network_image.dart';

class FoodListTile extends StatelessWidget {
  final FoodEntity food;
  final VoidCallback? onPressedTimeIcon;

  const FoodListTile({
    Key? key,
    required this.food,
    this.onPressedTimeIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: CustomNetworkImage(
                  width: 68,
                  height: 68,
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
                        maxLines: 2,
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
                    ],
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: secondaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  onPressed: onPressedTimeIcon,
                  icon: const Icon(MdiIcons.timerOutline),
                  color: primaryColor,
                  tooltip: 'Add to journal',
                ),
              )
            ],
          ),
          if (food.foodContentLabel.isNotEmpty) ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<Container>.generate(
                food.foodContentLabel.length,
                (index) {
                  return _buildFoodContentLabelChip(
                    context,
                    food.foodContentLabel[index],
                  );
                },
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 4),
            child: Text(
              'Kandungan nutrisi per porsi:',
              style: Theme.of(context)
                  .textTheme
                  .subtitle2!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          _buildNutrientDetail(
            dotsColor: primaryColor,
            nutrient: 'Kalori',
            amount: '${food.nutrients.calories.toStringAsFixed(0)} Kkal',
          ),
          _buildNutrientDetail(
            dotsColor: const Color(0XFF5ECFF2),
            nutrient: 'Karbohidrat',
            amount: '${food.nutrients.carbohydrate.toStringAsFixed(1)} g',
          ),
          _buildNutrientDetail(
            dotsColor: const Color(0XFFEF5EF2),
            nutrient: 'Protein',
            amount: '${food.nutrients.protein.toStringAsFixed(1)} g',
          ),
          _buildNutrientDetail(
            dotsColor: errorColor,
            nutrient: 'Lemak',
            amount: '${food.nutrients.fat.toStringAsFixed(1)} g',
          ),
          _buildNutrientDetail(
            dotsColor: dividerColor,
            nutrient: 'Serat',
            amount: '${food.nutrients.fiber.toStringAsFixed(1)} g',
          ),
        ],
      ),
    );
  }

  Container _buildFoodContentLabelChip(BuildContext context, String label) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Text(
          label,
          style: Theme.of(context)
              .textTheme
              .caption!
              .copyWith(color: primaryColor),
        ),
      ),
    );
  }

  Padding _buildNutrientDetail({
    required String nutrient,
    required String amount,
    required Color dotsColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  color: dotsColor,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(width: 8),
              Text(nutrient),
            ],
          ),
          Text(amount),
        ],
      ),
    );
  }
}
