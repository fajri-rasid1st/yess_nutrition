import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/domain/entities/entities.dart';
import 'package:yess_nutrition/presentation/pages/news_pages/news_detail_page.dart';
import 'package:yess_nutrition/presentation/widgets/widgets.dart';

class NutriNewsHomeCard extends StatelessWidget {
  final NewsEntity news;
  final String heroTag;

  const NutriNewsHomeCard({
    Key? key,
    required this.news,
    required this.heroTag,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Stack(
        children: <Widget>[
          Container(
            height: 88,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: primaryBackgroundColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                  color: Colors.black.withOpacity(0.05),
                ),
              ],
            ),
            child: Row(
              children: <Widget>[
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Hero(
                    tag: heroTag,
                    child: CustomNetworkImage(
                      width: 68,
                      height: 68,
                      fit: BoxFit.cover,
                      imgUrl: news.urlToImage,
                      placeHolderSize: 34,
                      errorIcon: Icons.motion_photos_off_outlined,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        news.title,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: primaryTextColor),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          _buildSubtitleWithIcon(
                            context,
                            MdiIcons.clockOutline,
                            Utilities.dateTimeToTimeAgo(news.publishedAt),
                          ),
                          _buildSubtitleWithIcon(
                            context,
                            MdiIcons.newspaperVariantOutline,
                            news.source,
                          ),
                        ],
                      ),
                    ],
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
                  arguments: NewsDetailPageArgs(news, heroTag),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Expanded _buildSubtitleWithIcon(
    BuildContext context,
    IconData icon,
    String label,
  ) {
    return Expanded(
      child: Row(
        children: <Widget>[
          Icon(
            icon,
            size: 12,
            color: secondaryTextColor,
          ),
          const SizedBox(width: 2),
          Expanded(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: secondaryTextColor,
                    letterSpacing: 0.25,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
