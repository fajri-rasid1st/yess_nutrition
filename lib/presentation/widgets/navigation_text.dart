import 'package:flutter/material.dart';

import '../../common/styles/color_scheme.dart';

class NavigationText extends StatelessWidget {
  final String routeName;
  final String text;

  const NavigationText({
    Key? key,
    required this.routeName,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(context, routeName),
      child: Text(
        text,
        style: const TextStyle(
          color: primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
