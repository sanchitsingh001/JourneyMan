import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_data.dart';

class StartJourneyScreen extends StatefulWidget {
  @override
  _StartJourneyScreenState createState() => _StartJourneyScreenState();
}

class _StartJourneyScreenState extends State<StartJourneyScreen> {
  List<Map<String, dynamic>> journeys = []; // List to store journey data

  @override
  void initState() {
    super.initState();
    fetchJourneys(); // Fetch journeys when the screen initializes
  }

  // Fetch journeys from the server
  Future<void> fetchJourneys() async {
    final response = await http.get(Uri.parse('http://localhost:3000/getText/' + UserData.userId));
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      setState(() {
        journeys = data.map<Map<String, dynamic>>((text) => text).toList(); // Extract journey data from the response
      });
    } else {
      throw Exception('Failed to load journeys');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Start a New Journey"),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/'); // Navigate to the login screen
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            'Your Journeys',
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 20),
          Container(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: journeys.map((journey) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      //Navigate to the daily task page and pass the journey as a parameter
                      String? journeyString = journey['journey'];
                      if (journeyString != null) {
                        List<String> roadmapList =
                        journeyString.split("Day ").map((day) => day.trim()).toList();
                        DateTime today = DateTime.now();
                        print(today.difference(journey['start_date']) + Duration(days: 1));
                        // Navigator.pushNamed(context, '/dailyTask', arguments: roadmapList);
                      } else {
                        print("Error: journey data is not in the correct format");
                      }
                    },
                    child: Text(journey['topic']),
                  ),
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/home'); // Navigate to the home screen
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.teal,
          ),
          child: Text('Start a New Journey'),
        ),
      ),
    );
  }
}
