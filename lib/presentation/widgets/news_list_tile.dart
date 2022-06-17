import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/domain/entities/news_entity.dart';
import 'package:yess_nutrition/presentation/pages/news_pages/news_detail_page.dart';
import 'package:yess_nutrition/presentation/widgets/custom_network_image.dart';

class NewsListTile extends StatelessWidget {
  final String uid;
  final NewsEntity news;
  final String heroTag;

  const NewsListTile({
    Key? key,
    required this.uid,
    required this.news,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Hero(
                  tag: heroTag,
                  transitionOnUserGestures: true,
                  child: CustomNetworkImage(
                    width: 100,
                    height: 100,
                    placeHolderSize: 50,
                    imgUrl: news.urlToImage,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(left: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        news.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.access_time_rounded,
                            color: secondaryTextColor,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              Utilities.dateFormatToTimeAgo(news.publishedAt),
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: secondaryTextColor),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Row(
                        children: <Widget>[
                          const Icon(
                            Icons.newspaper_rounded,
                            color: secondaryTextColor,
                            size: 14,
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              news.source,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(color: secondaryTextColor),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => Navigator.pushNamed(
                context,
                newsDetailRoute,
                arguments: NewsDetailPageArgs(uid, news, heroTag),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
