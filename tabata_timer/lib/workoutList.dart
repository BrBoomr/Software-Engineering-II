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
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Text("Pro Feature!", style: TextStyle(fontSize: 50),)),
      ),);
  }
}