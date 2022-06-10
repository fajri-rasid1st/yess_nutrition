class DataMenuMakan {
  late String waktuMakan;
  late String info;

  DataMenuMakan({
    required this.waktuMakan,
    required this.info,
  });
}

var dataWaktuMakan = [
  DataMenuMakan(waktuMakan: 'Sarapan', info: 'Tambahkan menu sarapan'),
  DataMenuMakan(waktuMakan: 'Makan Siang', info: 'Tambahkan menu makan siang'),
  DataMenuMakan(waktuMakan: 'Makan Malam', info: 'Tambahkan menu makan malam'),
];
