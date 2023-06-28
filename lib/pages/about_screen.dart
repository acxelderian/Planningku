import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Padding(
            padding: EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PlanningKu',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Version 1.0',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'The agenda application is a platform designed specifically to assist users in organizing and managing their schedules, activities, and events more efficiently. This application has several main features that will facilitate users in managing their agendas. Here is a detailed description of each available feature:\n\nLogin: The login feature allows users to access the application using their pre-registered accounts. With login, users can securely access and manage their personal agendas.\n\nRegister: The register feature allows users who do not have an account to create a new account in the agenda application. Users need to provide the required information and create a secure password to protect their privacy.\n\nList Agenda: The List Agenda feature displays the user\'s agenda in the form of a calendar. For the calendar view, the application utilizes the tableCalendar component from the pub.dev package. Users can view their agendas on specific dates and months.\n\nAdd Agenda: The Add Agenda feature enables users to add a new agenda to the application. Users can enter the activity name, description, date, time, and agenda category (such as "Work," "Education," etc.).\n\nDetail Agenda: The Detail Agenda feature provides a detailed view of a specific agenda. Users can view information such as the activity name, description, date, time, and agenda category. This feature allows users to examine agenda details more comprehensively, helping them prepare and manage their time more effectively.',
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Contact:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Email: planningku@gmail.com',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Phone: +123456789',
                    style: TextStyle(fontSize: 16),
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
