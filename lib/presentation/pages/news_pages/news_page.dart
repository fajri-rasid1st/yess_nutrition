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
import 'package:yess_nutrition/presentation/providers/news_notifiers/get_news_notifier.dart';
import 'package:yess_nutrition/presentation/providers/news_notifiers/news_bookmark_notifier.dart';
import 'package:yess_nutrition/presentation/providers/news_notifiers/search_news_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_information.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';
import 'package:yess_nutrition/presentation/widgets/news_list_tile.dart';
import 'package:yess_nutrition/presentation/widgets/search_field.dart';

class NewsPage extends StatefulWidget {
  final String uid;

  const NewsPage({Key? key, required this.uid}) : super(key: key);

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage>
    with AutomaticKeepAliveClientMixin {
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
    super.build(context);

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
              toolbarHeight: 220,
              expandedHeight: 220,
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
                            arguments: widget.uid,
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
                          .displaySmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Cari tahu berita dan artikel kesehatan di sini.',
                      style: Theme.of(context).textTheme.bodyMedium,
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

  SafeArea? _buildFab(NewsFabNotifier fabNotifier) {
    return fabNotifier.isFabVisible
        ? SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
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
                  size: 18,
                ),
                onPressed: () {
                  _scrollController.jumpTo(0);
                  fabNotifier.isFabVisible = false;
                },
              ),
            ),
          )
        : null;
  }

  SearchField _buildSearchField(SearchNewsNotifier searchNotifier) {
    return SearchField(
      controller: _searchController,
      query: searchNotifier.onChangedQuery,
      hintText: 'Cari judul artikel atau berita...',
      onTap: () {
        _scrollController.animateTo(
          0,
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
        );
      },
      onChanged: (value) {
        searchNotifier.onChangedQuery = value.trim();
      },
      onSubmitted: (value) async {
        if (value.trim().isNotEmpty) {
          await searchNotifier.searchNews(page: 1, query: value);
        }
      },
    );
  }

  RefreshIndicator _buildNewsList(GetNewsNotifier newsNotifier) {
    return RefreshIndicator(
      onRefresh: () => newsNotifier.getNews(page: 1, refresh: true),
      child: SlidableAutoCloseBehavior(
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
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
      ),
    );
  }

  RefreshIndicator _buildSearchList(SearchNewsNotifier searchNotifier) {
    return RefreshIndicator(
      onRefresh: () => searchNotifier.searchNews(
        page: 1,
        query: searchNotifier.onSubmittedQuery,
        refresh: true,
      ),
      child: SlidableAutoCloseBehavior(
        child: ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.all(0),
          itemCount: searchNotifier.hasMoreData
              ? searchNotifier.results.length + 1
              : searchNotifier.results.length,
          itemBuilder: (context, index) {
            if (index >= searchNotifier.results.length) {
              if (!searchNotifier.isLoading) {
                searchNotifier.searchMoreNews();
              }

              return _buildBottomLoading();
            }

            return _buildSlidableListTile(searchNotifier.results[index]);
          },
          separatorBuilder: (context, index) => const Divider(height: 1),
        ),
      ),
    );
  }

  Slidable _buildSlidableListTile(NewsEntity news) {
    final newsWithUid = news.copyWith(uid: widget.uid);

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
                arguments: NewsDetailPageArgs(newsWithUid, 'news:${news.url}'),
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
              final bookmarkNotifier = context.read<NewsBookmarkNotifier>();

              await bookmarkNotifier.getNewsBookmarkStatus(newsWithUid);

              final isExist = bookmarkNotifier.isExist;

              if (isExist) {
                const message = 'Sudah ada di daftar bookmarks anda';
                final snackBar = Utilities.createSnackBar(message);

                scaffoldMessengerKey.currentState!
                  ..hideCurrentSnackBar()
                  ..showSnackBar(snackBar);
              } else {
                await bookmarkNotifier.createNewsBookmark(newsWithUid);

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
        news: newsWithUid,
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
                    newsNotifier.getNews(page: 1, refresh: true),
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

  SingleChildScrollView _buildSearchError(SearchNewsNotifier searchNotifier) {
    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: CustomInformation(
        key: const Key('error_message'),
        imgPath: 'assets/svg/error_robot_cuate.svg',
        title: searchNotifier.message,
        subtitle: 'Silahkan coba beberapa saat lagi.',
        child: ElevatedButton.icon(
          onPressed: searchNotifier.isReload
              ? null
              : () {
                  searchNotifier.isReload = true;

                  Future.wait([
                    Future.delayed(const Duration(seconds: 1)),
                    searchNotifier.searchNews(
                      page: 1,
                      query: searchNotifier.onSubmittedQuery,
                      refresh: true,
                    ),
                  ]).then((_) {
                    searchNotifier.isReload = false;
                  });
                },
          icon: searchNotifier.isReload
              ? const SizedBox(
                  width: 18,
                  height: 18,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: dividerColor,
                  ),
                )
              : const Icon(Icons.refresh_rounded),
          label: searchNotifier.isReload
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

  @override
  bool get wantKeepAlive => true;
}
