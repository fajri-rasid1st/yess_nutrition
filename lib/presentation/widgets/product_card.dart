import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/data/models/product_models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;

  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 370,
            width: 200,
            margin: const EdgeInsets.only(left: 15, top: 15),
            decoration: BoxDecoration(
              color: scaffoldBackgroundColor,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const <BoxShadow>[
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
                children: <Widget>[
                  Stack(
                    children: <Widget>[
                      Container(
                        height: 180,
                        width: 200,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            alignment: Alignment.bottomCenter,
                            image: AssetImage(product.imgUrl),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 200, left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Expanded(child: Text(product.title)),
                                Wrap(
                                  children: <Widget>[
                                    const SizedBox(
                                      height: 10,
                                      width: 20,
                                    ),
                                    Image.asset('assets/img/bintang.png'),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        left: 5,
                                        right: 10,
                                      ),
                                      child: Text(
                                        // product.rating,
                                        '',
                                        style: const TextStyle(fontSize: 12),
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Wrap(
                                  direction: Axis.vertical,
                                  children: [
                                    const SizedBox(height: 5),
                                    Text(
                                      product.price,
                                      style:
                                          Theme.of(context).textTheme.bodyText1,
                                    ),
                                    const Text(
                                      '',
                                      style: TextStyle(
                                        color: primaryColor,
                                        decoration: TextDecoration.lineThrough,
                                        decorationColor: Colors.black,
                                        decorationStyle:
                                            TextDecorationStyle.solid,
                                      ),
                                    ),
                                  ],
                                ),
                                // LoveButton(),
                              ],
                            ),
                          ],
                        ),
                      ),
                      // Positioned(
                      //   child: Container(
                      //     width: 50,
                      //     height: 40,
                      //     decoration: const BoxDecoration(
                      //       image: DecorationImage(
                      //         alignment: Alignment.topLeft,
                      //         image: AssetImage('assets/img/discount.png'),
                      //       ),
                      //     ),
                      //     padding: const EdgeInsets.only(top: 10, left: 5),
                      //     child: Text(
                      //       '${product.discountPercent}%',
                      //       style: Theme.of(context).textTheme.caption,
                      //     ),
                      //   ),
                      // ),
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
