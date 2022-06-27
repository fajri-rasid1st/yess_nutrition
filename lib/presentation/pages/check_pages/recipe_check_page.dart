import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/keys.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/domain/entities/recipe_entity.dart';
import 'package:yess_nutrition/presentation/pages/check_pages/recipe_detail_page.dart';
import 'package:yess_nutrition/presentation/providers/recipe_notifiers/recipe_bookmark_notifier.dart';
import 'package:yess_nutrition/presentation/providers/recipe_notifiers/search_recipes_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_information.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';
import 'package:yess_nutrition/presentation/widgets/recipe_list_tile.dart';
import 'package:yess_nutrition/presentation/widgets/search_field.dart';

class RecipeCheckPage extends StatefulWidget {
  final String uid;

  const RecipeCheckPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<RecipeCheckPage> createState() => _RecipeCheckPageState();
}

class _RecipeCheckPageState extends State<RecipeCheckPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: primaryBackgroundColor,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverSafeArea(
                top: false,
                sliver: SliverAppBar(
                  floating: true,
                  snap: true,
                  forceElevated: innerBoxIsScrolled,
                  backgroundColor: secondaryBackgroundColor,
                  shadowColor: Colors.black.withOpacity(0.5),
                  toolbarHeight: 64,
                  centerTitle: true,
                  title: const Text(
                    'Food Recipe Check',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  leading: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.chevron_left_rounded,
                      size: 32,
                    ),
                    tooltip: 'Back',
                  ),
                  actions: <Widget>[
                    IconButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        recipeBookmarksRoute,
                        arguments: widget.uid,
                      ),
                      icon: const Icon(Icons.bookmarks_outlined),
                      tooltip: 'Bookmarks',
                    )
                  ],
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(68),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: _buildSearchField(),
                    ),
                  ),
                ),
              ),
            ),
          ];
        },
        body: Consumer<SearchRecipesNotifier>(
          builder: (context, recipeNotifier, child) {
            final onChangedQuery = recipeNotifier.onChangedQuery;
            final onSubmittedQuery = recipeNotifier.onSubmittedQuery;
            final isOnChangedQueryEmpty = onChangedQuery.isEmpty;
            final isOnSubmittedQueryEmpty = onSubmittedQuery.isEmpty;
            final isTyping = onChangedQuery != onSubmittedQuery;

            if (isOnChangedQueryEmpty || isOnSubmittedQueryEmpty || isTyping) {
              return _buildFirstView();
            }

            if (recipeNotifier.state == RequestState.success) {
              return recipeNotifier.results.isEmpty
                  ? _buildSearchEmpty()
                  : _buildSearchResults(recipeNotifier.results);
            }

            if (recipeNotifier.state == RequestState.error) {
              return _buildSearchError(context, recipeNotifier);
            }

            return const LoadingIndicator();
          },
        ),
      ),
    );
  }

  Consumer<SearchRecipesNotifier> _buildSearchField() {
    return Consumer<SearchRecipesNotifier>(
      builder: (context, recipeNotifier, child) {
        return SearchField(
          controller: _searchController,
          backgroundColor: primaryBackgroundColor,
          query: recipeNotifier.onChangedQuery,
          hintText: 'Cari resep masakan yang anda inginkan...',
          onChanged: (value) {
            recipeNotifier.onChangedQuery = value.trim();
          },
          onSubmitted: (value) {
            if (value.trim().isNotEmpty) {
              recipeNotifier.searchRecipes(query: value);
            }
          },
        );
      },
    );
  }

  SlidableAutoCloseBehavior _buildSearchResults(List<RecipeEntity> recipes) {
    return SlidableAutoCloseBehavior(
      child: ListView.separated(
        padding: const EdgeInsets.all(0),
        itemCount: recipes.length,
        itemBuilder: (context, index) => _buildSlidableListTile(recipes[index]),
        separatorBuilder: (context, index) => const Divider(height: 1),
      ),
    );
  }

  Slidable _buildSlidableListTile(RecipeEntity recipe) {
    final recipeWithUid = recipe.copyWith(uid: widget.uid);

    return Slidable(
      groupTag: 0,
      startActionPane: ActionPane(
        extentRatio: 0.55,
        motion: const ScrollMotion(),
        children: <Widget>[
          SlidableAction(
            onPressed: (context) {
              Navigator.pushNamed(
                context,
                recipeDetailRoute,
                arguments: RecipeDetailPageArgs(
                  recipeWithUid,
                  'recipe:${recipe.recipeId}',
                ),
              );
            },
            icon: Icons.open_in_new_rounded,
            foregroundColor: primaryBackgroundColor,
            backgroundColor: secondaryBackgroundColor,
          ),
          SlidableAction(
            onPressed: (context) async {
              await Share.share('Hai, coba deh cek ini\n\n${recipe.url}');
            },
            icon: Icons.share_rounded,
            foregroundColor: primaryColor,
            backgroundColor: secondaryColor,
          ),
          SlidableAction(
            onPressed: (context) async {
              final bookmarkNotifier = context.read<RecipeBookmarkNotifier>();

              await bookmarkNotifier.getRecipeBookmarkStatus(recipeWithUid);

              final isExist = bookmarkNotifier.isExist;

              if (isExist) {
                const message = 'Sudah ada di daftar bookmarks anda';
                final snackBar = Utilities.createSnackBar(message);

                scaffoldMessengerKey.currentState!
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              } else {
                await bookmarkNotifier.createRecipeBookmark(recipeWithUid);

                final message = bookmarkNotifier.message;
                final snackBar = Utilities.createSnackBar(message);

                scaffoldMessengerKey.currentState!
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              }
            },
            icon: Icons.bookmark_add_outlined,
            foregroundColor: primaryTextColor,
            backgroundColor: scaffoldBackgroundColor,
          ),
        ],
      ),
      child: RecipeListTile(
        recipe: recipeWithUid,
        heroTag: 'recipe:${recipe.recipeId}',
      ),
    );
  }

  CustomInformation _buildFirstView() {
    return const CustomInformation(
      key: Key('first_view'),
      imgPath: 'assets/svg/chef_cuate.svg',
      title: 'Bingung mau masak apa?',
      subtitle: 'Coba cari resep favorit yang sesuai kebutuhan anda.',
    );
  }

  CustomInformation _buildSearchEmpty() {
    return const CustomInformation(
      key: Key('query_not_found'),
      imgPath: 'assets/svg/not_found_cuate.svg',
      title: 'Hasil tidak ditemukan',
      subtitle: 'Coba masukkan kata kunci yang lain.',
    );
  }

  CustomInformation _buildSearchError(
    BuildContext context,
    SearchRecipesNotifier recipesNotifier,
  ) {
    return CustomInformation(
      key: const Key('error_message'),
      imgPath: 'assets/svg/error_robot_cuate.svg',
      title: recipesNotifier.message,
      subtitle: 'Silahkan coba beberapa saat lagi.',
      child: ElevatedButton.icon(
        onPressed: recipesNotifier.isReload
            ? null
            : () {
                recipesNotifier.isReload = true;

                Future.wait([
                  Future.delayed(const Duration(seconds: 1)),
                  recipesNotifier.refresh(),
                ]).then((_) {
                  recipesNotifier.isReload = false;
                });
              },
        icon: recipesNotifier.isReload
            ? const SizedBox(
                width: 18,
                height: 18,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: dividerColor,
                ),
              )
            : const Icon(Icons.refresh_rounded),
        label: recipesNotifier.isReload
            ? const Text('Tunggu sebentar...')
            : const Text('Coba lagi'),
      ),
    );
  }
}
