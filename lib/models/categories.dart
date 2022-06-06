class CategoriKesehatan {
  final String title;
  final String img;

  CategoriKesehatan({required this.title, required this.img});
}

List<CategoriKesehatan> categoriKesehatan = [
  CategoriKesehatan(title: 'Suplemen Diet', img: 'assets/img/suplement.png'),
  CategoriKesehatan(
      title: 'Essential Oil', img: 'assets/img/essential-oil.png'),
  CategoriKesehatan(
      title: 'Kesehatan Wanita', img: 'assets/img/kesehatan-wanita.png'),
  CategoriKesehatan(
      title: 'Vitamin & Multivitamin', img: 'assets/img/vitamin.png'),
  CategoriKesehatan(title: 'Obat-Obatan', img: 'assets/img/obat.png'),
  CategoriKesehatan(title: 'Alat Medis', img: 'assets/img/alat-medis.png'),
  CategoriKesehatan(title: 'Masker', img: 'assets/img/masker.png'),
];

class CategoriMakananMinuman {
  final String title;
  final String img;

  CategoriMakananMinuman({required this.title, required this.img});
}

List<CategoriMakananMinuman> categoriMakananMinuman = [
  CategoriMakananMinuman(title: 'Bahan Kue', img: 'assets/img/tepung.png'),
  CategoriMakananMinuman(title: 'Beras', img: 'assets/img/beras.png'),
  CategoriMakananMinuman(
      title: 'Bumbu & Bahan Masakan', img: 'assets/img/merica.png'),
  CategoriMakananMinuman(title: 'Kue', img: 'assets/img/kue.png'),
  CategoriMakananMinuman(
      title: 'Makanan Beku', img: 'assets/img/frozen-food.png'),
  CategoriMakananMinuman(title: 'Makanan Jadi', img: 'assets/img/tumpeng.png'),
  CategoriMakananMinuman(title: 'Makanan Ringan', img: 'assets/img/snack.png'),
];
