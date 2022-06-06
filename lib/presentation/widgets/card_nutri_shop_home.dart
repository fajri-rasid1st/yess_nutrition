import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/price_format.dart';

class CardNutriShopHome extends StatelessWidget {
  final String picture;
  final String category;
  final String title;
  final int price;

  const CardNutriShopHome({
    Key? key,
    required this.picture,
    required this.category,
    required this.title,
    required this.price,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: primaryBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 2),
            blurRadius: 4,
            color: const Color.fromARGB(255, 139, 127, 127).withOpacity(0.05),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 110,
            height: 110,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
            ),
            child: Image.network(
              picture,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            category,
            style: const TextStyle(
              color: secondaryTextColor,
              fontWeight: FontWeight.w400,
              fontSize: 9,
            ),
          ),
          Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.subtitle2?.copyWith(
                  color: primaryTextColor,
                ),
          ),
          const SizedBox(
            height: 4,
          ),
          Row(
            children: [
              Text(
                "Rp.",
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                      color: errorColor,
                    ),
              ),
              Text(
                CurrencyFormat.convertToIdr(price, 0),
                style: Theme.of(context).textTheme.bodyText2?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: errorColor,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
