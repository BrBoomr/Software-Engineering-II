import 'package:flutter/material.dart';

class PreparationAlert extends StatefulWidget {
  var _prepTime;
  Function callback;
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
        value: _prepTime.getTimeDouble(),
        onChanged: (double value) {
          setState(() => {
                _prepTime.setTimeDouble(value.roundToDouble()),
              });
        },
      )),
      actions: <Widget>[
        FlatButton(
          child: Text("Save"),
          onPressed: () {
            this.widget.callback(_prepTime);
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: Text("Discard"),
          onPressed: () {
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
  Function callback;
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
          child: new Text("Save"),
          onPressed: () {
            this.widget.callback(_numRounds);
            Navigator.of(context).pop();
          },
        ),
        FlatButton(
          child: new Text("Discard"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------
