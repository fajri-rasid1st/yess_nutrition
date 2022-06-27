import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/routes.dart';
import 'package:yess_nutrition/presentation/widgets/nutricheck_card.dart';

class CheckPage extends StatelessWidget {
  final String uid;

  const CheckPage({Key? key, required this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shadowColor: Colors.black.withOpacity(0.5),
        toolbarHeight: 64,
        centerTitle: true,
        title: const Text(
          'NutriCheck',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left_rounded,
            size: 32,
          ),
          tooltip: 'Back',
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: <NutriCheckCard>[
          NutriCheckCard(
            title: 'Food Nutrition Check',
            subtitle: '(Teks)',
            description: 'Eksplorasi kandungan nutrisi makanan maupun minuman.',
            assetName: 'assets/img/food_nutricheck.png',
            onTap: () => Navigator.pushNamed(
              context,
              foodCheckRoute,
              arguments: uid,
            ),
          ),
          NutriCheckCard(
            title: 'Product Nutrition Check',
            subtitle: '(Barcode)',
            description:
                'Analisis kandungan nutrisi produk melalui barcode scan.',
            assetName: 'assets/img/product_nutricheck.png',
            onTap: () => Navigator.pushNamed(
              context,
              productCheckRoute,
              arguments: uid,
            ),
          ),
          NutriCheckCard(
            title: 'Food Recipe Check',
            subtitle: '(Teks)',
            description: 'Yuk cari tahu resep dalam membuat makanan favoritmu.',
            assetName: 'assets/img/recipe_nutricheck.png',
            onTap: () => Navigator.pushNamed(
              context,
              recipeCheckRoute,
              arguments: uid,
            ),
          ),
        ],
      ),
    );
  }
}
