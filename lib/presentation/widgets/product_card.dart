import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/constants.dart';

class ProductCard extends StatelessWidget {
  // const ProductCard({
  //   Key? key,
  //   required this.image,
  //   required this.title,
  //   required this.price,
  //   required this.press,
  //   required this.bgColor,
  // }) : super(key: key);
  // final String image, title;
  // final VoidCallback press;
  // final int price;
  // final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: defaultPadding),
          child: Row(
            children: [
              Text(
                'Masker Medis',
                style: TextStyle(
                    fontFamily: font,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                width: 20,
              ),
              Text(
                'Yang Terbaik Untukmu!',
                style: TextStyle(
                    fontFamily: font,
                    fontSize: 16,
                    fontWeight: FontWeight.normal),
              ),
            ],
          ),
        ),
        Container(
          height: 280,
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
                        image: AssetImage('assets/img/masker1.png'),
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
                            Text(
                              'Masker Dukcabil',
                              style: TextStyle(
                                  fontFamily: font,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500),
                            ),
                            Wrap(
                              children: [
                                SizedBox(
                                  height: 10,
                                  width: 20,
                                ),
                                Image.asset('assets/img/bintang.png'),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    '4.9',
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
                        Wrap(
                          direction: Axis.vertical,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Rp.100.000',
                              style: TextStyle(
                                  fontFamily: font,
                                  color: primaryColor,
                                  fontSize: 16),
                            ),
                            Text(
                              'Rp.90.000',
                              style: TextStyle(
                                fontFamily: font,
                                color: primaryColor,
                                fontSize: 14,
                                decoration: TextDecoration.lineThrough,
                                decorationColor: Colors.black,
                                decorationStyle: TextDecorationStyle.solid,
                              ),
                            ),
                          ],
                        )
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
                        '15%',
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
        )
      ],
    );
  }
}
