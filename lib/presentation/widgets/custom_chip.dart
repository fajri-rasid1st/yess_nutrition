import 'package:flutter/material.dart';

class CustomChip extends StatelessWidget {
  final String label;
  final Color labelColor;
  final Color backgroundColor;
  final IconData? icon;
  final Color? iconColor;

  const CustomChip({
    Key? key,
    required this.label,
    required this.labelColor,
    required this.backgroundColor,
    this.icon,
    this.iconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            if (icon != null) ...[
              Icon(
                icon,
                size: 18,
                color: iconColor,
              ),
              const SizedBox(width: 4),
            ],
            Text(
              label,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(color: labelColor),
            ),
          ],
        ),
      ),
    );
  }
}
