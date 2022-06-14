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
import 'package:yess_nutrition/presentation/providers/news_notifiers/get_bookmarks_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_information.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';
import 'package:yess_nutrition/presentation/widgets/news_tile.dart';

class NewsBookmarksPage extends StatefulWidget {
  const NewsBookmarksPage({Key? key}) : super(key: key);

  @override
  State<NewsBookmarksPage> createState() => _NewsBookmarksPageState();
}

class _NewsBookmarksPageState extends State<NewsBookmarksPage> with RouteAware {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<GetBookmarksNotifier>(context, listen: false).getBookmarks();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  @override
  void didPopNext() {
    Provider.of<GetBookmarksNotifier>(context, listen: false).getBookmarks();
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
            color: primaryColor,
            size: 32,
          ),
          tooltip: 'Back',
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.clear_all_rounded,
              color: primaryColor,
              size: 28,
            ),
            tooltip: 'Clear All',
          ),
        ],
      ),
      body: Consumer<GetBookmarksNotifier>(
        builder: (context, bookmarksNotifier, child) {
          if (bookmarksNotifier.state == RequestState.success) {
            if (bookmarksNotifier.bookmarks.isEmpty) {
              return const CustomInformation(
                key: Key('bookmarks_empty'),
                imgPath: 'assets/svg/reading-glasses-cuate.svg',
                title: 'Bookmarks masih kosong',
                subtitle: 'Bookmarks anda akan muncul di sini.',
              );
            }

            return _buildBookmarksList(bookmarksNotifier.bookmarks);
          } else if (bookmarksNotifier.state == RequestState.error) {
            return CustomInformation(
              key: const Key('error_message'),
              imgPath: 'assets/svg/feeling-sorry-cuate.svg',
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
                arguments: NewsDetailPageArgs(news, 'bookmark:${news.url}'),
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
              final bookmarkNotifier = context.read<BookmarkNotifier>();
              final getBookmarksNotifier = context.read<GetBookmarksNotifier>();

              await bookmarkNotifier.deleteBookmark(news);

              final message = bookmarkNotifier.message;
              final snackBar = Utilities.createSnackBar(message);

              scaffoldMessengerKey.currentState!
                ..hideCurrentSnackBar()
                ..showSnackBar(snackBar);

              await getBookmarksNotifier.getBookmarks();
            },
            icon: Icons.bookmark_remove_outlined,
            foregroundColor: primaryTextColor,
            backgroundColor: scaffoldBackgroundColor,
          ),
        ],
      ),
      child: NewsTile(
        news: news,
        heroTag: 'bookmark:${news.url}',
      ),
    );
  }
}
