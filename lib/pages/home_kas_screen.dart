import 'package:flutter/material.dart';

class HomeKasScreen extends StatelessWidget {
  static const routeName='/home_agenda';
  final double maxHeight;
  const HomeKasScreen(this.maxHeight, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Aplikasi Pencatatan Keuangan'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 10),
            child: const Text(
                "Selamat Datang",
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 40,
                fontFamily: "Poppins"
              ),
            ),
          ),
          const Divider(),
          const SizedBox(height: 50,),

          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              if(maxHeight > 500) {
                return Container(
                  margin: const EdgeInsets.only(top: 10),
                  child : Image.asset("./images/brown_default.gif"),
                );
              }
              return const SizedBox(
                height: 1,
              );
            },
          ),
        ],
      ),

    );
  }
}