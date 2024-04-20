import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'user_data.dart';

class QueryResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? args =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    if (args == null || args.isEmpty || args['topic'] == null) {
      // Handle if arguments are null or empty or if topic is null
      return Scaffold(
        body: Center(
          child: Text('No arguments passed or topic is null'),
        ),
      );
    }

    final String queryText = args['queryText'];
    final String topic = args['topic'];

    List<String> roadmapList =
    queryText.split("Day ").map((day) => day.trim()).toList();
    roadmapList = roadmapList.sublist(1);

    return Scaffold(
      appBar: AppBar(
        title: Text("Here's Your RoadMap"),
        backgroundColor: Colors.teal,
      ),
      backgroundColor: Colors.greenAccent,
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var i = 0; i < roadmapList.length; i++)
                  Container(
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                      color: i % 2 == 0
                          ? Colors.grey[300]
                          : Colors.grey[200], // Alternate colors
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Day ${i + 1}", // Add 1 to i to start day numbering from 1
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        Text(
                          roadmapList[i], // Access roadmapList at index i
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Call the function to register roadmap
                      registerRoadMap(queryText, roadmapList, topic, context);
                    },
                    child: Text("Implement"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Function to register roadmap
  void registerRoadMap(
      String queryText, List<String> roadmapList, String topic, BuildContext context) async {
    try {
      // Calculate start date (today's date)
      DateTime startDate = DateTime.now();
      String formattedStartDate =
          "${startDate.year}-${startDate.month}-${startDate.day}";

      // Calculate end date (today's date + length of roadmapList)
      DateTime endDate = startDate.add(Duration(days: roadmapList.length));
      String formattedEndDate =
          "${endDate.year}-${endDate.month}-${endDate.day}";

      // Make a POST request to your backend API
      final response = await http.post(
        Uri.parse('http://localhost:3000/createText'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'userId': UserData.userId,
          'topic': topic,
          'journey': queryText,
          'start_date': formattedStartDate,
          'end_date': formattedEndDate,
        }),
      );

      if (response.statusCode == 201) {
        // Registration successful
        print('Roadmap registered successfully');

        // Show a snackbar with congratulations message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Congratulations! Roadmap registered successfully.'),
          ),
        );

        // Delay navigation to daily task page
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacementNamed(context, '/dailyTask');
        });
      } else {
        // Registration failed
        print('Failed to register roadmap');
        // You can show an error message here
      }
    } catch (error) {
      print('Error: $error');
      // Handle any error that might occur
    }
  }
}
