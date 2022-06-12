import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/utils/constants.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/data/models/categories.dart';
import 'package:yess_nutrition/data/models/products.dart';
import 'package:yess_nutrition/presentation/widgets/categories_kesehatan_card.dart';
import 'package:yess_nutrition/presentation/widgets/categories_makanan_minuman_card.dart';
import 'package:yess_nutrition/presentation/widgets/product_card.dart';

class NutriShopPage extends StatelessWidget {
  const NutriShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryBackgroundColor,
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'NutriShop',
                  style: TextStyle(
                    fontSize: 20,
                    color: primaryBackgroundColor,
                    fontFamily: font,
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: AssetImage('assets/img/ic_love.png'),
                      )),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: primaryBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: primaryColor),
                      ),
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: primaryColor,
                                ),
                                border: InputBorder.none,
                                hintText: 'Search Item',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(left: 15, right: 10),
                              child: Image.asset(
                                'assets/img/bg_iklan.png',
                              ),
                            ),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: defaultPadding),
                              child: Text(
                                'Kategori Kesehatan',
                                style: TextStyle(
                                    fontFamily: font,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  categoriKesehatan.length,
                                  (index) => Padding(
                                      padding: const EdgeInsets.only(
                                          right: defaultPadding),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, top: 15),
                                        child: CategoryCardKesehatan(
                                            img: categoriKesehatan[index].img,
                                            title:
                                                categoriKesehatan[index].title,
                                            press: () {}),
                                      )),
                                ),
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                              padding:
                                  const EdgeInsets.only(left: defaultPadding),
                              child: Text(
                                'Kategori Makanan & Minuman',
                                style: TextStyle(
                                    fontFamily: font,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  categoriMakananMinuman.length,
                                  (index) => Padding(
                                      padding: const EdgeInsets.only(
                                          right: defaultPadding),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                            left: 15, top: 15),
                                        child: CategoryCardMakananMinuman(
                                            img: categoriMakananMinuman[index]
                                                .img,
                                            title: categoriMakananMinuman[index]
                                                .title,
                                            press: () {}),
                                      )),
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  left: 40, right: 20, top: 30),
                              child: Image.asset(
                                'assets/img/bg_discount.png',
                              ),
                            ),
                            SizedBox(
                              height: 30,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.only(left: defaultPadding),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
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
                          Container(
                            height: 400,
                            child: ListView.separated(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: masker.length,
                              itemBuilder: (context, index) => ProductCard(
                                product: masker[index],
                              ),
                              separatorBuilder: (context, index) =>
                                  const SizedBox(width: defaultPadding),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: defaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Obat herbal lainnya',
                                      style: TextStyle(
                                          fontFamily: font,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Text(
                                      'Cek disini, yuk!',
                                      style: TextStyle(
                                          fontFamily: font,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 400,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: obat.length,
                                    itemBuilder: (context, index) =>
                                        ProductCard(
                                      product: obat[index],
                                    ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: defaultPadding),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Container(
                            padding:
                                const EdgeInsets.only(left: defaultPadding),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      'Rekomendasi Untukmu',
                                      style: TextStyle(
                                          fontFamily: font,
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 400,
                                  child: ListView.separated(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: rekomendasi.length,
                                    itemBuilder: (context, index) =>
                                        ProductCard(
                                      product: rekomendasi[index],
                                    ),
                                    separatorBuilder: (context, index) =>
                                        const SizedBox(width: defaultPadding),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
