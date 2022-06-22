import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/domain/entities/recipe_entity.dart';
import 'package:yess_nutrition/presentation/pages/check_pages/check_pages.dart';
import 'package:yess_nutrition/presentation/widgets/custom_network_image.dart';

class RecipeListTile extends StatelessWidget {
  final RecipeEntity recipe;
  final String heroTag;

  const RecipeListTile({
    Key? key,
    required this.recipe,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Hero(
                  tag: heroTag,
                  child: CustomNetworkImage(
                    width: 92,
                    height: 92,
                    imgUrl: recipe.image,
                    placeHolderSize: 46,
                    errorIcon: Icons.fastfood_outlined,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        recipe.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${recipe.calories.toStringAsFixed(0)}Kkal',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: primaryColor),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          const Icon(
                            MdiIcons.bowlMixOutline,
                            color: secondaryTextColor,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              '${recipe.totalServing.toString()} Porsi',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: secondaryTextColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.access_time_rounded,
                            color: secondaryTextColor,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              recipe.totalTime == 0
                                  ? 'Tidak ditentukan'
                                  : '${recipe.totalTime.toString()} Menit',
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: secondaryTextColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                recipeDetailRoute,
                arguments: RecipeDetailPageArgs(
                  recipe.uid!,
                  recipe.recipeId,
                  heroTag,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
