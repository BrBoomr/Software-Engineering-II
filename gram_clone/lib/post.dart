import 'main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'userPage.dart';

class Post extends StatefulWidget {
  final post;
  final token;
  Post(this.post, this.token);
  @override
  _PostState createState() => _PostState(post, token);
}

class _PostState extends State<Post> {
  final post;
  final token;
  _PostState(this.post, this.token);

  Future<dynamic>getUserDetails(var userId) async{
    var details = await http.get("$url/api/v1/users/$userId",
    headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    return jsonDecode(details.body);
  }

  void goToUserPage(context, var userId) async{
    var userDetails = await getUserDetails(userId);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => UserPage(token,userDetails)));
  }
  Widget imageContainer() {
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
            Align(
              alignment: Alignment.topLeft,
              child: Material(
                elevation: 4.0,
                shape: CircleBorder(),
                color: Colors.transparent,
                child: Ink.image(
                  image: NetworkImage(post['user_profile_image_url']),
                  fit: BoxFit.cover,
                  width: 50.0,
                  height: 50.0,
                  child: InkWell(
                    onTap: () {
                      goToUserPage(context, post['user_id']);
                    },
                    child: null,
                  ),
                ),
              ),
            ),
            Align(
                alignment: Alignment.bottomRight,
                child: FlatButton.icon(
                  color: Colors.white,
                  textColor: Colors.black,
                  onPressed: () => {
                        post['liked']
                            ? removeLike(post['id'])
                            : addLike(post['id']),
                      },
                  icon: Icon(
                    post['liked'] ? Icons.star : Icons.star_border,
                    size: 30,
                    color: post['liked'] ? Colors.blue : Colors.black,
                  ),
                  label: Text("$likesCount"),
                ) //new Icon(Icons.star_border, size: 45),
                ),
          ],
        ));
  }

  Widget subbarContainer() {
    var likesCount = post['likes_count'];
    var commentsCount = post['comments_count'];
    return Column(
      children: <Widget>[
        Text(
          post['caption'],
          textAlign: TextAlign.center,
        ),
        Text(
          "Created by: " + post['user_email'],
          textAlign: TextAlign.center,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
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
        ])
      ],
    );
  }

  void addLike(var postId) async {
    http.post("$url/api/v1/posts/$postId/likes",
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    setState(() {
      post['liked'] = true;
      post['likes_count']++;
    });
  }

  void removeLike(var postId) async {
    http.delete("$url/api/v1/posts/$postId/likes",
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    setState(() {
      post['liked'] = false;
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
    return Container();
  }
}
