import 'package:flutter/material.dart';
import 'dart:convert';
class DailyTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? journey =
    ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;






    String journeyTitle = journey != null ? journey['topic'] : 'Journey'; // If journey is null, use a default title

    return Scaffold(
      appBar: AppBar(
        title: Text('Daily Task Checklist - $journeyTitle'),
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
       // children: roadmapList.map((task) {
        //  return TaskItem(
        //    title: task,
        //    isChecked: false,
        //  );
       // }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add action to add new tasks
          print(journey);
        },
        backgroundColor: Colors.teal,
        child: Icon(Icons.add),
      ),
    );
  }
}

class TaskItem extends StatefulWidget {
  final String title;
  final bool isChecked;

  TaskItem({required this.title, required this.isChecked});

  @override
  _TaskItemState createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _isChecked = widget.isChecked;
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        widget.title,
        style: TextStyle(
          decoration: _isChecked ? TextDecoration.lineThrough : TextDecoration.none,
        ),
      ),
      leading: Checkbox(
        value: _isChecked,
        onChanged: (newValue) {
          setState(() {
            _isChecked = newValue!;
          });
        },
      ),
    );
  }
}
