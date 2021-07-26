import 'package:flutter/material.dart';
import 'package:tasks/Theme/style.dart';
import 'package:tasks/Screens/home_tasks.dart';

void main() {
  runApp(ToDoApp());
}

class ToDoApp extends StatefulWidget {
  @override
  _ToDoAppState createState() => _ToDoAppState();
}

class _ToDoAppState extends State<ToDoApp> {
  @override
  void initState() {
    // getTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To Do List',
      theme: appTheme,
      home: HomeTasks(),
    );
  }
}
