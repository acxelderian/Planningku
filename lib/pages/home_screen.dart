import 'package:dicoding/models/agenda.dart';
import 'package:dicoding/pages/add_agenda_screen.dart';
import 'package:dicoding/pages/detail_agenda_screen.dart';
import 'package:dicoding/pages/list_agenda_screen.dart';
import 'package:dicoding/pages/settings_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const routeName = 'home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void changePage(int index){
    setState(() {
      _currentIndex = index;
    });
  }
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
          SettingsScreen.routeName: (context)=> SettingsScreen(),
        },
        home: Scaffold(
            body: IndexedStack(
              index: _currentIndex,
              children: [
                const ListAgendaScreen(),
                AddAgendaScreen(updateIndex: changePage),
                SettingsScreen()
              ],
            ),
            bottomNavigationBar: Builder(
              builder: (context) {
                return BottomNavigationBar(
                  items: const <BottomNavigationBarItem> [
                    BottomNavigationBarItem(icon: Icon(Icons.list), label: "List"),
                    BottomNavigationBarItem(icon: Icon(Icons.add), label: "Add"),
                    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
                  ],
                  currentIndex: _currentIndex,
                  onTap: (int index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                );
              },
            )
        )
    );

  }
}
