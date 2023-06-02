

class Agenda {
  String nama;
  String deskripsi;
  String tanggal;
  String waktu;
  String jenis;
  Agenda(
      {required this.nama,
        required this.deskripsi,
        required this.tanggal,
        required this.waktu,
        required this.jenis,}
      );
}
List<Agenda> listAgenda = [
  Agenda(nama: "AAA", deskripsi: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", tanggal: "02/02/2022", jenis: "Pendidikan", waktu: "20:00"),
  Agenda(nama: "BBB", deskripsi: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.", tanggal: "02/02/2022", jenis: "Pekerjaan", waktu: "20:00")
];