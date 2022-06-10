import 'package:flutter/material.dart';

class Product {
  String name;
  String imagePath;
  int? discountPercent;
  double originalPrice;
  double rating;

  Product({
    required this.name,
    required this.imagePath,
    required this.originalPrice,
    required this.rating,
    this.discountPercent,
  });

  double get price {
    return discountPercent != null
        ? (originalPrice - (originalPrice * discountPercent! / 100))
        : originalPrice;
  }

  static String format(double price) {
    String money = price.toStringAsFixed(3);
    return '\Rp.$money';
  }
}

List<Product> masker = [
  Product(
      name:
          'Masker 4ply Duckbill Flower Series Earloop & Hijab - Flower Ungu, Earloop',
      imagePath: 'assets/img/masker1.png',
      originalPrice: 37.500,
      rating: 4.9,
      discountPercent: 30),
  Product(
      name:
          'Masker Anak Duckbill Custom Warna Maskit - Masker Hijau - Round White',
      imagePath: 'assets/img/masker2.png',
      originalPrice: 37.500,
      rating: 4.9,
      discountPercent: 25),
  Product(
      name:
          'Masker KN95 5 Ply, Masker 5 Lapis Premium 5ply Earloop, Medical Grade - Putih',
      imagePath: 'assets/img/masker3.jpg',
      originalPrice: 27.800,
      rating: 4.9,
      discountPercent: 19),
  Product(
      name:
          'MIISOO Disposable N95 KN95 Korea KF94 Masker Kesehatan masker evo 4ply - EVO 1pcs',
      imagePath: 'assets/img/masker4.jpg',
      originalPrice: 10.000,
      rating: 4.9,
      discountPercent: 82),
  Product(
      name:
          'Masker Anak Duckbill Maskit Cartoon Series Kids - Duckbill Tali Warna - Mickey Mouse',
      imagePath: 'assets/img/masker5.jpg',
      originalPrice: 39.500,
      rating: 4.9,
      discountPercent: 25),
];

List<Product> obat = [
  Product(
      name: 'HerbaPAIN Obat Sakit Kepala Herbal 30 Tablet',
      imagePath: 'assets/img/obat1.jpg',
      originalPrice: 108.900,
      rating: 4.7,
      discountPercent: 5),
  Product(
      name: 'Herbana Relief Sari Jinten Hitam - 60 Kapsul',
      imagePath: 'assets/img/obat2.jpg',
      originalPrice: 150.000,
      rating: 5,
      discountPercent: 17),
  Product(
      name: 'Jelly Gamat Gold G 500 ml',
      imagePath: 'assets/img/obat3.jpg',
      originalPrice: 130.000,
      rating: 4.9,
      discountPercent: 12),
  Product(
      name:
          'HerbaKOF Sirup Obat Batuk Herbal StickPack Sachet 15 ml - 16 pcs x 15 ml',
      imagePath: 'assets/img/obat4.jpg',
      originalPrice: 43.200,
      rating: 5,
      discountPercent: 10),
  Product(
      name: 'HerbaVOMITZ Herbal Pereda kembung dan Mual 30 Tablet',
      imagePath: 'assets/img/obat5.jpg',
      originalPrice: 108.900,
      rating: 5,
      discountPercent: 10),
];

List<Product> rekomendasi = [
  Product(
      name: 'Masker Evo PlusMed 4d Medis - Putih',
      imagePath: 'assets/img/rekomend1.png',
      originalPrice: 135.000,
      rating: 5,
      discountPercent: 56),
  Product(
      name:
          'Paket FreshCare Teens (1Cherry,1Bubble Gum,1Passion Fruit) Free Holder',
      imagePath: 'assets/img/rekomend2.jpg',
      originalPrice: 32.700,
      rating: 5,
      discountPercent: 12),
  Product(
      name: 'Imboost Kids Tablet Hisap Chewy - Isi 21 Tablet',
      imagePath: 'assets/img/rekomend3.jpg',
      originalPrice: 30.025,
      rating: 5,
      discountPercent: 20),
  Product(
      name: 'Akurat Test Kehamilan',
      imagePath: 'assets/img/rekomend4.jpg',
      originalPrice: 10.099,
      rating: 4.9,
      discountPercent: 6),
  Product(
      name:
          'Minyak Kelapa Extra Virgin Coconut Oil VCO - Pure Unrefined 100% 250ML',
      imagePath: 'assets/img/rekomend5.jpg',
      originalPrice: 59.500,
      rating: 4.9,
      discountPercent: 30),
];
