class CategoriKesehatan {
  final String title;
  final String img;

  CategoriKesehatan({required this.title, required this.img});
}

List<CategoriKesehatan> categoriKesehatan = [
  CategoriKesehatan(title: 'Alat Kesehatan', img: 'assets/img/alat-medis.png'),
  CategoriKesehatan(
      title: 'Essential Oil', img: 'assets/img/essential-oil.png'),
  CategoriKesehatan(title: 'Masker', img: 'assets/img/masker.png'),
  CategoriKesehatan(
      title: 'Kesehatan Mata', img: 'assets/img/kesehatan-mata.png'),
  CategoriKesehatan(
      title: 'Kesehatan Mulut & Gigi', img: 'assets/img/kesehatan-mulut.png'),
  CategoriKesehatan(
      title: 'Kesehatan Telinga', img: 'assets/img/kesehatan-telinga.png'),
  CategoriKesehatan(
      title: 'Kesehatan Wanita', img: 'assets/img/kesehatan-wanita.png'),
  CategoriKesehatan(title: 'Obat & Vitamin', img: 'assets/img/vitamin.png'),
];

class CategoriMakananMinuman {
  final String title;
  final String img;

  CategoriMakananMinuman({required this.title, required this.img});
}

List<CategoriMakananMinuman> categoriMakananMinuman = [
  CategoriMakananMinuman(title: 'Bahan Kue', img: 'assets/img/tepung.png'),
  CategoriMakananMinuman(title: 'Buah', img: 'assets/img/buah.webp'),
  CategoriMakananMinuman(title: 'Bumbu', img: 'assets/img/merica.png'),
  CategoriMakananMinuman(title: 'Beras', img: 'assets/img/beras.png'),
  CategoriMakananMinuman(title: 'Kue', img: 'assets/img/kue.png'),
  CategoriMakananMinuman(
      title: 'Makanan Beku', img: 'assets/img/frozen-food.png'),
  CategoriMakananMinuman(title: 'Makanan Jadi', img: 'assets/img/tumpeng.png'),
  CategoriMakananMinuman(title: 'Sayur', img: 'assets/img/sayur.webp'),
  CategoriMakananMinuman(title: 'Teh', img: 'assets/img/teh.jfif'),
  CategoriMakananMinuman(title: 'Telur', img: 'assets/img/telur.jpg'),
];
