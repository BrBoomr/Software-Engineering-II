import 'package:flutter/material.dart';

class AddWorkout extends StatefulWidget {
  @override
  _AddWorkoutState createState() => _AddWorkoutState();
}

class _AddWorkoutState extends State<AddWorkout> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("New Workout")
      ),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Text("Pro Feature!", style: TextStyle(fontSize: 50),)),
      ),);
  }
}