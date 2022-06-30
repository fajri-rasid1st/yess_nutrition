import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/domain/entities/user_food_schedule_entity.dart';
import 'package:yess_nutrition/presentation/widgets/custom_network_image.dart';

class FoodScheduleListTile extends StatelessWidget {
  final UserFoodScheduleEntity foodSchedule;
  final VoidCallback onPressedChecklistButton;

  const FoodScheduleListTile({
    Key? key,
    required this.foodSchedule,
    required this.onPressedChecklistButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 18),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: CustomNetworkImage(
              width: 68,
              height: 68,
              imgUrl: foodSchedule.foodImage,
              placeHolderSize: 34,
              errorIcon: Icons.fastfood_outlined,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      const Icon(
                        Icons.schedule_outlined,
                        color: secondaryTextColor,
                        size: 12,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        foodSchedule.scheduleType,
                        style: Theme.of(context).textTheme.overline!.copyWith(
                              color: secondaryTextColor,
                              letterSpacing: 0.75,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    foodSchedule.foodName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: primaryTextColor),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '${foodSchedule.foodNutrients.calories.toStringAsFixed(0)} Kkal (${foodSchedule.totalServing} Porsi)',
                    style: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: primaryColor),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: secondaryColor,
              borderRadius: BorderRadius.circular(8),
            ),
            child: IconButton(
              onPressed: foodSchedule.isDone ? null : onPressedChecklistButton,
              icon: const Icon(
                MdiIcons.check,
                size: 18,
              ),
              color: primaryColor,
              tooltip: 'Checklist',
            ),
          ),
        ],
      ),
    );
  }
}
