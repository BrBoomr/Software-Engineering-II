import 'package:flutter/material.dart';
import 'post.dart';

class Tabs extends StatelessWidget {
  List<dynamic> posts, myPosts;
  var token;
  Tabs(this.posts, this.myPosts, this.token);
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