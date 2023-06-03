import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = "/settings_screen";
  @override
  Widget build(BuildContext context) {
     return Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 150,
                color: Colors.grey[300],
              ),
              SizedBox(height: 50,),
              Center(
                child: Text(
                  'Jonathan Hans',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(height: 8),
              Center(
                child: Text(
                  'Software Engineer',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                ),
              ),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.all(16),
                  children: [
                    SettingsCard(
                      title: 'Account',
                      icon: Icons.account_circle,
                    ),
                    SizedBox(height: 16),
                    SettingsCard(
                      title: 'Settings',
                      icon: Icons.settings,
                    ),
                    SizedBox(height: 16),
                    SettingsCard(
                      title: 'Preferences',
                      icon: Icons.star_border,
                    ),
                    SizedBox(height: 16),
                    SettingsCard(
                      title: 'About',
                      icon: Icons.info,
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
                  'images/lgtm.jpg',
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ],
      );
  }
}

class SettingsCard extends StatelessWidget {
  final String title;
  final IconData icon;

  const SettingsCard({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(icon),
        title: Text(title),
        onTap: () {
          // Handle card tap
        },
      ),
    );
  }
}
