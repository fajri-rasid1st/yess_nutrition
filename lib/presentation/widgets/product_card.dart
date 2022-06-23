import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';

import '../../common/utils/utils.dart';
import '../../data/models/models.dart';
import '../pages/nutrishop_pages/nutrishop_page.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 370,
            width: 200,
            margin: EdgeInsets.only(left: 15, top: 15),
            decoration: BoxDecoration(
              color: scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                // to make elevation
                BoxShadow(
                  color: Colors.black45,
                  offset: Offset(2, 2),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Expanded(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 180,
                        width: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            alignment: Alignment.bottomCenter,
                            image: AssetImage(product.imagePath),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 200, left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    product.name,
                                    style: TextStyle(
                                        fontFamily: font,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                                Wrap(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                      width: 20,
                                    ),
                                    Image.asset('assets/img/bintang.png'),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 10),
                                      child: Text(
                                        '${product.rating}',
                                        style: TextStyle(
                                          fontFamily: font,
                                          fontSize: 12,
                                        ),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    direction: Axis.vertical,
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '${Product.format(product.price)}',
                                        style: TextStyle(
                                            fontFamily: font,
                                            color: primaryColor,
                                            fontSize: 16),
                                      ),
                                      if (product.discountPercent != null)
                                        Text(
                                          '${Product.format(product.originalPrice)}',
                                          style: TextStyle(
                                            fontFamily: font,
                                            color: primaryColor,
                                            fontSize: 14,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationColor: Colors.black,
                                            decorationStyle:
                                                TextDecorationStyle.solid,
                                          ),
                                        ),
                                    ],
                                  ),
                                  LoveButton(),
                                ]),
                          ],
                        ),
                      ),
                      Positioned(
                        child: Container(
                          width: 50,
                          height: 40,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              alignment: Alignment.topLeft,
                              image: AssetImage('assets/img/discount.png'),
                            ),
                          ),
                          padding: const EdgeInsets.only(top: 10, left: 5),
                          child: Text(
                            product.discountPercent.toString() + '%',
                            style: TextStyle(
                                color: Color(0xffE52E45),
                                fontSize: 12,
                                fontFamily: font),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
