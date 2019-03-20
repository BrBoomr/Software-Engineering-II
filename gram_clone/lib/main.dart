//https://serene-beach-48273.herokuapp.com
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';
import 'dart:async';

void main() => runApp(MyApp());

String url = "https://serene-beach-48273.herokuapp.com";

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
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
class NewPost extends StatefulWidget {
  final post;
  final token;
  NewPost(this.post, this.token);
  @override
  _NewPostState createState() => _NewPostState(post,token);
}

class _NewPostState extends State<NewPost> {
  final post;
  final token;
  _NewPostState(this.post, this.token);

  void addLike(var postId) async {
    http.post("$url/api/v1/posts/$postId/likes",
    headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    setState(() {
      post['liked']=true;
      post['likes_count']++;
    });
  }
  void removeLike(var postId) async {
    http.delete("$url/api/v1/posts/$postId/likes",
    headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    setState(() {
      post['liked']=false;
      post['likes_count']--;
    });
  }
  @override
  Widget build(BuildContext context) {
    var likesCount = post['likes_count'];
    var commentsCount = post['comments_count'];
    return ExpansionTile(
      title: Text(post['caption']),
      children: <Widget>[
        Text("Created by: " + post['user_email']),
        Text(post['image_url']),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton(
              color: post['liked'] ? Colors.blue : Colors.transparent,
              child: Text("Like: $likesCount"),
              onPressed: () => {
                post['liked'] ? removeLike(post['id']) : addLike(post['id']),
              },
            ),
            FlatButton(
              child: Text("Comments: $commentsCount"),
              onPressed: () => {},
            )
          ],
        )
      ],
    );
  }
}

class PostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      
    );
  }
}

class SecondScreen extends StatelessWidget {
  List<dynamic> posts, myPosts;
  var token;
  SecondScreen(this.posts, this.myPosts, this.token);
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
                  return NewPost(posts[index],token);
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    padding: EdgeInsets.all(30.0),
                    child: Text("New Post"),
                    onPressed: () => {},
                  ),
                ],
              ),
              ListView.builder(
                itemCount: myPosts.length,
                itemBuilder: (BuildContext context, int index) {
                  return NewPost(myPosts[index],token);
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

  void stuff(context) async {
    var token = await login();
    var allPosts = await getPosts(token);
    var myPosts = await getMyPosts(token);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SecondScreen(allPosts, myPosts, token)));
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
