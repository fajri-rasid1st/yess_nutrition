import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';

class CustomInformation extends StatelessWidget {
  final String imgPath;
  final String title;
  final String subtitle;
  final Widget? child;

  const CustomInformation({
    Key? key,
    required this.imgPath,
    required this.title,
    required this.subtitle,
    this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SvgPicture.asset(
              imgPath,
              width: 240,
              fit: BoxFit.fill,
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(color: secondaryTextColor),
            ),
            const SizedBox(height: 16),
            if (child != null) ...[child!]
          ],
        ),
      ),
    );
  }
}
