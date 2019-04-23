import 'package:flutter/material.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  Timer _timer;
  int _start = 10;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
        oneSec,
        (Timer timer) => setState(() {
              if (_start < 1) {
                timer.cancel();
              } else {
                _start = _start - 1;
              }
            }));
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(title: Text("Timer test")),
        body: Column(
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                startTimer();
              },
              child: Text("start"),
            ),
            Text("$_start")
          ],
        ));
  }
}