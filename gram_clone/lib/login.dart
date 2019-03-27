import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'main.dart';
import 'tab.dart';


class LoginPage extends StatelessWidget {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void stuff(context) async {
    var token = await login();
    var allPosts = await getPosts(token);
    var myPosts = await getMyPosts(token);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => Tabs(allPosts, myPosts, token)));
  }

  Future<String> login() async {
    var un = usernameController.text;
    var pw = passwordController.text;
    String loginUrl = "$url/api/login?username=$un&password=$pw";
    var response = await http.get(loginUrl);
    return jsonDecode(response.body)["token"];
  }

  Future<List<dynamic>> getPosts(token) async {
    String allPostsUrl = "$url/api/v1/posts";
    var response = await http.get(allPostsUrl,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    var postsJson = jsonDecode(response.body);
    return postsJson;
  }

  Future<List<dynamic>> getMyPosts(token) async {
    String allPostsUrl = "$url/api/v1/my_posts";
    var response = await http.get(allPostsUrl,
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    var postsJson = jsonDecode(response.body);
    return postsJson;
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