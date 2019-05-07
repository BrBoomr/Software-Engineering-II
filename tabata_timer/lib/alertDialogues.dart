import 'package:flutter/material.dart';
String timeText(int secs){
    int min, sec;
    min = secs ~/ 60;
    sec = secs - (min * 60);
    String minText = "$min".padLeft(2, "0");
    String secText = "$sec".padLeft(2, "0");
    return minText+":"+secText;
}

class PreparationAlert extends StatefulWidget {
  final  _prepTime;
  final Function callback;
  PreparationAlert(this._prepTime, this.callback);
  @override
  _PreparationAlertState createState() => _PreparationAlertState(_prepTime);
}

class _PreparationAlertState extends State<PreparationAlert> {
  final _prepTime;
  _PreparationAlertState(this._prepTime);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        _prepTime.getTimeString(),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
          child: Slider(
        min: 0.0,
        max: 60.0,
        divisions: 12,
        value: _prepTime.getTimeDouble(),
        onChanged: (double value) {
          setState(() => {
                _prepTime.setTimeDouble(value.roundToDouble()),
              });
        },
      )),
      actions: <Widget>[
        
        FlatButton(
          child: Text("Discard"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Save"),
          onPressed: () {
            this.widget.callback(_prepTime);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}

//-------------------------------------------------------------------------------
class RoundsAlert extends StatefulWidget {
  final int _numRounds;
  final Function callback;
  RoundsAlert(this._numRounds, this.callback);
  @override
  _RoundsAlertState createState() => _RoundsAlertState(_numRounds);
}

class _RoundsAlertState extends State<RoundsAlert> {
  int _numRounds;
  _RoundsAlertState(this._numRounds);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(_numRounds.toString(), textAlign: TextAlign.center,),
      content: SingleChildScrollView(
          child: Slider(
        min: 0.0,
        max: 15.0,
        value: _numRounds.toDouble(),
        onChanged: (double value) {
          setState(() => {
                _numRounds = value.round(),
              });
        },
      )),
      actions: <Widget>[
        FlatButton(
          child: new Text("Discard"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: new Text("Save"),
          onPressed: () {
            this.widget.callback(_numRounds);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
//-------------------------------------------------------------------------------
class WorkAlert extends StatefulWidget {
  final _workTime;
  final Function callback;

  WorkAlert(this._workTime,this.callback);
  @override
  _WorkAlertState createState() => _WorkAlertState(_workTime);
}

class _WorkAlertState extends State<WorkAlert> {
  final _workTime;
  _WorkAlertState(this._workTime);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        _workTime.getTimeString(),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
          child: Slider(
        min: 0.0,
        max: 180.0,
        divisions: 36,
        value: _workTime.getTimeDouble(),
        onChanged: (double value) {
          setState(() => {
                _workTime.setTimeDouble(value.roundToDouble()),
              });
        },
      )),
      actions: <Widget>[
        
        FlatButton(
          child: Text("Discard"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Save"),
          onPressed: () {
            this.widget.callback(_workTime);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
//-------------------------------------------------------------------------------
class RestAlert extends StatefulWidget {
  final _restTime;
  final Function callback;

  RestAlert(this._restTime,this.callback);
  @override
  _RestAlertState createState() => _RestAlertState(_restTime);
}

class _RestAlertState extends State<RestAlert> {
  final _restTime;
  _RestAlertState(this._restTime);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        _restTime.getTimeString(),
        textAlign: TextAlign.center,
      ),
      content: SingleChildScrollView(
          child: Slider(
        min: 0.0,
        max: 60.0,
        divisions: 12,
        value: _restTime.getTimeDouble(),
        onChanged: (double value) {
          setState(() => {
                _restTime.setTimeDouble(value.roundToDouble()),
              });
        },
      )),
      actions: <Widget>[
        
        FlatButton(
          child: Text("Discard"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Save"),
          onPressed: () {
            this.widget.callback(_restTime);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
//-------------------------------------------------------------------------------
class CycleAlert extends StatefulWidget {
  final int _numCycles;
  final Function callback;
  CycleAlert(this._numCycles, this.callback);
  @override
  _CycleAlertState createState() => _CycleAlertState(_numCycles);
}

class _CycleAlertState extends State<CycleAlert> {
  var _numCycles;

  _CycleAlertState(this._numCycles);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(_numCycles.toString(), textAlign: TextAlign.center,),
      content: SingleChildScrollView(
          child: Slider(
        min: 0.0,
        max: 15.0,
        value: _numCycles.toDouble(),
        onChanged: (double value) {
          setState(() => {
                _numCycles = value.round(),
              });
        },
      )),
      actions: <Widget>[
        
        FlatButton(
          child: new Text("Discard"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: new Text("Save"),
          onPressed: () {
            this.widget.callback(_numCycles);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
//-------------------------------------------------------------------------------
