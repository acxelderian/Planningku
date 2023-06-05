class Agenda {
  late int? id;
  late String nama;
  late String deskripsi;
  late String tanggal;
  late String waktu;
  late String jenis;
  late String email;
  Agenda(
      { required this.id,
        required this.nama,
        required this.deskripsi,
        required this.tanggal,
        required this.waktu,
        required this.jenis,
        required this.email,
      }
      );

  Map <String, dynamic> toMap() {
    return {
      "id":id,
      "nama":nama,
      "deskripsi":deskripsi,
      "tanggal":tanggal,
      "waktu":waktu,
      "jenis":jenis,
      "email": email,
    };
  }
  Agenda.formMap(Map<String,dynamic> map) {
    id = map['id'];
    nama = map['nama'];
    deskripsi = map['deskripsi'];
    tanggal = map['tanggal'];
    waktu = map['waktu'];
    jenis = map['jenis'];
    email = map['email'];
  }
}
