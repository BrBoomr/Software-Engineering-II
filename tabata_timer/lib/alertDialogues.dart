import 'package:flutter/material.dart';

class PreparationAlert extends StatefulWidget {
  final _prepTime;
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
      title: Text(_prepTime.getTimeString(), textAlign: TextAlign.center,),
      content: SingleChildScrollView(
        child: Slider(
        min: 0.0,
        max: 60.0,
        value: _prepTime.getTimeDouble(),
        onChanged: (double value){
              setState(()=>{
                _prepTime.setTimeDouble(value.roundToDouble()),
              });
            },
      )),
      actions: <Widget>[
        new FlatButton(
          child: new Text("Close"),
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

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------

//-------------------------------------------------------------------------------
