import 'package:flutter/material.dart';

import '../models/agenda.dart';

class DetailAgendaScreen extends StatelessWidget {
  static const routeName='/detail_kas';
  final Agenda agenda;
  const DetailAgendaScreen({Key? key,
    required this.agenda}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Detail Agenda"),
        ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.height / 2.5,
            child : Image.asset("./images/img_pendapatan.gif"),
          ),
          const SizedBox( height: 10,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            child: Center(
              child: Text(
                agenda.nama,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                  fontFamily: "Poppins"
                ),
              ),
            )
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
              child: Text(
                agenda.deskripsi,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: "Poppins",
                ),
              ),
            ),
          ),
          const SizedBox(height: 15,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 5),
              child: Text(
                "${agenda.tanggal} ${agenda.waktu}" ,
                style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: "Poppins"
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

}
