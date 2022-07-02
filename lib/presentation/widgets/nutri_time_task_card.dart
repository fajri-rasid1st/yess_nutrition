import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/domain/entities/user_food_schedule_entity.dart';
import 'package:yess_nutrition/presentation/widgets/custom_network_image.dart';

class NutriTimeTaskCard extends StatelessWidget {
  final UserFoodScheduleEntity foodSchedule;

  const NutriTimeTaskCard({
    Key? key,
    required this.foodSchedule,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
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
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
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
                    const SizedBox(width: 2),
                    Text(
                      foodSchedule.isDone ? '(Selesai)' : '(Pending)',
                      style: Theme.of(context).textTheme.overline!.copyWith(
                            color:
                                foodSchedule.isDone ? Colors.green : Colors.red,
                            letterSpacing: 0.75,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  foodSchedule.foodName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1!
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
      ],
    );
  }
}
