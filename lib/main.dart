import 'package:dicoding/pages/add_agenda_screen.dart';
import 'package:dicoding/pages/detail_agenda_screen.dart';
import 'package:dicoding/pages/home_kas_screen.dart';
import 'package:flutter/material.dart';

import 'package:dicoding/pages/list_agenda_screen.dart';

import 'models/agenda.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dicoding',

      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      routes: {
        ListAgendaScreen.routeName: (context)=> const ListAgendaScreen(),
        // AddKasScreen.routeName: (context) => const AddKasScreen(),
        DetailAgendaScreen.routeName: (context) => DetailAgendaScreen(
            agenda: ModalRoute.of(context)?.settings.arguments as Agenda
        ),
      },
        home: Scaffold(
            body: Center(
              child: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  return HomeKasScreen(constraints.maxHeight ?? 0);
                }
              ),
            ),
            bottomNavigationBar: Builder(
              builder: (context) {
                return BottomNavigationBar(
                  items: const <BottomNavigationBarItem> [
                    BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
                    BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
                  ],
                  currentIndex: 0,
                  onTap: (index) async {
                    switch(index) {
                      case 0: Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return const ListAgendaScreen();
                      }));
                      break;
                      case 1: Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                        return const AddAgendaScreen();
                      }));
                      break;
                    }
                  },
                );
              },
            )
        )
    );

  }
}
