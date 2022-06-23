import 'package:flutter/material.dart';
import 'package:yess_nutrition/common/styles/color_scheme.dart';
import 'package:yess_nutrition/common/utils/constants.dart';
import 'package:yess_nutrition/presentation/pages/shop_pages/product_list_page.dart';
import 'package:yess_nutrition/presentation/widgets/product_category_card.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondaryBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Text(
                    'NutriShop',
                    style: TextStyle(
                      fontSize: 20,
                      color: primaryBackgroundColor,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                    decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(8),
                        image: const DecorationImage(
                          image: AssetImage('assets/img/ic_love.png'),
                        )),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: primaryBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                        height: 54,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: primaryColor),
                        ),
                        child: Row(
                          children: const <Widget>[
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
                            children: <Widget>[
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 15, right: 10),
                                child: Image.asset('assets/img/bg_iklan.png'),
                              ),
                              Container(
                                padding: const EdgeInsets.only(left: 16),
                                child: const Text(
                                  'Kategori Kesehatan',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List<Padding>.generate(
                                    healthProductCategories.length,
                                    (index) => Padding(
                                        padding:
                                            const EdgeInsets.only(right: 16),
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                            left: 15,
                                            top: 15,
                                          ),
                                          child: ProductCategoryCard(
                                              imgAsset:
                                                  healthProductCategories[index]
                                                      .imgAsset,
                                              title:
                                                  healthProductCategories[index]
                                                      .title,
                                              onPressed: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        ProductListPage(
                                                      title:
                                                          healthProductCategories[
                                                                  index]
                                                              .title,
                                                      url:
                                                          healthProductBaseUrls[
                                                              index],
                                                    ),
                                                  ),
                                                );
                                              }),
                                        )),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              Container(
                                padding: const EdgeInsets.only(left: 16),
                                child: const Text(
                                  'Kategori Makanan & Minuman',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(
                                    foodProductCategories.length,
                                    (index) => Padding(
                                      padding: const EdgeInsets.only(right: 16),
                                      child: Container(
                                        margin: const EdgeInsets.only(
                                          left: 15,
                                          top: 15,
                                        ),
                                        child: ProductCategoryCard(
                                          imgAsset: foodProductCategories[index]
                                              .imgAsset,
                                          title: foodProductCategories[index]
                                              .title,
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    ProductListPage(
                                                  title: foodProductCategories[
                                                          index]
                                                      .title,
                                                  url: foodProductBaseUrls[
                                                      index],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
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
                              const SizedBox(
                                height: 30,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: const [
                                Text(
                                  'Masker Medis',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text(
                                  'Yang Terbaik Untukmu!',
                                  style: TextStyle(fontSize: 16),
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   height: 400,
                            //   child: ListView.separated(
                            //     shrinkWrap: true,
                            //     scrollDirection: Axis.horizontal,
                            //     itemCount: masker.length,
                            //     itemBuilder: (context, index) => ProductCard(
                            //       product: masker[index],
                            //     ),
                            //     separatorBuilder: (context, index) =>
                            //         const SizedBox(width: 16),
                            //   ),
                            // ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Text(
                                        'Obat herbal lainnya',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Text(
                                        'Cek disini, yuk!',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 400,
                                  //   child: ListView.separated(
                                  //     shrinkWrap: true,
                                  //     scrollDirection: Axis.horizontal,
                                  //     itemCount: obat.length,
                                  //     itemBuilder: (context, index) =>
                                  //         ProductCard(
                                  //       product: obat[index],
                                  //     ),
                                  //     separatorBuilder: (context, index) =>
                                  //         const SizedBox(width: 16),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              padding: const EdgeInsets.only(left: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: const [
                                      Text(
                                        'Rekomendasi Untukmu',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 400,
                                  //   child: ListView.separated(
                                  //     shrinkWrap: true,
                                  //     scrollDirection: Axis.horizontal,
                                  //     itemCount: rekomendasi.length,
                                  //     itemBuilder: (context, index) =>
                                  //         ProductCard(
                                  //       product: rekomendasi[index],
                                  //     ),
                                  //     separatorBuilder: (context, index) =>
                                  //         const SizedBox(width: 16),
                                  //   ),
                                  // ),
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
        ),
      ),
    );
  }
}
