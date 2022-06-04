import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';

class ClickableText extends StatelessWidget {
  final VoidCallback onTap;
  final String text;

  const ClickableText({
    Key? key,
    required this.onTap,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
