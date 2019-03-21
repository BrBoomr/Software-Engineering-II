//https://serene-beach-48273.herokuapp.com
import 'package:flutter/material.dart';
import 'login.dart';

void main() => runApp(MyApp());

String url = "https://serene-beach-48273.herokuapp.com";

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Gram Clone',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.red,
      ),
      home: LoginPage(),
    );
  }
}





