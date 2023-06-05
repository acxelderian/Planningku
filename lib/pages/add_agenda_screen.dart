import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dicoding/models/agenda.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddAgendaScreen extends StatefulWidget {
  static const routeName='/add_agenda';

  const AddAgendaScreen({Key? key}) : super(key: key);
  @override
  State<AddAgendaScreen> createState() => _AddAgendaScreen();
}

class _AddAgendaScreen extends State<AddAgendaScreen> {
  String nama = "", deskripsi = "", tanggal = "", waktu = "";
  String? jenis = "";
  int nominal = 0;
  bool isPendapatan = false;
  final _firestore = FirebaseFirestore.instance;
  late User? _activeUser;
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      _activeUser = _auth.currentUser;

    }
    catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Aplikasi Agenda'),
        ),
        body: SingleChildScrollView(
          child: Container(
            alignment: Alignment.center,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: Center(
                child: Column(
                  children: [
                    Container(
                      child: const Text(
                        "Penambahan Transaksi",
                        style: TextStyle(
                            fontSize: 25,
                            color: Colors.blueAccent,
                            fontFamily: "Poppins"
                        ),
                      ),
                      margin: const EdgeInsets.only(top: 10),
                    ),
                    const Divider(),
                    const SizedBox(height: 20,),
                    TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: "Nama",
                          prefixIcon: Icon(Icons.mail)
                      ),
                      onChanged: (text) {
                        nama = text;
                      },
                    ),
                    const SizedBox(height: 20,),
                    TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: "Deskripsi",
                          prefixIcon: Icon(Icons.text_fields)
                      ),
                      onChanged: (text) {
                        deskripsi = text;
                      },
                    ),
                    const SizedBox(height: 20,),
                    TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: "Tanggal",
                          prefixIcon: Icon(Icons.date_range)
                      ),
                      onChanged: (text) {
                        tanggal = text;
                      },
                    ),
                    const SizedBox(height: 20,),
                    TextField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          hintText: "Waktu",
                          prefixIcon: Icon(Icons.punch_clock)
                      ),
                      onChanged: (text) {
                        waktu = text;
                      },
                    ),
                    const SizedBox(height: 20,),
                    DropdownButton<String>(
                      isExpanded: true,
                      items: const <DropdownMenuItem<String>>[
                        DropdownMenuItem<String>(
                          value: "Pekerjaan",
                          child: Text(
                            'Pekerjaan',
                            style: TextStyle(
                              fontFamily: "Poppins",
                            ),
                          ),
                        ),
                        DropdownMenuItem<String>(
                          value: "Pendidikan",
                          child: Text(
                              'Pendidikan',
                              style: TextStyle(
                                  fontFamily: "Poppins"
                              )
                          ),
                        ),
                      ],
                      onChanged: (String? value) {
                        setState(() {
                          jenis = value;
                        });
                      },
                    ),
                    const SizedBox(height: 20,),
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(width: 1, color: Colors.blueGrey),
                      ),
                      child: const Text('Submit'),
                      onPressed: () {
                        String msg = "";
                        if(nama == "" || deskripsi == "" || tanggal == "" || waktu == "" || jenis == "") {
                          msg = "Input tidak sesuai! Gagal menambah agenda baru";
                        }
                        else {
                          _firestore.collection('agenda').add({
                            'nama': nama,
                            'deskripsi': deskripsi,
                            'tanggal': tanggal,
                            'waktu': waktu,
                            'jenis': jenis,
                            'email': _activeUser?.email,
                          });
                          msg = "Berhasil menambah agenda baru";
                        }
                        return _showDialog(context, msg);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}

void _showDialog(BuildContext context, String msg) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))
        ),
        title: Text(
          msg,
          style: const TextStyle(
            fontSize: 12,
            fontFamily: "Poppins",
          ),
        ),
        actions: [
          OutlinedButton(
            onPressed: (){
              Navigator.pop(context);
            },
            child: const Text(
              "OK",
              style: TextStyle(
                  fontFamily: "Poppins"
              ),
            ),

          )
        ],
      );
    },
  );
}
