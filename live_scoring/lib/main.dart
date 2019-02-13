import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class TeamNames extends StatelessWidget {
  TeamNames({Key key, this.title}) : super(key: key);
  final String title;
  var teamOneController = TextEditingController();
  var teamTwoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Names'),
      ),
      body: Center(
        child: RaisedButton(
          child: Text('Start Game!'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyHomePage(teamOneController.text, teamTwoController.text)),
            );
          },
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TKD Scorer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TeamNames(title: 'TKD Scorer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //MyHomePage({Key key, this.title}) : super(key: key);
  MyHomePage(this.teamOneName, this.teamTwoName);
  //final String title;
  final String teamOneName, teamTwoName;

  @override
  _MyHomePageState createState() => _MyHomePageState(teamOneName, teamTwoName);
}

class _MyHomePageState extends State<MyHomePage> {
  int _counterA = 0;
  int _counterB = 0;

  int _foulA = 0;
  int _foulB = 0;
  final String teamOneName, teamTwoName;
  _MyHomePageState(this.teamOneName, this.teamTwoName);

  void _incrementCounterA() {
    setState(() {
      _counterA++;
    });
  }

  void _incrementFoulA(){
    setState(() {
      if(_foulA==1){
        _foulA=0;
        if(_counterA > 0){
         _counterA--;
       }
      }
      else{
        _foulA++;
      }
    });
  }

  void _incrementCounterB() {
    setState(() {
      _counterB++;
    });
  }

  void _incrementFoulB(){
    setState(() {
     if(_foulB==1){
       _foulB=0;
       if(_counterB > 0){
         _counterB--;
       }
     } 
     else{
       _foulB++;
     }
    });
  }
  void _resetScore() {
    setState(() {
      _counterA = 0;
      _counterB = 0;
      _foulA =0;
      _foulB=0;
    });
  }

  Column scoreButtonColumn(
    String label,
  ) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        new Container(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: new Text(
            label,
            style: new TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        new Container(
          padding: const EdgeInsets.all(8.0),
          child: new Text(
            (label == teamOneName) ? '$_counterA' : '$_counterB',
            style: new TextStyle(fontSize: 32.0, color: Colors.black38),
          ),
        ),
        new Container(
          padding: const EdgeInsets.all(8.0),
          child: new RaisedButton(
            child: new Text('Add Point'),
            onPressed:
                (label == teamOneName) ? _incrementCounterA : _incrementCounterB,
          ), 
        ),
        new Container(
          padding: const EdgeInsets.all(8.0),
          child: new RaisedButton(
              child: new Text('Foul'),
              onPressed: 
                (label== teamOneName) ? _incrementFoulA : _incrementFoulB,
          )
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return new Scaffold(
      appBar: new AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        //title: new Text(widget.title),
      ),
      body: new Container(
        padding: const EdgeInsets.all(15.0),
        child: new Column(
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                scoreButtonColumn('Team A'),
                new Container(
                  margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                  child: new CustomPaint(
                    painter: new Sky(),
                  ),
                ),
                scoreButtonColumn('Team B'),
              ],
            ),
            new Container(
              margin: const EdgeInsets.only(top: 72.0),
              child: new RaisedButton(
                onPressed: _resetScore,
                child: new Text('Reset'),
              ),
            )
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class Sky extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawRect(
      new Rect.fromLTRB(0.0, -100.0, 1.0, 150.0),
      new Paint()..color = new Color(0xFF0099FF),
    );
  }

  @override
  bool shouldRepaint(Sky oldDelegate) {
    return false;
  }
}