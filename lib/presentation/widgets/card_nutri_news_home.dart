import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';

class CardNutriNewsHome extends StatelessWidget {
  final String picture;
  final String title;
  final String time;
  final String show;

  const CardNutriNewsHome({
    Key? key,
    required this.picture,
    required this.title,
    required this.time,
    required this.show,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 88,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: primaryBackgroundColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              offset: const Offset(0, 2),
              blurRadius: 4,
              color: const Color(0XFF000000).withOpacity(0.05),
            ),
          ]),
      child: Row(
        children: [
          Container(
            width: 68,
            height: 68,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6)),
            clipBehavior: Clip.hardEdge,
            child: Image.network(picture, fit: BoxFit.cover),
          ),
          const SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                  style: Theme.of(context).textTheme.subtitle2?.copyWith(
                        color: primaryTextColor,
                      ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            MdiIcons.clockOutline,
                            size: 12,
                            color: secondaryTextColor.withOpacity(0.7),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            time,
                            style: Theme.of(context)
                                .textTheme
                                .overline
                                ?.copyWith(
                                  fontSize: 12,
                                  color: secondaryTextColor.withOpacity(0.7),
                                  letterSpacing: 0.25,
                                ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Icon(
                            MdiIcons.eyeOutline,
                            size: 12,
                            color: secondaryTextColor.withOpacity(0.7),
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            show,
                            style: Theme.of(context)
                                .textTheme
                                .overline
                                ?.copyWith(
                                  fontSize: 12,
                                  color: secondaryTextColor.withOpacity(0.7),
                                  letterSpacing: 0.25,
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
    );
  }
}
