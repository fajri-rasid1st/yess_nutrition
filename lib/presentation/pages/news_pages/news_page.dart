import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/presentation/providers/news_fab_notifier.dart';
import 'package:yess_nutrition/presentation/providers/news_notifiers/get_news_notifier.dart';
import 'package:yess_nutrition/presentation/providers/news_notifiers/search_news_notifier.dart';
import 'package:yess_nutrition/presentation/widgets/custom_information.dart';
import 'package:yess_nutrition/presentation/widgets/loading_indicator.dart';
import 'package:yess_nutrition/presentation/widgets/news_tile.dart';
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
    _scrollController = ScrollController();
    _searchController = TextEditingController();

    Future.microtask(() {
      Provider.of<GetNewsNotifier>(context, listen: false).getNews(page: 1);
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();

    super.dispose();
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
                          onPressed: () {},
                          icon: const Icon(
                            Icons.bookmarks_outlined,
                            color: primaryColor,
                          ),
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
                return _buildErrorInformation(newsNotifier: newsNotifier);
              }
            } else {
              if (searchNotifier.state == RequestState.success) {
                return searchNotifier.results.isEmpty
                    ? _buildSearchedEmptyResult()
                    : _buildSearchedNewsList(searchNotifier);
              } else if (searchNotifier.state == RequestState.error) {
                return _buildErrorInformation(searchNotifier: searchNotifier);
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
          duration: const Duration(milliseconds: 300),
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

  ListView _buildNewsList(GetNewsNotifier newsNotifier) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 64),
      itemCount: newsNotifier.hasMoreData
          ? newsNotifier.news.length + 1
          : newsNotifier.news.length,
      itemBuilder: (context, index) {
        if (index >= newsNotifier.news.length) {
          if (!newsNotifier.isLoading) {
            newsNotifier.getMoreNews();
          }

          return const Padding(
            padding: EdgeInsets.only(top: 24, bottom: 48),
            child: Center(
              child: SpinKitThreeBounce(
                color: secondaryColor,
                size: 30,
              ),
            ),
          );
        }

        return NewsTile(news: newsNotifier.news[index]);
      },
      separatorBuilder: (context, index) => const Divider(height: 1),
    );
  }

  ListView _buildSearchedNewsList(SearchNewsNotifier searchNotifier) {
    return ListView.separated(
      padding: const EdgeInsets.only(bottom: 64),
      itemCount: searchNotifier.hasMoreData
          ? searchNotifier.results.length + 1
          : searchNotifier.results.length,
      itemBuilder: (context, index) {
        if (index >= searchNotifier.results.length) {
          if (!searchNotifier.isLoading) {
            searchNotifier.searchMoreNews();
          }

          return const Padding(
            padding: EdgeInsets.only(top: 24, bottom: 48),
            child: Center(
              child: SpinKitThreeBounce(
                color: secondaryColor,
                size: 30,
              ),
            ),
          );
        }

        return NewsTile(news: searchNotifier.results[index]);
      },
      separatorBuilder: (context, index) => const Divider(height: 1),
    );
  }

  SingleChildScrollView _buildSearchedEmptyResult() {
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

  SingleChildScrollView _buildErrorInformation({
    GetNewsNotifier? newsNotifier,
    SearchNewsNotifier? searchNotifier,
  }) {
    final title =
        newsNotifier != null ? newsNotifier.message : searchNotifier!.message;

    return SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: CustomInformation(
        key: const Key('error_message'),
        imgPath: 'assets/svg/error_robot_cuate.svg',
        title: title,
        subtitle: 'Silahkan coba beberapa saat lagi.',
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
