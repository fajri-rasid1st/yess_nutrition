import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final Color backgroundColor;
  final String query;
  final String hintText;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final ValueSetter<String>? onSubmitted;

  const SearchField({
    Key? key,
    this.controller,
    this.backgroundColor = secondaryColor,
    required this.query,
    required this.hintText,
    this.onTap,
    this.onChanged,
    this.onSubmitted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
        textCapitalization: TextCapitalization.words,
        decoration: InputDecoration(
          border: InputBorder.none,
          contentPadding: const EdgeInsets.only(top: 14),
          floatingLabelBehavior: FloatingLabelBehavior.never,
          hintText: hintText,
          prefixIcon: const Icon(Icons.search_rounded),
          suffixIcon: query.isEmpty
              ? const SizedBox()
              : IconButton(
                  icon: const Icon(Icons.close_rounded),
                  color: primaryTextColor,
                  onPressed: () {
                    controller?.clear();

                    if (onChanged != null) onChanged!('');
                  },
                ),
        ),
        onTap: onTap,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
      ),
    );
  }
}
