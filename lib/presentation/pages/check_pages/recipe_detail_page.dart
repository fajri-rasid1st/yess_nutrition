import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/keys.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
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

      Provider.of<RecipeBookmarkNotifier>(context, listen: false)
          .getRecipeBookmarkStatus(widget.recipe);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Consumer<GetRecipeDetailNotifier>(
        builder: (context, detailNotifier, child) {
          if (detailNotifier.state == RequestState.success) {
            return _buildDetailPage(context, detailNotifier.recipe);
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

  NestedScrollView _buildDetailPage(
    BuildContext context,
    RecipeDetailEntity recipeDetail,
  ) {
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
              _buildShareIconAction(recipeDetail.url),
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
                          colors: [Colors.black, Colors.black26],
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
      body: _buildBody(context, recipeDetail),
    );
  }

  IconButton _buildShareIconAction(String url) {
    return IconButton(
      onPressed: () async {
        await Share.share('Hai, coba deh cek ini\n\n$url');
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
          tooltip: 'Save',
        );
      },
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
          const SizedBox(height: 8),
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

  ClipRRect _buildBody(BuildContext context, RecipeDetailEntity recipeDetail) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: Container(
        color: primaryBackgroundColor,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 16),
                child: Text(
                  'Kandungan Nutrisi',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    _buildNutrientDetailLarge(
                      context,
                      '${recipeDetail.calories.toStringAsFixed(0)}Kkal',
                      'Total Kalori',
                    ),
                    const SizedBox(
                      height: 56,
                      child: VerticalDivider(),
                    ),
                    _buildNutrientDetailLarge(
                      context,
                      '${recipeDetail.totalNutrients.carbohydrate.toStringAsFixed(0)}g',
                      'Karbohidrat',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 20, 16, 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: primaryBackgroundColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.black.withOpacity(0.08),
                        blurRadius: 8,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Column>[
                        _buildNutrientDetailSmall(
                          context,
                          '${recipeDetail.totalNutrients.protein.toStringAsFixed(0)}g',
                          'Protein',
                        ),
                        _buildNutrientDetailSmall(
                          context,
                          '${recipeDetail.totalNutrients.fat.toStringAsFixed(0)}g',
                          'Lemak',
                        ),
                        _buildNutrientDetailSmall(
                          context,
                          '${recipeDetail.totalNutrients.fiber.toStringAsFixed(0)}g',
                          'Serat',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buildLabelsSection(
                context,
                recipeDetail.healthLabels,
                'Kategori kesehatan',
                primaryColor,
                primaryColor,
                secondaryColor,
              ),
              _buildLabelsSection(
                context,
                recipeDetail.dietLabels,
                'Kategori diet',
                const Color(0XFF89BD16),
                const Color(0XFF89BD16),
                const Color(0XFF89BD16).withOpacity(0.2),
              ),
              _buildLabelsSection(
                context,
                recipeDetail.cautionLabels,
                'Kategori penyakit/alergi',
                errorColor,
                errorColor,
                errorColor.withOpacity(0.2),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8),
                child: Divider(
                  height: 8,
                  thickness: 8,
                  color: scaffoldBackgroundColor,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text(
                  'Bahan-bahan',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              ListView(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                children: List<Padding>.generate(
                  recipeDetail.ingredients.length,
                  (index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text('- ${recipeDetail.ingredients[index]}'),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Text(
                  'Cara Pembuatan',
                  style: Theme.of(context)
                      .textTheme
                      .headline6!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                child: SizedBox(
                  width: double.infinity,
                  child: OutlinedButton.icon(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      webviewRoute,
                      arguments: recipeDetail.url,
                    ),
                    icon: const Icon(Icons.open_in_new_rounded),
                    label: const Text('Lihat Selengkapnya'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Column _buildNutrientDetailLarge(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return Column(
      children: <Text>[
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline5!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }

  Column _buildNutrientDetailSmall(
    BuildContext context,
    String title,
    String subtitle,
  ) {
    return Column(
      children: <Text>[
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodyText2,
        ),
      ],
    );
  }

  Padding _buildLabelsSection(
    BuildContext context,
    List labels,
    String title,
    Color titleColor,
    Color chipLabelColor,
    Color chipBackgroundColor,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: Theme.of(context).textTheme.subtitle1!.copyWith(
                  color: titleColor,
                  fontWeight: FontWeight.bold,
                ),
          ),
          const SizedBox(height: 8),
          if (labels.isEmpty) ...[
            CustomChip(
              label: 'Tidak ada',
              labelColor: chipLabelColor,
              backgroundColor: chipBackgroundColor,
            ),
          ] else ...[
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: List<CustomChip>.generate(
                labels.length,
                (index) {
                  return CustomChip(
                    label: labels[index],
                    labelColor: chipLabelColor,
                    backgroundColor: chipBackgroundColor,
                  );
                },
              ),
            ),
          ]
        ],
      ),
    );
  }

  Container _buildDetailError(GetRecipeDetailNotifier detailNotifier) {
    return Container(
      color: primaryBackgroundColor,
      child: CustomInformation(
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
      ),
    );
  }
}

class RecipeDetailPageArgs {
  final RecipeEntity recipe;
  final String heroTag;

  RecipeDetailPageArgs(this.recipe, this.heroTag);
}
