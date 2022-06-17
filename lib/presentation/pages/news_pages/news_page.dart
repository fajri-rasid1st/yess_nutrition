import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/common/utils/keys.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/presentation/pages/news_pages/news_detail_page.dart';
import 'package:yess_nutrition/presentation/providers/common_notifiers/news_fab_notifier.dart';
import 'package:yess_nutrition/presentation/providers/news_notifiers/bookmark_notifier.dart';
import 'package:yess_nutrition/presentation/providers/news_notifiers/get_news_notifier.dart';
import 'package:yess_nutrition/presentation/providers/news_notifiers/search_news_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_information.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';
import 'package:yess_nutrition/presentation/widgets/news_list_tile.dart';
import 'package:yess_nutrition/presentation/widgets/search_field.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key? key}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  late final ScrollController _scrollController;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      Provider.of<GetNewsNotifier>(context, listen: false).getNews(page: 1);
    });

    _scrollController = ScrollController();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.dispose();
    _searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<NewsFabNotifier, GetNewsNotifier, SearchNewsNotifier>(
      builder: (context, fabNotifier, newsNotifier, searchNotifier, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: primaryBackgroundColor,
          body: _buildBody(fabNotifier, newsNotifier, searchNotifier),
          floatingActionButton: _buildFab(fabNotifier),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        );
      },
    );
  }

  NotificationListener _buildBody(
    NewsFabNotifier fabNotifier,
    GetNewsNotifier newsNotifier,
    SearchNewsNotifier searchNotifier,
  ) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        return onScrollNotification(notification, fabNotifier);
      },
      child: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: primaryBackgroundColor,
              toolbarHeight: 230,
              expandedHeight: 230,
              actions: <Widget>[
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Container(
                        decoration: BoxDecoration(
                          color: secondaryColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: IconButton(
                          onPressed: () => Navigator.pushNamed(
                            context,
                            newsBookmarksRoute,
                          ),
                          icon: const Icon(Icons.bookmarks_outlined),
                          color: primaryColor,
                          tooltip: 'Bookmarks',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                expandedTitleScale: 1,
                titlePadding: const EdgeInsets.symmetric(horizontal: 16),
                title: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'NutriNews',
                      style: Theme.of(context)
                          .textTheme
                          .headline3!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Cari tahu berita dan artikel kesehatan di sini.',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: _buildSearchField(searchNotifier),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Builder(
          builder: (context) {
            final onChangedQuery = searchNotifier.onChangedQuery;
            final onSubmittedQuery = searchNotifier.onSubmittedQuery;

            final isOnChangedQueryEmpty = onChangedQuery.isEmpty;
            final isOnSubmittedQueryEmpty = onSubmittedQuery.isEmpty;

            final isTyping = onChangedQuery != onSubmittedQuery;

            if (isOnChangedQueryEmpty || isOnSubmittedQueryEmpty || isTyping) {
              if (newsNotifier.state == RequestState.success) {
                return _buildNewsList(newsNotifier);
              } else if (newsNotifier.state == RequestState.error) {
                return _buildNewsError(newsNotifier);
              }
            } else {
              if (searchNotifier.state == RequestState.success) {
                return searchNotifier.results.isEmpty
                    ? _buildSearchEmpty()
                    : _buildSearchList(searchNotifier);
              } else if (searchNotifier.state == RequestState.error) {
                return _buildSearchError(searchNotifier);
              }
            }

            return const LoadingIndicator();
          },
        ),
      ),
    );
  }

  Padding? _buildFab(NewsFabNotifier fabNotifier) {
    return fabNotifier.isFabVisible
        ? Padding(
            padding: const EdgeInsets.only(top: 32),
            child: FloatingActionButton.extended(
              elevation: 2,
              highlightElevation: 4,
              backgroundColor: scaffoldBackgroundColor,
              label: const Text(
                'Kembali ke atas',
                style: TextStyle(fontSize: 12),
              ),
              icon: const Icon(
                Icons.arrow_upward_rounded,
                size: 20,
              ),
              onPressed: () {
                _scrollController.jumpTo(0);
                fabNotifier.isFabVisible = false;
              },
            ),
          )
        : null;
  }

  SearchField _buildSearchField(SearchNewsNotifier newsNotifier) {
    return SearchField(
      controller: _searchController,
      query: newsNotifier.onChangedQuery,
      hintText: 'Cari judul artikel atau berita...',
      onTap: () {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      },
      onChanged: (value) {
        newsNotifier.onChangedQuery = value.trim();
      },
      onSubmitted: (value) {
        if (value.trim().isNotEmpty) {
          newsNotifier.searchNews(page: 1, query: value);
        }
      },
    );
  }

  SlidableAutoCloseBehavior _buildNewsList(GetNewsNotifier newsNotifier) {
    return SlidableAutoCloseBehavior(
      child: ListView.separated(
        itemCount: newsNotifier.hasMoreData
            ? newsNotifier.news.length + 1
            : newsNotifier.news.length,
        itemBuilder: (context, index) {
          if (index >= newsNotifier.news.length) {
            if (!newsNotifier.isLoading) {
              newsNotifier.getMoreNews();
            }

            return _buildBottomLoading();
          }

          return _buildSlidableListTile(newsNotifier.news[index]);
        },
        separatorBuilder: (context, index) => const Divider(height: 1),
      ),
    );
  }

  SlidableAutoCloseBehavior _buildSearchList(SearchNewsNotifier newsNotifier) {
    return SlidableAutoCloseBehavior(
      child: ListView.separated(
        itemCount: newsNotifier.hasMoreData
            ? newsNotifier.results.length + 1
            : newsNotifier.results.length,
        itemBuilder: (context, index) {
          if (index >= newsNotifier.results.length) {
            if (!newsNotifier.isLoading) {
              newsNotifier.searchMoreNews();
            }

            return _buildBottomLoading();
          }

          return _buildSlidableListTile(newsNotifier.results[index]);
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
                arguments: NewsDetailPageArgs(news, 'news:${news.url}'),
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

              await bookmarkNotifier.getBookmarkStatus(news);

              final isExist = bookmarkNotifier.isExist;

              if (isExist) {
                const message = 'Sudah ada di daftar bookmarks anda';
                final snackBar = Utilities.createSnackBar(message);

                scaffoldMessengerKey.currentState!
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              } else {
                await bookmarkNotifier.createBookmark(news);

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
      child: NewsListTile(
        news: news,
        heroTag: 'news:${news.url}',
      ),
    );
  }

  Padding _buildBottomLoading() {
    return const Padding(
      padding: EdgeInsets.only(top: 12, bottom: 40),
      child: Center(
        child: SpinKitThreeBounce(
          color: secondaryColor,
          size: 30,
        ),
      ),
    );
  }

  SingleChildScrollView _buildNewsError(GetNewsNotifier newsNotifier) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: CustomInformation(
        key: const Key('error_message'),
        imgPath: 'assets/svg/error_robot_cuate.svg',
        title: newsNotifier.message,
        subtitle: 'Silahkan coba beberapa saat lagi.',
        child: ElevatedButton.icon(
          onPressed: newsNotifier.isReload
              ? null
              : () {
                  newsNotifier.isReload = true;

                  Future.wait([
                    Future.delayed(const Duration(seconds: 1)),
                    newsNotifier.refresh(),
                  ]).then((_) {
                    newsNotifier.isReload = false;
                  });
                },
          icon: newsNotifier.isReload
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: dividerColor,
                  ),
                )
              : const Icon(Icons.refresh_rounded),
          label: newsNotifier.isReload
              ? const Text('Tunggu sebentar...')
              : const Text('Coba lagi'),
        ),
      ),
    );
  }

  SingleChildScrollView _buildSearchError(SearchNewsNotifier newsNotifier) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: CustomInformation(
        key: const Key('error_message'),
        imgPath: 'assets/svg/error_robot_cuate.svg',
        title: newsNotifier.message,
        subtitle: 'Silahkan coba beberapa saat lagi.',
        child: ElevatedButton.icon(
          onPressed: newsNotifier.isReload
              ? null
              : () {
                  newsNotifier.isReload = true;

                  Future.wait([
                    Future.delayed(const Duration(seconds: 1)),
                    newsNotifier.refresh(),
                  ]).then((_) {
                    newsNotifier.isReload = false;
                  });
                },
          icon: newsNotifier.isReload
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: dividerColor,
                  ),
                )
              : const Icon(Icons.refresh_rounded),
          label: newsNotifier.isReload
              ? const Text('Tunggu sebentar...')
              : const Text('Coba lagi'),
        ),
      ),
    );
  }

  SingleChildScrollView _buildSearchEmpty() {
    return const SingleChildScrollView(
      physics: NeverScrollableScrollPhysics(),
      child: CustomInformation(
        key: Key('query_not_found'),
        imgPath: 'assets/svg/not_found_cuate.svg',
        title: 'Hasil tidak ditemukan',
        subtitle: 'Coba masukkan kata kunci yang lain.',
      ),
    );
  }

  bool onScrollNotification(
    UserScrollNotification notification,
    NewsFabNotifier fabNotifier,
  ) {
    // get the scroll position in pixel
    final scrollPosition = _scrollController.position.pixels;

    // if scroll position bigger than 246
    // (246 refers to toolbar height + margin bottom of search field)
    if (scrollPosition > 246) {
      // if user scroll to top,...
      if (notification.direction == ScrollDirection.forward) {
        // check if fab is visible, ...
        if (!fabNotifier.isFabVisible) {
          // show the fab.
          fabNotifier.isFabVisible = true;
        }
      }
    } else {
      // if scroll position less than 246, check if fab is visible...
      if (fabNotifier.isFabVisible) {
        // remove the fab.
        fabNotifier.isFabVisible = false;
      }
    }

    // if user scroll to bottom, always remove the fab.
    if (notification.direction == ScrollDirection.reverse) {
      if (fabNotifier.isFabVisible) {
        fabNotifier.isFabVisible = false;
      }
    }

    return true;
  }
}
