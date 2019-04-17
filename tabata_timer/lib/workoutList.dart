import 'package:flutter/material.dart';

class WorkoutList extends StatefulWidget {
  @override
  _WorkoutListState createState() => _WorkoutListState();
}

class _WorkoutListState extends State<WorkoutList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Workout List")
      ),
      body: Container(
        child: Text("WorkoutList"),
      ),);
  }
}