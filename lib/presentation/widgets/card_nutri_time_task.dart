import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';

class CardNutriTimeTask extends StatelessWidget {
  const CardNutriTimeTask({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Container(
          width: 66,
          height: 66,
          margin: const EdgeInsets.only(right: 12),
          decoration: const BoxDecoration(
            color: scaffoldBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(8)),
          ),
          child: const Icon(
            MdiIcons.cupWater,
            color: secondaryBackgroundColor,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              children: <Widget>[
                const Icon(
                  MdiIcons.clockOutline,
                  size: 12,
                  color: secondaryTextColor,
                ),
                const SizedBox(width: 2),
                Text(
                  "06:30 Wita",
                  style: Theme.of(context).textTheme.overline?.copyWith(
                        color: secondaryTextColor,
                        letterSpacing: 0.5,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Text(
              "Minum Air",
              style: Theme.of(context)
                  .textTheme
                  .subtitle1
                  ?.copyWith(color: primaryTextColor),
            ),
            const SizedBox(height: 4),
            Text(
              "200 ml",
              style: Theme.of(context).textTheme.caption?.copyWith(
                    color: primaryColor,
                  ),
            ),
          ],
        ),
        const Spacer(),
        InkWell(
          onTap: () {},
          child: Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              MdiIcons.check,
              size: 24,
              color: primaryColor,
            ),
          ),
        ),
        const SizedBox(width: 10)
      ],
    );
  }
}
