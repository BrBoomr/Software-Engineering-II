import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bingo Genereator',
      theme: ThemeData.dark(),
      home: MyHomePage(title: "Bingo Generator"),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  var rng = new Random();
  

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RowCell(rng),
              RowCell(rng),
              RowCell(rng),
              RowCell(rng),
              Divider(),
              FlatButton(
                child: Text("Generate"),
                color: Colors.green,
                padding:
                    EdgeInsets.only(left: 100, right: 100, top: 20, bottom: 20),
                onPressed: () => setState(() {
                      rng = new Random();
                    }),
              )
            ],
          ),
        ));
  }
}

class RowCell extends StatelessWidget {
  final rng;
  RowCell(this.rng);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Cell(1 + rng.nextInt(54 - 1)),
        Cell(1 + rng.nextInt(54 - 1)),
        Cell(1 + rng.nextInt(54 - 1)),
        Cell(1 + rng.nextInt(54 - 1)),
      ],
    );
  }
}

class Cell extends StatefulWidget {
  var number;
  Cell(this.number);
  @override
  _CellState createState() => _CellState();
}

class _CellState extends State<Cell> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => setState(() {
        widget.number = new Random().nextInt(54);
      }),
        child: Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(border: Border.all()),
      child: Text(
        "${widget.number}".padLeft(2, "0"),
        style: TextStyle(fontSize: 50),
      ),
    ));
  }
}
