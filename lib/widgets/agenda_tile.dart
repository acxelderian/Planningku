import 'package:flutter/material.dart';

import '../models/agenda.dart';
import '../pages/detail_agenda_screen.dart';

class AgendaTile extends StatelessWidget {
  final Agenda agenda;
  const AgendaTile({Key? key, required this.agenda}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Icon(
          agenda.jenis == "Pendidikan" ? Icons.cast_for_education : Icons.work, color: Colors.black,
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
        tileColor: Colors.blueAccent,
        onTap: () {
          Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return DetailAgendaScreen(agenda : agenda);
              }
          ));
        },
        trailing: Wrap(
          spacing: 12,
          children: <Widget>[
            Icon(Icons.star, color: Colors.yellow,),
          ],
        ),

      ),
    );
  }
}
