import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dicoding/models/agenda.dart';
import 'package:dicoding/pages/detail_agenda_screen.dart';
import 'package:dicoding/pages/update_agenda_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Provider/dbprovider.dart';

class ListAgendaScreen extends StatefulWidget {
  static const routeName = '/list_agenda';

  const ListAgendaScreen({Key? key}) : super(key: key);

  @override
  State<ListAgendaScreen> createState() => _ListAgendaScreenState();
}

class _ListAgendaScreenState extends State<ListAgendaScreen> {
  late final ValueNotifier<List<Agenda>> _selectedEvents;
  final _firestore = FirebaseFirestore.instance;
  bool _isDbCalled = false;
  List<Agenda>? _agendas;
  bool _isButtonPressed = false;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay = DateTime.now();
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode.toggledOff;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;
  final kFirstDay = DateTime(DateTime.now().year, DateTime.now().month - 3, DateTime.now().day);
  final kLastDay = DateTime(DateTime.now().year, DateTime.now().month + 3, DateTime.now().day);

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getEventsForDay(_selectedDay!));
    getCurrentUser();
  }
  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Agenda> _getEventsForDay(DateTime day) {
    // Implementation example
    return kEvents[day] ?? [];
  }
  LinkedHashMap<DateTime, List<Agenda>> kEvents = LinkedHashMap<DateTime, List<Agenda>>(
    equals: isSameDay,
    hashCode: getHashCode,
  );
  void updateEventsFromListAgenda(List<Agenda> listAgenda) {
    kEvents.clear(); // Clear existing events

    for (final agenda in listAgenda) {
      final dateTime = DateTime.parse(agenda.tanggal);
      kEvents[dateTime] = [agenda];
    }
    _getEventsForDay;
  }
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });
    }
  }

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

  void deleteFirebase(Agenda agenda) async {
    final documentId = agenda.id;
    try {
      // Get the reference to the document you want to delete
      DocumentReference documentRef =
      _firestore.collection('agendas').doc(documentId);

      // Delete the document
      await documentRef.delete();
      setState(() {

      });
      print('Document deleted successfully');
    } catch (error) {
      print('Error deleting document: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Agenda'),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: _firestore.collection('agendas').orderBy('date', descending: true).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final agendaDocs = snapshot.data?.docs ?? [];
          listAgenda.clear(); // Clear the listAgenda before populating it again
          for (var agendaDoc in agendaDocs) {
            final agendaData = agendaDoc.data();
            final agendaId = agendaDoc.id;
            // if (agendaData['date'].compareTo(Timestamp.now()) > 0 &&
            //     agendaDoc['email'] == _activeUser?.email) {
              final agenda = Agenda.fromJson(agendaData,agendaId);
              listAgenda.add(agenda);
            // }
          }
          print(listAgenda.length);
          updateEventsFromListAgenda(listAgenda);
          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: TableCalendar<Agenda>(
                  firstDay: kFirstDay,
                  lastDay: kLastDay,
                  focusedDay: _focusedDay,
                  selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
                  rangeStartDay: _rangeStart,
                  rangeEndDay: _rangeEnd,
                  calendarFormat: _calendarFormat,
                  rangeSelectionMode: _rangeSelectionMode,
                  eventLoader: _getEventsForDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  calendarStyle: const CalendarStyle(
                    outsideDaysVisible: false,
                  ),
                  onDaySelected: _onDaySelected,
                  onFormatChanged: (format) {
                    if (_calendarFormat != format) {
                      setState(() {
                        _calendarFormat = format;
                      });
                    }
                  },
                  onPageChanged: (focusedDay) {
                    _focusedDay = focusedDay;
                  },
                ),
              ),
              SliverList.separated(
                separatorBuilder: (context, index) => const SizedBox(
                  height: 15,
                ),
                itemBuilder: (BuildContext context, int index) {
                  final agenda = listAgenda[index];
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
                    tileColor: Colors.blueAccent,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return DetailAgendaScreen(agenda: agenda);
                          },
                        ),
                      );
                    },
                    trailing: Wrap(
                      children: <Widget>[
                        // IconButton(
                        //   icon: Icon(Icons.star),
                        //   color: _isButtonPressed ? Colors.yellow : Colors.transparent,
                        //   onPressed: () {
                        //     setState(() {
                        //       if (_isButtonPressed) {
                        //         dbProvider.deleteAgenda(agenda.id!);
                        //       } else {
                        //         dbProvider.addAgenda(agenda);
                        //       }
                        //       _isButtonPressed = !_isButtonPressed;
                        //     });
                        //   },
                        // ),
                        // IconButton(
                        //     icon: Icon(
                        //         Icons.star
                        //     ),
                        //     color: Colors.yellow,
                        //     onPressed: () {
                        //       Provider.of<DbProvider> (context, listen: false).addAgenda(
                        //          agenda
                        //       );
                        //     }
                        // ),
                        // Consumer<DbProvider>(
                        //   builder: (context, dbProvider, _) {
                        //     return FutureBuilder<bool?>(
                        //       future: dbProvider.isAgendaFavorite(agenda.id!),
                        //       builder: (context, snapshot) {
                        //         if (snapshot.connectionState == ConnectionState.waiting) {
                        //           // Handle the loading state if needed
                        //           return CircularProgressIndicator();
                        //         } else if (snapshot.hasError) {
                        //           // Handle the error state if needed
                        //           return Text('Error');
                        //         } else {
                        //           bool isFavorite = snapshot.data ?? false;
                        //           Color color = isFavorite ? Colors.yellow : Colors.transparent;
                        //           return IconButton(
                        //             icon: Icon(Icons.star),
                        //             color: color,
                        //             onPressed: () {
                        //               dbProvider.addAgenda(agenda);
                        //             },
                        //           );
                        //         }
                        //       },
                        //     );
                        //   },
                        // ),
                        // IconButton(
                        //   icon: Icon(Icons.star),
                        //   color: Colors.white,
                        //   onPressed: () {
                        //     // dbProvider.addAgenda(agenda);
                        //   },
                        // ),
                        // Consumer<DbProvider>(
                        //   builder: (context, dbProvider, _) {
                        //     return FutureBuilder<List<Agenda>>(
                        //       future: dbProvider.getAgendaByIdCanBeNull(agenda.id!),
                        //       builder: (context, snapshot) {
                        //         if (snapshot.connectionState == ConnectionState.waiting) {
                        //           // Handle the loading state if needed
                        //           return CircularProgressIndicator();
                        //         } else if (snapshot.hasError) {
                        //           // Handle the error state if needed
                        //           return Text('Error');
                        //         } else {
                        //           List<Agenda> agendas = snapshot.data!;
                        //           if (agendas.length == 0) {
                        //             return IconButton(
                        //               icon: Icon(Icons.star),
                        //                   color: Colors.white30,
                        //                   onPressed: () {
                        //                     dbProvider.addAgenda(agenda);
                        //                   },
                        //             );
                        //           } else {
                        //             return IconButton(
                        //               icon: Icon(Icons.star),
                        //               color: Colors.yellow,
                        //               onPressed: () {
                        //                 dbProvider.deleteAgenda(agenda.id!);
                        //               },
                        //             );
                        //           }
                        //         }
                        //       },
                        //     );
                        //   },
                        // ),
                        IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              // edit agenda
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) {
                                    return UpdateAgendaScreen(agenda: agenda, updateIndex: (int) {
                                      Navigator.pop(context);
                                    },);
                                  },
                                ),
                              );
                            }
                        ),
                        IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              // delete agenda
                              deleteFirebase(agenda);
                            }
                        ),
                      ],
                    ),
                  );
                },
                itemCount: listAgenda.length,
              ),
            ],
          );
        },
      ),
    );
  }


  static int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}



