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
      title: 'Gram Clone',
      theme: ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.red,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(
              tabs: [
                Tab(icon: Icon(Icons.rss_feed)),
                Tab(icon: Icon(Icons.publish)),
              ],
            ),
            title: Text("Gram Clone"),
            centerTitle: true,
          ),
          body: TabBarView(
            children: [
              ListView.builder(
                itemCount: posts.length,
                itemBuilder: (BuildContext context, int index) {
                  return Post(posts[index],token);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}