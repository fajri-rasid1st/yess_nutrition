import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/keys.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/presentation/providers/news_notifiers/bookmark_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_network_image.dart';

class NewsDetailPage extends StatefulWidget {
  final NewsEntity news;
  final String heroTag;

  const NewsDetailPage({
    Key? key,
    required this.news,
    required this.heroTag,
  }) : super(key: key);

  @override
  State<NewsDetailPage> createState() => _NewsDetailPageState();
}

class _NewsDetailPageState extends State<NewsDetailPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<BookmarkNotifier>(context, listen: false)
          .getBookmarkStatus(widget.news);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
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
            onPressed: () async {
              await Share.share('Hai, coba deh cek ini\n\n${widget.news.url}');
            },
            icon: const Icon(
              Icons.share_rounded,
              size: 22,
            ),
            tooltip: 'Share',
          ),
          Consumer<BookmarkNotifier>(
            builder: (context, bookmarkNotifier, child) {
              final isExist = bookmarkNotifier.isExist;

              return IconButton(
                onPressed: () async {
                  if (isExist) {
                    await bookmarkNotifier.deleteBookmark(widget.news);
                  } else {
                    await bookmarkNotifier.createBookmark(widget.news);
                  }

                  final message = bookmarkNotifier.message;
                  final snackBar = Utilities.createSnackBar(message);

                  scaffoldMessengerKey.currentState!
                    ..hideCurrentSnackBar()
                    ..showSnackBar(snackBar);
                },
                icon: Icon(
                  isExist
                      ? Icons.bookmark_rounded
                      : Icons.bookmark_border_rounded,
                  size: 26,
                ),
                tooltip: 'Bookmarks',
              );
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Stack(
            alignment: AlignmentDirectional.bottomStart,
            children: <Widget>[
              Hero(
                tag: widget.heroTag,
                child: CustomNetworkImage(
                  height: MediaQuery.of(context).size.height / 2 + 24,
                  fit: BoxFit.fitHeight,
                  imgUrl: widget.news.urlToImage,
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
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      widget.news.title,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                            color: primaryBackgroundColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: <Widget>[
                        _buildChip(
                          context,
                          Icons.person_rounded,
                          widget.news.author,
                        ),
                        _buildChip(
                          context,
                          Icons.access_time_rounded,
                          Utilities.dateFormatToMMMddy(widget.news.publishedAt),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            height: MediaQuery.of(context).size.height / 2 - 24,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
              color: primaryBackgroundColor,
            ),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                    child: Text(
                      widget.news.source,
                      style: Theme.of(context)
                          .textTheme
                          .headline6!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      widget.news.description,
                      style: const TextStyle(color: secondaryTextColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    child: Text(
                      widget.news.content,
                      style: const TextStyle(color: secondaryTextColor),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                    child: SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: () => Navigator.pushNamed(
                          context,
                          newsWebViewRoute,
                          arguments: widget.news.url,
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
        ],
      ),
    );
  }

  Container _buildChip(BuildContext context, IconData icon, String label) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor.withOpacity(0.5),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(
              icon,
              size: 18,
              color: primaryBackgroundColor,
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .caption!
                  .copyWith(color: primaryBackgroundColor),
            ),
          ],
        ),
      ),
    );
  }
}

class NewsDetailPageArgs {
  final NewsEntity news;
  final String heroTag;

  NewsDetailPageArgs(this.news, this.heroTag);
}
