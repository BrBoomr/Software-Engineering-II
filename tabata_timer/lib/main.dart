import 'package:flutter/material.dart';
import 'addWorkout.dart';
import 'workoutDetail.dart';
import 'workoutList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tabata Timer',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.red,
      ),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
      routes: <String, WidgetBuilder>{
        '/workoutList': (BuildContext context) => WorkoutList(),
        '/addWorkout': (BuildContext context) => AddWorkout(),
      },
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Tabata Timer"),
          brightness: Brightness.dark,
          actions: functionList(context),
        ),
        body: Center(
          child: ListView(
            children: <Widget>[
              SizedBox(height: 10),
              InkWell(
                  splashColor: Colors.blue,
                  onTap: () => {},
                  child: Card(
                      child: ListTile(
                    title: Center(child: Text("Preparation")),
                    subtitle: Center(
                      child: Text("0:20"),
                    ),
                  ))),
              InkWell(
                splashColor: Colors.blue,
                  onTap: () => {},
                  child: Card(
                      child: ListTile(
                    title: Center(child: Text("Rounds")),
                    subtitle: Center(
                      child: Text("12"),
                    ),
                  ))),
              InkWell(
                splashColor: Colors.blue,
                  onTap: () => {},
                  child: Card(
                      child: ListTile(
                    title: Center(child: Text("Work")),
                    subtitle: Center(
                      child: Text("3:00"),
                    ),
                  ))),
              InkWell(
                splashColor: Colors.blue,
                  onTap: () => {},
                  child: Card(
                      child: ListTile(
                    title: Center(child: Text("Rest")),
                    subtitle: Center(
                      child: Text("0:50"),
                    ),
                  ))),
              InkWell(
                splashColor: Colors.blue,
                  onTap: () => {},
                  child: Card(
                      child: ListTile(
                    title: Center(child: Text("Cycles")),
                    subtitle: Center(
                      child: Text("1"),
                    ),
                  ))),
              Divider(),
              SizedBox(height: 20),
              RaisedButton(
                onPressed: () => {},
                child: Text("Start"),
                color: Colors.green,
                padding: const EdgeInsets.all(30),
              ),
            ],
          ),
        ));
  }
}

List<Widget> functionList(var context) {
  return <Widget>[
    IconButton(
      icon: Icon(Icons.list),
      onPressed: () => {Navigator.pushNamed(context, "/workoutList")},
    ),
    IconButton(
      icon: Icon(Icons.add),
      onPressed: () => {Navigator.pushNamed(context, "/addWorkout")},
    ),
    IconButton(
      icon: Icon(Icons.assignment),
      onPressed: () => {_workoutDetail(context)},
    ),
  ];
}

void _workoutDetail(var context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text("Workout Detail"),
        content: new Text("List of Contents"),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
