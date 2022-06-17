import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/keys.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/presentation/pages/news_pages/news_detail_page.dart';
import 'package:yess_nutrition/presentation/providers/news_notifiers/bookmark_notifier.dart';
import 'package:yess_nutrition/presentation/providers/news_notifiers/bookmarks_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_information.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';
import 'package:yess_nutrition/presentation/widgets/news_list_tile.dart';

class NewsBookmarksPage extends StatefulWidget {
  final String uid;

  const NewsBookmarksPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<NewsBookmarksPage> createState() => _NewsBookmarksPageState();
}

class _NewsBookmarksPageState extends State<NewsBookmarksPage> with RouteAware {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<BookmarksNotifier>(context, listen: false)
          .getBookmarks(widget.uid);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<BookmarksNotifier>(context, listen: false)
        .getBookmarks(widget.uid);
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
          'Bookmarks',
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
            onPressed: context.watch<BookmarksNotifier>().bookmarks.isEmpty
                ? null
                : () => showConfirmDialog(context),
            icon: const Icon(
              Icons.clear_all_rounded,
              size: 28,
            ),
            color: primaryColor,
            tooltip: 'Clear All',
          ),
        ],
      ),
      body: Consumer<BookmarksNotifier>(
        builder: (context, bookmarksNotifier, child) {
          if (bookmarksNotifier.state == RequestState.success) {
            if (bookmarksNotifier.bookmarks.isEmpty) {
              return const CustomInformation(
                key: Key('bookmarks_empty'),
                imgPath: 'assets/svg/reading_glasses_cuate.svg',
                title: 'Bookmarks masih kosong',
                subtitle: 'Bookmarks anda akan muncul di sini.',
              );
            }

            return _buildBookmarksList(bookmarksNotifier.bookmarks);
          } else if (bookmarksNotifier.state == RequestState.error) {
            return CustomInformation(
              key: const Key('error_message'),
              imgPath: 'assets/svg/feeling_sorry_cuate.svg',
              title: bookmarksNotifier.message,
              subtitle: 'Silahkan kembali beberapa saat lagi.',
            );
          }

          return const LoadingIndicator();
        },
      ),
    );
  }

  SlidableAutoCloseBehavior _buildBookmarksList(List<NewsEntity> bookmarks) {
    return SlidableAutoCloseBehavior(
      child: ListView.separated(
        itemCount: bookmarks.length,
        itemBuilder: (context, index) {
          return _buildSlidableListTile(bookmarks[index]);
        },
        separatorBuilder: (context, index) => const Divider(height: 1),
      ),
    );
  }

  Slidable _buildSlidableListTile(NewsEntity news) {
    return Slidable(
      groupTag: 0,
      startActionPane: ActionPane(
        extentRatio: 0.6,
        motion: const ScrollMotion(),
        children: <Widget>[
          SlidableAction(
            onPressed: (context) {
              Navigator.pushNamed(
                context,
                newsDetailRoute,
                arguments: NewsDetailPageArgs(
                  widget.uid,
                  news,
                  'bookmark:${news.url}',
                ),
              );
            },
            icon: Icons.open_in_new_rounded,
            foregroundColor: primaryBackgroundColor,
            backgroundColor: secondaryBackgroundColor,
          ),
          SlidableAction(
            onPressed: (context) async {
              await Share.share('Hai, coba deh cek ini\n\n${news.url}');
            },
            icon: Icons.share_rounded,
            foregroundColor: primaryColor,
            backgroundColor: secondaryColor,
          ),
          SlidableAction(
            onPressed: (context) async {
              await deleteBookmark(context, news);
            },
            icon: Icons.bookmark_remove_outlined,
            foregroundColor: primaryTextColor,
            backgroundColor: scaffoldBackgroundColor,
          ),
        ],
      ),
      child: NewsListTile(
        uid: widget.uid,
        news: news,
        heroTag: 'bookmark:${news.url}',
      ),
    );
  }

  Future<void> showConfirmDialog(BuildContext context) async {
    showGeneralDialog(
      context: context,
      barrierLabel: '',
      barrierDismissible: true,
      transitionBuilder: (context, animStart, animEnd, child) {
        final curvedValue = Curves.ease.transform(animStart.value) - 3.75;

        return Transform(
          transform: Matrix4.translationValues(0, (curvedValue * -100), 0),
          child: Opacity(
            opacity: animStart.value,
            child: Dialog(
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Konfirmasi',
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .subtitle1!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Hapus semua daftar bookmarks?',
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        TextButton(
                          onPressed: () async {
                            await clearBookmarks(context);

                            navigatorKey.currentState!.pop();
                          },
                          child: const Text(
                            'Oke',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                          child: VerticalDivider(
                            width: 1,
                            thickness: 1,
                          ),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text(
                            'Batal',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 250),
      pageBuilder: (context, animStart, animEnd) => const SizedBox(),
    );
  }

  Future<void> deleteBookmark(BuildContext context, NewsEntity news) async {
    final bookmarkNotifier = context.read<BookmarkNotifier>();
    final bookmarksNotifier = context.read<BookmarksNotifier>();

    await bookmarkNotifier.deleteBookmark(widget.uid, news);

    final message = bookmarkNotifier.message;
    final snackBar = Utilities.createSnackBar(message);

    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    await bookmarksNotifier.getBookmarks(widget.uid);
  }

  Future<void> clearBookmarks(BuildContext context) async {
    final bookmarksNotifier = context.read<BookmarksNotifier>();

    await bookmarksNotifier.clearBookmarks(widget.uid);

    final message = bookmarksNotifier.message;
    final snackBar = Utilities.createSnackBar(message);

    scaffoldMessengerKey.currentState!
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);

    await bookmarksNotifier.getBookmarks(widget.uid);
  }
}
