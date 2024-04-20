import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'start_journey_screen.dart'; // Import the start journey screen
import 'query_result_screen.dart';
import 'dailyTask.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      routes: {
        '/': (context) => LoginScreen(), // Start with the login screen
        '/startJourney': (context) => StartJourneyScreen(), // New route for start journey screen
        '/home': (context) => HomeScreen(),
        '/register': (context) => RegisterScreen(),
        '/queryResult': (context) => QueryResultScreen(),
        '/dailyTask':(context) => DailyTaskPage(),
      },
    );
  }
}
