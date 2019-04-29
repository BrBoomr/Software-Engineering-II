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

  //Stopwatch _stopwatch = Stopwatch();
  Timer _timer;
  int _timeLeft = 0;
  int _curRound = 1;

  bool _complete = false;
  bool _control = true; // True => Running, False => Paused
  @override
  void initState() {
    _timeLeft = valueSet["_workTime"];
    //_curRound = valueSet["_numRounds"];
    startTimer();
    super.initState();
  }

  void _pause(){
    _control = false;
  }
  void _resume(){
    _control = true;
  }
  
  void startTimer() {
    if(_complete){
      return;
    }
    callback(Timer timer) {
      setState(() {
        if (_timeLeft < 1) {
          if (_curRound >= valueSet["_numRounds"]) {
            _complete = true;
            timer.cancel();
          } else {
            _curRound++;
            _timeLeft = valueSet["_workTime"];
          }
        } else {
          if(_control){
            _timeLeft--;
          }
        }
      });
    }
    const oneSec = const Duration(seconds: 1);
    _timeLeft = valueSet["_workTime"];
    _timer = new Timer.periodic(oneSec, callback);
  }

  String timeText(int secs){
    int min, sec;
    min = secs ~/ 60;
    sec = secs - (min * 60);
    String minText = "$min".padLeft(2, "0");
    String secText = "$sec".padLeft(2, "0");
    return minText+":"+secText;
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Timer")),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("${timeText(_timeLeft)}",
              style: TextStyle(fontSize: 130),),
            Text("$_curRound / ${valueSet["_numRounds"]}",
              style: TextStyle(fontSize: 65),),
            //Text(_complete ? "Done!" : ""),
            RaisedButton(
              padding:
                  const EdgeInsets.only(left: 100, right: 100, top: 25, bottom: 25),
              onPressed: () {
                _control ? _pause() :  _resume();
              },
              child: _complete ? Text("Done!") : Text(_control ? "Pause" : "Resume"),
              color: _complete ? Colors.blue : _control ? Colors.red : Colors.green,
            ),
          ],
        )));
  }
}
