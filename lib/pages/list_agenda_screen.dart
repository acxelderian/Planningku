
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dicoding/models/agenda.dart';
import 'package:dicoding/pages/detail_agenda_screen.dart';
import 'package:dicoding/widgets/agenda_tile.dart';
import 'package:dicoding/widgets/display_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class ListAgendaScreen extends StatefulWidget {
  static const routeName='/list_agenda';
  const ListAgendaScreen({Key? key}) : super(key: key);

  @override
  State<ListAgendaScreen> createState() => _ListAgendaScreenState();
}

class _ListAgendaScreenState extends State<ListAgendaScreen> {
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
                child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                    stream: _firestore.collection('agenda')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                            child: CircularProgressIndicator()
                        );
                      }
                      return ListView(
                          reverse: true,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 16,
                          ),
                          children: snapshot.data!.docs.map((document) {
                            final data = document.data();
                            if(data['email'] == _activeUser?.email) {
                              final agenda = Agenda(id: data['id'], nama: data['nama'], deskripsi: data['deskripsi'], tanggal: data['tanggal'], waktu: data['waktu'], jenis: data['jenis'], email: data['email']);
                              return AgendaTile(
                                  agenda: agenda
                              );
                            }
                            return SizedBox(height: 0,);
                          }).toList()
                      );
                    }
                )
              ),
            )
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


