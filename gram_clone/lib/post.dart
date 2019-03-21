import 'main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

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

  Widget imageContainer(){
    var likesCount = post['likes_count'];
    return new Container(
        constraints: new BoxConstraints.expand(
          height: 200.0,
        ),
        decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new NetworkImage(post['image_url']),
            fit: BoxFit.cover,
          ),
        ),
        child: new Stack(
          children: <Widget>[
            new Align(
              alignment: Alignment.bottomRight,
              child: FlatButton.icon(
                color: Colors.white,
                textColor: Colors.black,
                onPressed: ()=>{
                  post['liked'] ? removeLike(post['id']) : addLike(post['id']),
                },
                icon:Icon(
                  post['liked'] ? Icons.star : Icons.star_border, 
                  size:30,
                  color: post['liked'] ? Colors.blue : Colors.black,
                  ),
                label: Text("$likesCount"),
              )//new Icon(Icons.star_border, size: 45),
            ),
          ],
          
        )
        
    );
  }

  Widget subbarContainer(){
    var likesCount = post['likes_count'];
    var commentsCount = post['comments_count'];
    return Column(
      children: <Widget>[
        Text(post['caption'],
          textAlign: TextAlign.center,),
        Text("Created by: " + post['user_email'],
        textAlign: TextAlign.center,),
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
          ]
        )
      ],
    );
  }

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
    return ListTile(
      title: imageContainer(),
      subtitle: subbarContainer(),
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