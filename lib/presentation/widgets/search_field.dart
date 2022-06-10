import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';

class SearchField extends StatelessWidget {
  final TextEditingController? controller;
  final String query;
  final String hintText;
  final ValueChanged<String>? onChanged;

  const SearchField({
    Key? key,
    this.controller,
    required this.query,
    required this.hintText,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.search,
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
                  onPressed: () => controller?.clear(),
                ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
