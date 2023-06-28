

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class Agenda {
  late String? id;
  late String nama;
  late String deskripsi;
  late String tanggal;
  late String waktu;
  late String jenis;
  Agenda(
      {
        this.id,
        required this.nama,
        required this.deskripsi,
        required this.tanggal,
        required this.waktu,
        required this.jenis,
      }
    );

  Map <String, dynamic> toMap() {
    return {
      "id": id,
      "nama":nama,
      "deskripsi":deskripsi,
      "tanggal":tanggal,
      "waktu":waktu,
      "jenis":jenis,
    };
  }

  Agenda.fromMap(Map<String,dynamic> map)
  {
    id = map["id"];
    nama = map["nama"];
    deskripsi = map["deskripsi"];
    tanggal = map["tanggal"];
    waktu = map["waktu"];
    jenis = map["jenis"];
  }
  factory Agenda.fromJson(Map<String, dynamic> json,String id) {
    Timestamp timestamp = json['date'];
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    String formattedTime = DateFormat('HH:mm').format(dateTime);

    return Agenda(
      id: id as String,
      nama: json['title'] as String,
      deskripsi: json['description'] as String,
      tanggal: formattedDate as String,
      waktu: formattedTime as String,
      jenis: json['type'] as String,
    );
  }

}
List<Agenda> listAgenda = [];
