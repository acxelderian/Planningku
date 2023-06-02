import 'package:dicoding/models/agenda.dart';
import 'package:dicoding/pages/detail_agenda_screen.dart';
import 'package:dicoding/widgets/display_card.dart';
import 'package:flutter/material.dart';
class ListAgendaScreen extends StatelessWidget {
  static const routeName='/list_agenda';
  const ListAgendaScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Agenda'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Center(
              child: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    // if(constraints.maxHeight > 250) {
                    //   return displayCard();
                    // }
                    return SizedBox(
                      height: 20,
                      child: Text(
                        "List Agenda",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins"
                        ),
                      ),
                    );
                  },
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: FractionallySizedBox(
              widthFactor: 0.8,
              child: ListView.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                itemCount: listAgenda.length,
                itemBuilder: (context,index) {
                  return buildItem(context, listAgenda[index], Colors.greenAccent);
                },
              ),
            )
          ),
        ],
      ),
    );
  }
}

Widget buildItem(BuildContext context, Agenda agenda, Color color) {
  return ListTile(
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
    tileColor: color,
    onTap: () {
      Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return DetailAgendaScreen(agenda : agenda);
          }
      ));
    },
  );
}


