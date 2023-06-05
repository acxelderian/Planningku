import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dicoding/models/agenda.dart';
import 'package:dicoding/pages/detail_agenda_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class ListAgendaScreen extends StatefulWidget {
  static const routeName = '/list_agenda';

  const ListAgendaScreen({Key? key}) : super(key: key);

  @override
  State<ListAgendaScreen> createState() => _ListAgendaScreenState();
}

class _ListAgendaScreenState extends State<ListAgendaScreen> {
  late final ValueNotifier<List<Agenda>> _selectedEvents;
  final _firestore = FirebaseFirestore.instance;
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
            if (agendaData['date'].compareTo(Timestamp.now()) > 0 &&
                agendaDoc['email'] == _activeUser?.email) {
              final agenda = Agenda.fromJson(agendaData);
              listAgenda.add(agenda);
            }
          }
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
                  return buildItem(context, agenda, Colors.greenAccent);
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
  );
}
