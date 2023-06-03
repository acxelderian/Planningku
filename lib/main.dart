import 'package:dicoding/pages/add_agenda_screen.dart';
import 'package:dicoding/pages/carousel_screen.dart';
import 'package:dicoding/pages/detail_agenda_screen.dart';
import 'package:dicoding/pages/home_kas_screen.dart';
import 'package:dicoding/pages/home_screen.dart';
import 'package:dicoding/pages/login_screen.dart';
import 'package:dicoding/pages/register_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'package:dicoding/pages/list_agenda_screen.dart';

import 'firebase_options.dart';
import 'models/agenda.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carousel App',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      routes: {
        ListAgendaScreen.routeName: (context)=> const ListAgendaScreen(),
        // AddKasScreen.routeName: (context) => const AddKasScreen(),
        DetailAgendaScreen.routeName: (context) => DetailAgendaScreen(
            agenda: ModalRoute.of(context)?.settings.arguments as Agenda
        ),
        CarouselScreen.routeName:(context) => CarouselScreen(),
        LoginScreen.routeName:(context) => LoginScreen(),
        RegisterScreen.routeName:(context) => RegisterScreen(),
      },
      home: FutureBuilder<User?>(
        future: checkLoginStatus(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else {
            if (snapshot.data != null) {
              return HomeScreen();
            } else {
              return CarouselScreen();
            }
          }
        },
      ),
    );
  }

  Future<User?> checkLoginStatus() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    return auth.currentUser;
  }
}