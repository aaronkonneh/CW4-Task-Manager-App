import 'package:flutter/material.dart';

void main() {
  runApp(TaskOrganizer());
}

class TaskOrganizer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Task Organizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TaskHomeScreen(),
    );
  }
}

class TaskDetails {
  String description;
  bool isCompleted;

  TaskDetails(this.description, {this.isCompleted = false});
}

class TaskHomeScreen extends StatefulWidget {
  @override
  _TaskHomeScreenState createState() => _TaskHomeScreenState();
}

class _TaskHomeScreenState extends State<TaskHomeScreen> {
  final List<TaskDetails> _taskDetailsList = [];
  final TextEditingController _inputController = TextEditingController();

  void _addNewTask() {
    final taskDescription = _inputController.text;
    if (taskDescription.isNotEmpty) {
      setState(() {
        _taskDetailsList.add(TaskDetails(taskDescription));
        _inputController.clear();
      });
    }
  }

  void _toggleTaskStatus(int index) {
    setState(() {
      _taskDetailsList[index].isCompleted =
          !_taskDetailsList[index].isCompleted;
    });
  }

  void _deleteTask(int index) {
    setState(() {
      _taskDetailsList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Aaron's Task Manager app"),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _inputController,
              decoration: InputDecoration(
                labelText: 'Enter your task here',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addNewTask,
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _taskDetailsList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          _taskDetailsList[index].description,
                          style: TextStyle(
                            decoration: _taskDetailsList[index].isCompleted
                                ? TextDecoration.lineThrough
                                : null,
                          ),
                        ),
                      ),
                      if (_taskDetailsList[index].isCompleted)
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "completed",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                    ],
                  ),
                  leading: Checkbox(
                    value: _taskDetailsList[index].isCompleted,
                    onChanged: (value) {
                      _toggleTaskStatus(index);
                    },
                  ),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      _deleteTask(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
