import 'package:dicoding/main.dart';
import 'package:dicoding/pages/about_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "/settings_screen";
  final _auth = FirebaseAuth.instance;

  SettingsScreen({super.key});


  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         title: Image.asset("images/planningku-logo-nobg-black.png", width: 80,),
       ),
       body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  height: 150,
                  color: Colors.grey[300],
                ),
                const SizedBox(height: 50,),
                const Center(
                  child: Text(
                    'Jonathan Hans',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 8),
                const Center(
                  child: Text(
                    'Software Engineer',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      const SizedBox(height: 16),
                      SettingsCard(
                        title: 'About',
                        icon: Icons.info,
                        onPressed: (){
                          Navigator.push(context,
                            MaterialPageRoute(
                              builder: (context) {
                                return const AboutScreen();
                              },
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      SettingsCard(
                        title: 'Sign out',
                        icon: Icons.exit_to_app,
                        onPressed: () async {
                          try {
                            await _auth.signOut();
                            // Sign out successful
                          } catch (e) {
                            // An error occurred while signing out
                          }
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const MyApp()),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              top: 10,
              left: 0,
              right: 0,
              child: CircleAvatar(
                radius: 80,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: Image.asset(
                    'images/ppicture2.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ],
        ),
     );
  }
}

class SettingsCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Function? onPressed;

  const SettingsCard({super.key, required this.title, required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () {
          onPressed!();
        },
      ),
    );
  }
}
