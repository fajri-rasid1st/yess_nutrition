import 'package:flutter/material.dart';

class RecipeDetailPage extends StatefulWidget {
  final String uid;
  final String recipeId;
  final String heroTag;

  const RecipeDetailPage({
    Key? key,
    required this.uid,
    required this.recipeId,
    required this.heroTag,
  }) : super(key: key);

  @override
  State<RecipeDetailPage> createState() => _RecipeDetailPageState();
}

class _RecipeDetailPageState extends State<RecipeDetailPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}

class RecipeDetailPageArgs {
  final String uid;
  final String recipeId;
  final String heroTag;

  RecipeDetailPageArgs(this.recipeId, this.heroTag, this.uid);
}
