
import 'package:dicoding/Provider/dbprovider.dart';
import 'package:dicoding/models/agenda.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class LogScreen extends StatelessWidget {
  static const routeName="/log_screen";
  const LogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset("images/planningku-logo-nobg-black.png", width: 80,),
      ),
      body: Consumer<DbProvider>(
          builder:(context,provider,child) {
            final arrAgenda = provider.agendas;

            return ListView.builder(
              itemCount: arrAgenda.length,
              itemBuilder: (context,index){
                final agenda = arrAgenda[index];
                return buildItem(context, agenda, Colors.white30);
              },
            );
          },
      ),
    );
  }
}

Widget buildItem(BuildContext context, Agenda agenda, Color color) {
  return ListTile(
    contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
    leading: Icon(
      agenda.jenis == "Pendidikan" ? Icons.cast_for_education : Icons.work,
      color: Colors.black,
    ),
    title: Text(
      agenda.nama,
      style: const TextStyle(
        fontSize: 16,
        fontFamily: "Poppins",
      ),
    ),
    subtitle: Text(
      "${agenda.tanggal} ${agenda.waktu}",
      style: const TextStyle(
        fontSize: 16,
        fontFamily: "Poppins",
      ),
    ),
    shape: RoundedRectangleBorder(
      side: const BorderSide(color: Colors.black, width: 1),
      borderRadius: BorderRadius.circular(5),
    ),
    tileColor: color,
  );
}
