import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/common/utils/utilities.dart';
import 'package:yess_nutrition/domain/entities/entities.dart';

class CardNutriNewsHome extends StatelessWidget {
  final NewsEntity news;

  const CardNutriNewsHome({
    Key? key,
    required this.news,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 88,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: primaryBackgroundColor,
            borderRadius: BorderRadius.circular(12),
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
              Hero(
                tag: news.urlToImage,
                transitionOnUserGestures: true,
                child: Container(
                  width: 68,
                  height: 68,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(6)),
                  clipBehavior: Clip.hardEdge,
                  child: Image.network(news.urlToImage, fit: BoxFit.cover),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      news.title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: Theme.of(context).textTheme.subtitle2?.copyWith(
                            color: primaryTextColor,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                MdiIcons.clockOutline,
                                size: 12,
                                color: secondaryTextColor.withOpacity(0.7),
                              ),
                              const SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  Utilities.dateFormatToTimeAgo(
                                      news.publishedAt),
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .overline
                                      ?.copyWith(
                                        fontSize: 12,
                                        color:
                                            secondaryTextColor.withOpacity(0.7),
                                        letterSpacing: 0.25,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                MdiIcons.newspaperVariantOutline,
                                size: 12,
                                color: secondaryTextColor.withOpacity(0.7),
                              ),
                              const SizedBox(width: 2),
                              Expanded(
                                child: Text(
                                  news.source,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .overline
                                      ?.copyWith(
                                        fontSize: 12,
                                        color:
                                            secondaryTextColor.withOpacity(0.7),
                                        letterSpacing: 0.25,
                                      ),
                                ),
                              ),
                            ],
                          ),
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
                arguments: news,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
