import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/routes.dart';

class CheckPage extends StatelessWidget {
  const CheckPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
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
        children: <Card>[
          _buildCard(
            context: context,
            title: 'Food Nutrition Check',
            subtitle: '(Teks)',
            description:
                'Mulailah mengeksplorasi kandungan nutrisi makanan atau minuman.',
            assetName: 'assets/img/food_nutricheck.png',
            onTap: () => Navigator.pushNamed(context, foodCheckRoute),
          ),
          _buildCard(
            context: context,
            title: 'Product Nutrition Check',
            subtitle: '(Barcode)',
            description:
                'Analisis kandungan nutrisi dari produk dengan fitur barcode scan.',
            assetName: 'assets/img/product_nutricheck.png',
            onTap: () {},
          ),
          _buildCard(
            context: context,
            title: 'Food Recipe Check',
            subtitle: '(Teks)',
            description: 'Yuk cari tahu resep dalam membuat makanan favoritmu.',
            assetName: 'assets/img/recipe_nutricheck.png',
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Card _buildCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required String description,
    required String assetName,
    VoidCallback? onTap,
  }) {
    return Card(
      elevation: 4,
      clipBehavior: Clip.antiAlias,
      shadowColor: Colors.black.withOpacity(0.1),
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: double.infinity,
          height: 160,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .headline6!
                            .copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        subtitle,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: primaryColor),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: secondaryTextColor),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Text(
                            'Cobain deh',
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(top: 4),
                            child: Icon(
                              Icons.chevron_right_rounded,
                              color: primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: 80,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(assetName),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(100),
                    topLeft: Radius.circular(100),
                  ),
                  boxShadow: <BoxShadow>[
                    BoxShadow(
                      offset: const Offset(-2.0, 0.0),
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 4,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
