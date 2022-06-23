class Produk {
  /* id merupakan url untuk menuju ke detail dari produk yang dipilih.
  *  Bisa digunakan untuk mengambil data pada halaman detail aplikasi
  *  dengan teknik web scraping. Alternatif lain, bisa digunakan untuk
  *  mengarahkan user langsung ke aplikasi Tokopedia (halaman detail
  *  produk yang dipilih).
  */
  final String id;
  final String title;
  final String price;
  final String imgUrl;

  Produk({
    required this.id,
    required this.title,
    required this.price,
    required this.imgUrl,
  });
}
