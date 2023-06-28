import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dicoding/pages/update_agenda_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/agenda.dart';

class DetailAgendaScreen extends StatelessWidget {
  static const routeName='/detail_kas';
  final Agenda agenda;
  DetailAgendaScreen({Key? key,
    required this.agenda}) : super(key: key);
  final _firestore = FirebaseFirestore.instance;

  void _showDialog(BuildContext context, String msg) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
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
              onPressed: () async {
                final documentId = agenda.id;
                try {
                  // Get the reference to the document you want to delete
                  DocumentReference documentRef =
                  _firestore.collection('agendas').doc(documentId);

                  // Delete the document
                  await documentRef.delete();

                  Navigator.pop(context);
                  print('Document deleted successfully');
                } catch (error) {
                print('Error deleting document: $error');
                }
                Navigator.pop(context);
              },
              child: const Text(
                "OK",
                style: TextStyle(
                  fontFamily: "Poppins",
                ),
              ),
            )
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail Agenda"),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return UpdateAgendaScreen(agenda: agenda, updateIndex: (index) {
                      Navigator.popUntil(context,ModalRoute.withName("/"));
                    });
                  },
                ),
              );
            },
            icon: const Icon(Icons.edit)
          ),
          IconButton(
              onPressed: () async {
                _showDialog(context, "Are you sure you want to delete this agenda?");
              },
              icon: const Icon(Icons.delete)
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
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
          Table(
            columnWidths: const {
              0: FlexColumnWidth(3), // 30% of the page
              1: FlexColumnWidth(7), // 70% of the page
            },
            children: [
              _buildTableRow('Type', agenda.jenis),
              _buildTableRow('Date', DateFormat('d MMM yyyy').format(DateTime.parse(agenda.tanggal))),
              _buildTableRow('Time', agenda.waktu),
            ],
          ),
          const SizedBox(height: 16,),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      side: BorderSide( color: Colors.black, width: 2.0),
                    ),
                    child:Container(
                      height: 50,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(agenda.deskripsi),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
TableRow _buildTableRow(String label, String value) {
  return TableRow(
    children: [
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 4),
          child: Card(
            elevation: 7.0,
            shadowColor: Colors.white38,
            shape: const StadiumBorder(
              side: BorderSide(
                color: Colors.black26,
                style: BorderStyle.solid,
              ),
            ),
            color: Colors.white38,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              child: Text(
                label,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18
                ),
              ),
            ),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16,horizontal: 16),
          child: Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  color: Colors.black12,
                  width: 0.7,
                ),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                value,
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ),
      )
    ],
  );
}

