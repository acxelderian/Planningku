<<<<<<< Updated upstream
class Agenda {
  late int? id;
=======
import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class Agenda {
>>>>>>> Stashed changes
  late String nama;
  late String deskripsi;
  late String tanggal;
  late String waktu;
  late String jenis;
<<<<<<< Updated upstream
  late String email;
=======
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream

  Map <String, dynamic> toMap() {
    return {
      "id":id,
=======
  Map<String,dynamic> toMap(){
    return {
>>>>>>> Stashed changes
      "nama":nama,
      "deskripsi":deskripsi,
      "tanggal":tanggal,
      "waktu":waktu,
      "jenis":jenis,
<<<<<<< Updated upstream
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
=======
    };
  }
  Agenda.formMap(Map<String,dynamic> map)
  {
    nama = map["nama"];
    deskripsi = map["deskripsi"];
    tanggal = map["tanggal"];
    waktu = map["waktu"];
    jenis = map["jenis"];
  }
  factory Agenda.fromJson(Map<String, dynamic> json) {
    Timestamp timestamp = json['date'];
    DateTime dateTime = timestamp.toDate();
    String formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
    String formattedTime = DateFormat('HH:mm').format(dateTime);

    return Agenda(
      nama: json['title'] as String,
      deskripsi: json['description'] as String,
      tanggal: formattedDate as String,
      waktu: formattedTime as String,
      jenis: json['type'] as String,
    );
  }

}
List<Agenda> listAgenda = [];
>>>>>>> Stashed changes
