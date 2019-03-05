import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Authenticator',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.red,
      ),
      home: LoginPage(),
    );
  }
}

class SecondScreen extends StatelessWidget {
  List<dynamic> posts, my_posts;

  SecondScreen(this.posts, this.my_posts);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login Authenticator',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.red,
      ),
      home: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.directions_car)),
                Tab(icon: Icon(Icons.directions_transit)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return ExpansionTile(
                    title: Text(posts[index]['title']),
                    children: <Widget>[Text(posts[index]['content'])],
                  );
                },
              ),
              ListView.builder(
                itemCount: my_posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return ExpansionTile(
                    title: Text(my_posts[index]['title']),
                    children: <Widget>[Text(my_posts[index]['content'])],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LoginPage extends StatelessWidget {
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  String url = "https://sleepy-stream-87265.herokuapp.com";

  void stuff(context) async {
    var token = await login();
    var allPosts = await getPosts(token);
    var myPosts = await getMyPosts(token); //change this
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SecondScreen(allPosts, myPosts)));
  }

  Future<String> login() async {
    var un = usernameController.text;
    var pw = passwordController.text;
    String login_url =
        "https://sleepy-stream-87265.herokuapp.com/api/login?username=$un&password=$pw";
    var response = await http.get(login_url);
    return jsonDecode(response.body)["token"];
  }

  Future<List<dynamic>> getPosts(token) async {
    String allposts_url =
        "https://sleepy-stream-87265.herokuapp.com/api/v1/posts";
    var response = await http.get(allposts_url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    var posts_json = jsonDecode(response.body);
    return posts_json;
  }

  Future<List<dynamic>> getMyPosts(token) async {
    String allposts_url =
        "https://sleepy-stream-87265.herokuapp.com/api/v1/my_posts";
    var response = await http.get(allposts_url,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    var posts_json = jsonDecode(response.body);
    return posts_json;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Login Page"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(20.0),
            ),
            TextField(
              controller: usernameController,
              decoration: InputDecoration(
                  hintText: "Username",
                  contentPadding: const EdgeInsets.all(20)),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(
                  hintText: "Password",
                  contentPadding: const EdgeInsets.all(20)),
            ),
            Padding(
              padding: EdgeInsets.all(20),
            ),
            FloatingActionButton.extended(
              onPressed: () {
                stuff(context);
              },
              label: Text("Submit"),
              icon: Icon(Icons.forward),
            ),
          ],
        ),
      ),
    );
  }
}
