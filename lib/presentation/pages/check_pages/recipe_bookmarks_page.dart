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
import 'package:yess_nutrition/presentation/widgets/custom_information.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';
import 'package:yess_nutrition/presentation/widgets/recipe_list_tile.dart';

class RecipeBookmarksPage extends StatefulWidget {
  final String uid;

  const RecipeBookmarksPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<RecipeBookmarksPage> createState() => _RecipeBookmarksPageState();
}

class _RecipeBookmarksPageState extends State<RecipeBookmarksPage>
    with RouteAware {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<RecipeBookmarkNotifier>(context, listen: false)
          .getRecipeBookmarks(widget.uid);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<RecipeBookmarkNotifier>(context, listen: false)
        .getRecipeBookmarks(widget.uid);
  }

  @override
  void dispose() {
    super.dispose();

    routeObserver.unsubscribe(this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBackgroundColor,
      appBar: AppBar(
        backgroundColor: primaryBackgroundColor,
        elevation: 0.8,
        toolbarHeight: 64,
        centerTitle: true,
        title: const Text(
          'Recipe Bookmarks',
          style: TextStyle(
            color: primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 32,
          ),
          color: primaryColor,
          tooltip: 'Back',
        ),
        actions: <Widget>[
          IconButton(
            onPressed: context.watch<RecipeBookmarkNotifier>().bookmarks.isEmpty
                ? null
                : () {
                    Utilities.showConfirmDialog(
                      context,
                      title: 'Konfirmasi',
                      question: 'Hapus semua daftar resep?',
                      onPressedPrimaryAction: () {
                        clearBookmarks(context).then((_) {
                          Navigator.pop(context);
                        });
                      },
                      onPressedSecondaryAction: () => Navigator.pop(context),
                    );
                  },
            icon: const Icon(
              Icons.clear_all_rounded,
              size: 28,
            ),
            color: primaryColor,
            tooltip: 'Clear All',
          ),
        ],
      ),
      body: Consumer<RecipeBookmarkNotifier>(
        builder: (context, bookmarkNotifier, child) {
          if (bookmarkNotifier.state == RequestState.success) {
            if (bookmarkNotifier.bookmarks.isEmpty) {
              return const CustomInformation(
                key: Key('bookmarks_empty'),
                imgPath: 'assets/svg/reading_glasses_cuate.svg',
                title: 'Daftar resep masih kosong',
                subtitle: 'Daftar resep yang disimpan akan muncul di sini.',
              );
            }

            return _buildBookmarksList(bookmarkNotifier.bookmarks);
          } else if (bookmarkNotifier.state == RequestState.error) {
            return CustomInformation(
              key: const Key('error_message'),
              imgPath: 'assets/svg/feeling_sorry_cuate.svg',
              title: bookmarkNotifier.message,
              subtitle: 'Silahkan kembali beberapa saat lagi.',
            );
          }

          return const LoadingIndicator();
        },
      ),
    );
  }

  SlidableAutoCloseBehavior _buildBookmarksList(List<RecipeEntity> recipes) {
    return SlidableAutoCloseBehavior(
      child: ListView.separated(
        itemCount: recipes.length,
        itemBuilder: (context, index) => _buildSlidableListTile(recipes[index]),
        separatorBuilder: (context, index) => const Divider(height: 1),
      ),
    );
  }

  Slidable _buildSlidableListTile(RecipeEntity recipe) {
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
                  recipe,
                  'bookmark:${recipe.recipeId}',
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
              await deleteBookmark(context, recipe);
            },
            icon: Icons.bookmark_remove_outlined,
            foregroundColor: primaryTextColor,
            backgroundColor: scaffoldBackgroundColor,
          ),
        ],
      ),
      child: RecipeListTile(
        recipe: recipe,
        heroTag: 'bookmark:${recipe.recipeId}',
      ),
    );
  }

  Future<void> deleteBookmark(BuildContext context, RecipeEntity recipe) async {
    final bookmarkNotifier = context.read<RecipeBookmarkNotifier>();

    await bookmarkNotifier.deleteRecipeBookmark(recipe);

    final message = bookmarkNotifier.message;
    final snackBar = Utilities.createSnackBar(message);

    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    await bookmarkNotifier.getRecipeBookmarks(widget.uid);
  }

  Future<void> clearBookmarks(BuildContext context) async {
    final bookmarkNotifier = context.read<RecipeBookmarkNotifier>();

    await bookmarkNotifier.clearRecipeBookmarks(widget.uid);

    final message = bookmarkNotifier.message;
    final snackBar = Utilities.createSnackBar(message);

    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    await bookmarkNotifier.getRecipeBookmarks(widget.uid);
  }
}
