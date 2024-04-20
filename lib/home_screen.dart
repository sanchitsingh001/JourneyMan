import 'package:flutter/material.dart';
import 'API.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _weeksController = TextEditingController();
  final TextEditingController _monthsController = TextEditingController();
  final TextEditingController _specialInstructionsController =
  TextEditingController();
  String _inputText = '';
  String _daysText = '';
  String _weeksText = '';
  String _monthsText = '';
  String _specialInstructionsText = '';
  String _selectedInterval = 'Day';

  @override
  void dispose() {
    _textController.dispose();
    _daysController.dispose();
    _weeksController.dispose();
    _monthsController.dispose();
    _specialInstructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Pathmaker"),
        backgroundColor: Colors.teal,
        // Add a leading icon button for back navigation
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushNamed(context, '/startJourney'); // Navigate to "Start a New Journey" screen
          },
        ),
      ),
      backgroundColor: Colors.greenAccent,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 20),
              Icon(
                Icons.local_florist,
                size: 200.0,
                color: Colors.teal,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _textController,
                  decoration: InputDecoration(
                    hintText: 'Enter the skill here',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _inputText = value;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _daysController,
                        decoration: InputDecoration(
                          hintText: 'Days',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _daysText = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _weeksController,
                        decoration: InputDecoration(
                          hintText: 'Weeks',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _weeksText = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: TextField(
                        controller: _monthsController,
                        decoration: InputDecoration(
                          hintText: 'Months',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (value) {
                          setState(() {
                            _monthsText = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TextField(
                  controller: _specialInstructionsController,
                  decoration: InputDecoration(
                    hintText: 'Special Instructions',
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _specialInstructionsText = value;
                    });
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: DropdownButton<String>(
                  value: _selectedInterval,
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedInterval = newValue!;
                    });
                  },
                  items: <String>['Day', 'Week']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_inputText.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Please enter the skill first.'),
                      ),
                    );
                    return;
                  }

                  // Print all inputs to the command line
                  print(_inputText);
                  print(_daysText);
                  print(_weeksText);
                  print(_monthsText);
                  print(_specialInstructionsText);
                  print(_selectedInterval);

                  // Adjust URL accordingly to include new parameters if needed
                  String url =
                      "http://127.0.0.1:5000/Calculate?Query=$_inputText&Days=$_daysText&Weeks=$_weeksText&Months=$_monthsText&SpecialInstructions=$_specialInstructionsText&Interval=$_selectedInterval";
                  var data = await Getdata(url);
                  String queryText = data.replaceAll("\\n", "\n").trim();

                  Navigator.pushNamed(context, '/queryResult',
                      arguments: {"queryText":queryText, 'topic': _inputText});
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                ),
                child: Text('Generate Roadmap'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
