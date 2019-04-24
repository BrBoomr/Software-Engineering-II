import 'package:flutter/material.dart';
import 'dart:async';

class TimerPage extends StatefulWidget {
  final Map<String,int> valueSet;

  TimerPage(this.valueSet);

  @override
  _TimerPageState createState() => _TimerPageState(valueSet);
}

class _TimerPageState extends State<TimerPage> {
  final Map<String,int> valueSet;
  _TimerPageState(this.valueSet);


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
    var keys = valueSet.keys.toList();
    print(keys[1]);
    print(valueSet[1]);
    return new Scaffold(
        appBar: AppBar(title: Text("Timer test")),
        body: ListView.builder(
          itemCount: keys.length,
          itemBuilder: (context,index){
            return ListTile(
              
              title: Text("${valueSet[keys[index]]}")
            );
          },
        )
        // Column(
        //   children: <Widget>[
        //     RaisedButton(
        //       onPressed: () {
        //         startTimer();
        //       },
        //       child: Text("start"),
        //     ),
        //     Text("$_start")
        //   ],
        // )
    );
  }
}
