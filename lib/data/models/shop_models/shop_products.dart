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
      name: 'MASKER KF94 KOREA 4PLY MOUSON ISI 10 PCS KOREAN MASK BOGOR',
      imagePath: 'assets/img/masker1.webp',
      originalPrice: 6.500,
      rating: 5,
      discountPercent: 15),
  Product(
      name:
          'Masker 3 PLy 3ply Earloop Medical Grade Hitam Black Edition isi 50',
      imagePath: 'assets/img/masker2.webp',
      originalPrice: 15.000,
      rating: 4.9,
      discountPercent: 17),
  Product(
      name:
          'Masker Duckbill 3D kn95 3ply 3 Ply Duck Bill earloop Tali isi 50 Pcs',
      imagePath: 'assets/img/masker3.webp',
      originalPrice: 50.000,
      rating: 4.9,
      discountPercent: 68),
  Product(
      name: 'MASKER DUCKBILL ANAK MOTIF SENSA ISI 50PCS KEMENKES',
      imagePath: 'assets/img/masker4.webp',
      originalPrice: 115.000,
      rating: 5,
      discountPercent: 64),
  Product(
      name:
          'Masker dukbil anak 3ply isi 10biji tulis dicatatan mau cewe atau cowo atau campur',
      imagePath: 'assets/img/masker5.webp',
      originalPrice: 50.00,
      rating: 5,
      discountPercent: 85),
];

List<Product> obat = [
  Product(
      name: 'Tolak Angin Cair Dus 5x5s Herbal-Masuk Angin Mual Flu Demam',
      imagePath: 'assets/img/obat1.webp',
      originalPrice: 102.580,
      rating: 5,
      discountPercent: 35),
  Product(
      name:
          'Naturatik Naturafit Original Herbal Obat Asam Urat Rematik Pegal Linu Nyeri Sendi kaku Kemeng 50 kapsul',
      imagePath: 'assets/img/obat2.webp',
      originalPrice: 55.000,
      rating: 5,
      discountPercent: 34),
  Product(
      name: 'Kapsul Herbal Obat Hernia',
      imagePath: 'assets/img/obat3.webp',
      originalPrice: 24.900,
      rating: 4.8,
      discountPercent: 12),
  Product(
      name:
          'Propolis Light G-Nutri Obat Herbal Untuk Diabetes Hipertensi Stroke & Jantung Asli Original',
      imagePath: 'assets/img/obat4.webp',
      originalPrice: 200.000,
      rating: 4.8,
      discountPercent: 15),
  Product(
      name: 'Bactenormin Original Obat Parasit Tubuh Asli Herbal',
      imagePath: 'assets/img/obat5.jwebp',
      originalPrice: 100.000,
      rating: 4.8,
      discountPercent: 30),
];

List<Product> rekomendasi = [
  Product(
      name: 'Salep BL Asli Original - Cream BL - Salep Gatal-Eksim-Jamur',
      imagePath: 'assets/img/rekomend1.webp',
      originalPrice: 16.000,
      rating: 5,
      discountPercent: 15),
  Product(
      name: 'Komix Adult Jahe Pack 30 Sachet',
      imagePath: 'assets/img/rekomend2.webp',
      originalPrice: 55.500,
      rating: 4.9,
      discountPercent: 20),
  Product(
      name: 'Sutra Lubricant 50 mL',
      imagePath: 'assets/img/rekomend3.webp',
      originalPrice: 14.000,
      rating: 4.9,
      discountPercent: 14),
  Product(
      name:
          'Masker 3 PLy 3ply Earloop Medical Grade Hitam Black Edition isi 50',
      imagePath: 'assets/img/rekomend4.webp',
      originalPrice: 15.000,
      rating: 4.9,
      discountPercent: 17),
  Product(
      name: 'Paket Hemat Bundling isi 6 Saniter Hand Sanitizer Spray 60 ml',
      imagePath: 'assets/img/rekomend5.webp',
      originalPrice: 99.400,
      rating: 4.9,
      discountPercent: 32),
];
