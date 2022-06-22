import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/keys.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/domain/entities/recipe_detail_entity.dart';
import 'package:yess_nutrition/domain/entities/recipe_entity.dart';
import 'package:yess_nutrition/presentation/providers/recipe_notifiers/get_recipe_detail_notifier.dart';
import 'package:yess_nutrition/presentation/providers/recipe_notifiers/recipe_bookmark_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_chip.dart';
import 'package:yess_nutrition/presentation/widgets/custom_information.dart';
import 'package:yess_nutrition/presentation/widgets/custom_network_image.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';

class RecipeDetailPage extends StatefulWidget {
  final RecipeEntity recipe;
  final String heroTag;

  const RecipeDetailPage({
    Key? key,
    required this.recipe,
    required this.heroTag,
  }) : super(key: key);

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<GetRecipeDetailNotifier>(context, listen: false)
          .getRecipeDetail(recipeId: widget.recipe.recipeId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Consumer<GetRecipeDetailNotifier>(
        builder: (context, detailNotifier, child) {
          if (detailNotifier.state == RequestState.success) {
            return _buildDetailPage(detailNotifier.recipe);
          }

          if (detailNotifier.state == RequestState.error) {
            return _buildDetailError(detailNotifier);
          }

          return Container(
            color: primaryBackgroundColor,
            child: const LoadingIndicator(),
          );
        },
      ),
    );
  }

  NestedScrollView _buildDetailPage(RecipeDetailEntity recipeDetail) {
    return NestedScrollView(
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return <Widget>[
          SliverAppBar(
            pinned: true,
            toolbarHeight: 64,
            expandedHeight: 280,
            centerTitle: true,
            title: Text(recipeDetail.label),
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.chevron_left_rounded,
                size: 32,
              ),
              tooltip: 'Back',
            ),
            actions: <Widget>[
              _buildShareIconAction(recipeDetail),
              _buildBookmarkIconAction(),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: <Widget>[
                  Hero(
                    tag: widget.heroTag,
                    child: CustomNetworkImage(
                      width: double.infinity,
                      fit: BoxFit.fill,
                      imgUrl: recipeDetail.image,
                      placeHolderSize: 100,
                      errorIcon: Icons.motion_photos_off_outlined,
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                          colors: [Colors.black87, Colors.black38],
                        ),
                      ),
                    ),
                  ),
                  _buildFlexibleSpaceTitle(context, recipeDetail),
                ],
              ),
            ),
          ),
        ];
      },
      body: _buildBody(recipeDetail),
    );
  }

  ClipRRect _buildBody(RecipeDetailEntity recipeDetail) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        color: primaryBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                child: Text(
                  'Nutrition Facts',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: <Text>[
                      Text(
                        '${recipeDetail.calories.toStringAsFixed(0)}Kkal',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Total Kalori',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 56,
                    child: VerticalDivider(),
                  ),
                  Column(
                    children: <Text>[
                      Text(
                        '${recipeDetail.totalNutrients.carbohydrate.toStringAsFixed(0)}g',
                        style: Theme.of(context)
                            .textTheme
                            .headline5!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Karbohidrat',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 16,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Column>[
                        Column(
                          children: <Text>[
                            Text(
                              '${recipeDetail.totalNutrients.protein.toStringAsFixed(0)}g',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Protein',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                        Column(
                          children: <Text>[
                            Text(
                              '${recipeDetail.totalNutrients.fat.toStringAsFixed(0)}g',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Lemak',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                        Column(
                          children: <Text>[
                            Text(
                              '${recipeDetail.totalNutrients.fiber.toStringAsFixed(0)}g',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Serat',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildFlexibleSpaceTitle(
    BuildContext context,
    RecipeDetailEntity recipeDetail,
  ) {
    final textStyle = Theme.of(context).textTheme.headline4!.copyWith(
          color: primaryBackgroundColor,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        );

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            recipeDetail.label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: textStyle,
          ),
          RichText(
            text: TextSpan(
              style: textStyle,
              children: <TextSpan>[
                TextSpan(
                  text: (recipeDetail.calories / recipeDetail.totalServing)
                      .toStringAsFixed(0),
                ),
                const TextSpan(
                  text: 'Kkal/porsi',
                  style: TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: <Widget>[
              CustomChip(
                label: '${recipeDetail.totalServing} Porsi',
                labelColor: primaryBackgroundColor,
                backgroundColor: secondaryColor.withOpacity(0.5),
                icon: MdiIcons.bowlMixOutline,
                iconColor: primaryBackgroundColor,
              ),
              CustomChip(
                label: recipeDetail.totalTime == 0
                    ? 'Tidak ditentukan'
                    : '${recipeDetail.totalTime} Menit',
                labelColor: primaryBackgroundColor,
                backgroundColor: secondaryColor.withOpacity(0.5),
                icon: Icons.access_time_rounded,
                iconColor: primaryBackgroundColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  IconButton _buildShareIconAction(RecipeDetailEntity recipeDetail) {
    return IconButton(
      onPressed: () async {
        await Share.share('Hai, coba deh cek ini\n\n${recipeDetail.url}');
      },
      icon: const Icon(
        Icons.share_rounded,
        size: 22,
      ),
      tooltip: 'Share',
    );
  }

  Consumer<RecipeBookmarkNotifier> _buildBookmarkIconAction() {
    return Consumer<RecipeBookmarkNotifier>(
      builder: (context, bookmarkNotifier, child) {
        final isExist = bookmarkNotifier.isExist;

        return IconButton(
          onPressed: () async {
            if (isExist) {
              await bookmarkNotifier.deleteRecipeBookmark(widget.recipe);
            } else {
              await bookmarkNotifier.createRecipeBookmark(widget.recipe);
            }

            final message = bookmarkNotifier.message;
            final snackBar = Utilities.createSnackBar(message);

            scaffoldMessengerKey.currentState!
              ..hideCurrentSnackBar()
              ..showSnackBar(snackBar);
          },
          icon: Icon(
            isExist ? Icons.bookmark_rounded : Icons.bookmark_border_rounded,
            size: 26,
          ),
          tooltip: 'Bookmark',
        );
      },
    );
  }

  CustomInformation _buildDetailError(GetRecipeDetailNotifier detailNotifier) {
    return CustomInformation(
      key: const Key('error_message'),
      imgPath: 'assets/svg/error_robot_cuate.svg',
      title: detailNotifier.message,
      subtitle: 'Silahkan coba beberapa saat lagi.',
      child: ElevatedButton.icon(
        onPressed: detailNotifier.isReload
            ? null
            : () {
                // set isReload to true
                detailNotifier.isReload = true;

                Future.wait([
                  // create one second delay
                  Future.delayed(const Duration(seconds: 1)),

                  // refresh page
                  detailNotifier.refresh(),
                ]).then((_) {
                  // set isReload to true
                  detailNotifier.isReload = false;
                });
              },
        icon: detailNotifier.isReload
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: dividerColor,
                ),
              )
            : const Icon(Icons.refresh_rounded),
        label: detailNotifier.isReload
            ? const Text('Tunggu sebentar...')
            : const Text('Coba lagi'),
      ),
    );
  }
}

class RecipeDetailPageArgs {
  final RecipeEntity recipe;
  final String heroTag;

  RecipeDetailPageArgs(this.recipe, this.heroTag);
}
