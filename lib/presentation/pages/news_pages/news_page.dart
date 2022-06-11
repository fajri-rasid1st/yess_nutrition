import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/enum_state.dart';
import 'package:yess_nutrition/presentation/providers/news_fab_notifier.dart';
import 'package:yess_nutrition/presentation/providers/news_notifiers/get_news_notifier.dart';
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
    return Consumer<NewsFabNotifier>(
      builder: (context, fabProvider, child) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: primaryBackgroundColor,
          body: _buildBody(fabProvider),
          floatingActionButton: _buildFab(fabProvider),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        );
      },
    );
  }

  NotificationListener _buildBody(NewsFabNotifier fabProvider) {
    return NotificationListener<UserScrollNotification>(
      onNotification: (notification) {
        return onScrollNotification(notification, fabProvider);
      },
      child: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              backgroundColor: primaryBackgroundColor,
              toolbarHeight: 240,
              expandedHeight: 240,
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
                      child: SearchField(
                        controller: _searchController,
                        query: '',
                        hintText: 'Cari judul artikel atau berita...',
                        onTap: () {
                          _scrollController.animateTo(
                            0,
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOut,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ];
        },
        body: Consumer<GetNewsNotifier>(
          builder: (context, newsProvider, child) {
            if (newsProvider.state == RequestState.loading) {
              return const LoadingIndicator();
            } else if (newsProvider.state == RequestState.success) {
              return _buildNewsList(newsProvider);
            }

            return SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: CustomInformation(
                key: const Key('error_message'),
                imgPath: 'assets/svg/error_robot_cuate.svg',
                title: newsProvider.message,
                subtitle: 'Silahkan coba beberapa saat lagi.',
              ),
            );
          },
        ),
      ),
    );
  }

  Padding? _buildFab(NewsFabNotifier fabProvider) {
    return fabProvider.isFabVisible
        ? Padding(
            padding: const EdgeInsets.all(16),
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
                _scrollController.animateTo(
                  0,
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.easeOut,
                );

                fabProvider.isFabVisible = false;
              },
            ),
          )
        : null;
  }

  ListView _buildNewsList(GetNewsNotifier newsNotifier) {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      itemCount: newsNotifier.hasMoreData
          ? newsNotifier.news.length + 1
          : newsNotifier.news.length,
      itemBuilder: (context, index) {
        if (index >= newsNotifier.news.length) {
          if (!newsNotifier.isLoading) {
            newsNotifier.getMoreNews();
          }

          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
              child: SpinKitThreeBounce(
                color: secondaryColor,
                size: 24,
              ),
            ),
          );
        }

        return NewsTile(news: newsNotifier.news[index]);
      },
      separatorBuilder: (context, index) => const Divider(height: 1),
    );
  }

  bool onScrollNotification(
    UserScrollNotification notification,
    NewsFabNotifier fabProvider,
  ) {
    // get the scroll position in pixel
    final scrollPosition = _scrollController.position.pixels;

    // if scroll position bigger than 256
    // (256 refers to toolbar height + margin bottom of search field)
    if (scrollPosition > 256) {
      // if user scroll to top,...
      if (notification.direction == ScrollDirection.forward) {
        // check if fab is visible, ...
        if (!fabProvider.isFabVisible) {
          // show the fab.
          fabProvider.isFabVisible = true;
        }
      }
    } else {
      // if scroll position less than 256, check if fab is visible...
      if (fabProvider.isFabVisible) {
        // remove the fab.
        fabProvider.isFabVisible = false;
      }
    }

    // if user scroll to bottom, always remove the fab.
    if (notification.direction == ScrollDirection.reverse) {
      if (fabProvider.isFabVisible) {
        fabProvider.isFabVisible = false;
      }
    }

    return true;
  }
}
