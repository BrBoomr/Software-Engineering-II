import 'package:flutter/material.dart';
import 'dart:async';









class TimerPage extends StatefulWidget {
  final Map<String, int> valueSet;

  TimerPage(this.valueSet);

  @override
  _TimerPageState createState() => _TimerPageState(valueSet);
}

class _TimerPageState extends State<TimerPage> {
  final Map<String, int> valueSet;
  _TimerPageState(this.valueSet);

  Stopwatch _stopwatch = Stopwatch();
  Timer _timer;
  int _timeLeft = 0;
  int _roundsLeft = 0;

  bool complete = false;
  @override
  void initState() {
    _timeLeft = valueSet["_workTime"];
    _roundsLeft = valueSet["_numRounds"];
    super.initState();
  }

  void controlTimer(){

  }
  void startTimer() {
    callback(Timer timer) {
      setState(() {
        if (_timeLeft < 1) {
          if (_roundsLeft < 1) {
            timer.cancel();
          } else {
            _roundsLeft--;
            _timeLeft = valueSet["_workTime"];
          }
        } else {
          _timeLeft--;
        }
      });
    }

    const oneSec = const Duration(seconds: 1);
    _timeLeft = valueSet["_workTime"];
    _timer = new Timer.periodic(oneSec, callback);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    //var keys = valueSet.keys.toList(); => valueSet[keys[index]]
    return new Scaffold(
        appBar: AppBar(title: Text("Timer test")),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Seconds Left : $_timeLeft"),
            Text("Rounds Left: $_roundsLeft"),
            Text(_roundsLeft == 0 && _timeLeft == 0 ? "Done!" : ""),
            RaisedButton(
              padding:
                  EdgeInsets.only(left: 100, right: 100, top: 25, bottom: 25),
              onPressed: () {
                _stopwatch.isRunning ? controlTimer() :  startTimer();
              },
              child: Text("Start"),
            ),
          ],
        )));
  }
}
