import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:dicoding/models/agenda.dart';

class UpdateAgendaScreen extends StatefulWidget {
  static const routeName = '/update_agenda';
  final Function(int) updateIndex;
  final Agenda agenda;

  const UpdateAgendaScreen({Key? key, required this.updateIndex,required this.agenda}) : super(key: key);

  @override
  State<UpdateAgendaScreen> createState() => _UpdateAgendaScreen();
}

class _UpdateAgendaScreen extends State<UpdateAgendaScreen> {
  TextEditingController _namaController = TextEditingController();
  TextEditingController _deskripsiController = TextEditingController();
  TextEditingController _tanggalController = TextEditingController();
  TextEditingController _waktuController = TextEditingController();


  bool _success = false;
  String _jenis = "Pekerjaan";
  final _firestore = FirebaseFirestore.instance;
  late User? _activeUser;
  final _auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try{
      _activeUser = _auth.currentUser;
    }catch(e){
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();

    _namaController.text = widget.agenda.nama;
    _deskripsiController.text = widget.agenda.deskripsi;
    _tanggalController.text = widget.agenda.tanggal;
    _waktuController.text = widget.agenda.waktu;
    _jenis = widget.agenda.jenis;
  }

  @override
  void dispose() {
    _namaController.dispose();
    _deskripsiController.dispose();
    _tanggalController.dispose();
    _waktuController.dispose();
    super.dispose();
  }

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
              onPressed: () {
                Navigator.pop(context);
                if (_success) {
                  widget.updateIndex(0);
                }
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
                    margin: const EdgeInsets.only(top: 10),
                    child: const Text(
                      "Add a New Schedule",
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.blueAccent,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  const Divider(),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _namaController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      hintText: "Title",
                      prefixIcon: Icon(Icons.mail),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _deskripsiController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      hintText: "Description",
                      prefixIcon: Icon(Icons.text_fields),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _tanggalController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      hintText: "Date",
                      prefixIcon: Icon(Icons.date_range),
                    ),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      ).then((selectedDate) {
                        if (selectedDate != null) {
                          setState(() {
                            _tanggalController.text =
                                DateFormat('yyyy-MM-dd').format(selectedDate);
                          });
                        }
                      });
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: _waktuController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      hintText: "Time",
                      prefixIcon: Icon(Icons.punch_clock),
                    ),
                    onTap: () async {
                      final TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        setState(() {
                          _waktuController.text =
                              "${pickedTime.hour.toString().padLeft(2, "0")}:${pickedTime.minute.toString().padLeft(2, "0")}";
                        });
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    value: _jenis,
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
                            fontFamily: "Poppins",
                          ),
                        ),
                      ),
                    ],
                    onChanged: (value) {
                      setState(() {
                        _jenis = value!;
                      });
                    },
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      hintText: "Type",
                      prefixIcon: Icon(Icons.category),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(width: 1, color: Colors.blueGrey),
                    ),
                    child: const Text('Update'),
                    onPressed: () async {
                      String msg = "";
                      if (_namaController.text.isEmpty ||
                          _deskripsiController.text.isEmpty ||
                          _tanggalController.text.isEmpty ||
                          _waktuController.text.isEmpty ||
                          _jenis.isEmpty) {
                        msg = "Input tidak sesuai! Gagal update agenda";
                        _success = false;
                        _showDialog(context, msg);
                      } else {
                        String dateString = _tanggalController.text;
                        String timeString = _waktuController.text;
                        DateTime date = DateTime.parse(dateString);
                        List<String> timeParts = timeString.split(':');
                        int hour = int.parse(timeParts[0]);
                        int minute = int.parse(timeParts[1]);
                        date = date.add(Duration(hours: hour, minutes: minute));
                        Timestamp timestamp = Timestamp.fromDate(date);
                        await _firestore.collection('agendas').doc(widget.agenda.id).update({
                          'title':_namaController.text,
                          'description':_deskripsiController.text,
                          'date':timestamp,
                          'email':_activeUser?.email,
                          'type':_jenis,
                        });
                        int indexDelete = -1;
                        for (int i =0;i<listAgenda.length;i++) {
                          if (listAgenda[i].id == widget.agenda.id) {
                            indexDelete = i;
                          }
                        }
                        listAgenda.removeAt(indexDelete);
                        listAgenda.add(
                          Agenda(
                            id: widget.agenda.id,
                            nama: _namaController.text,
                            deskripsi: _deskripsiController.text,
                            tanggal: _tanggalController.text,
                            waktu: _waktuController.text,
                            jenis: _jenis,
                          ),
                        );
                        _success = true;
                        msg = "Berhasil update agenda";
                        _showDialog(context, msg);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}


