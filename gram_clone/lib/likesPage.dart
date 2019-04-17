import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'userPage.dart';

class LikesPage extends StatefulWidget {
  final token;
  final List<dynamic> likeList;
  final postId;
  LikesPage(this.token, this.likeList, this.postId);
  @override
  _LikesPageState createState() => _LikesPageState(token, likeList, postId);
}

class _LikesPageState extends State<LikesPage> {
  final token;
  final List<dynamic> likeList;
  final postId;
  _LikesPageState(this.token, this.likeList, this.postId);
  @override
  
  Widget build(BuildContext context) {
    print(likeList.length);
    return new Scaffold(
        appBar: AppBar(
          title: Text("Like Page"),
          centerTitle: true,
        ),
        body: ListView.builder(
              itemCount: likeList.length,
              itemBuilder: (BuildContext context, int index) {
                return Like(likeList[index],token);
              },
            ),
        );
  }
}


class Like extends StatelessWidget {
  final like;
  final token;
  Like(this.like, this.token);


  Future<dynamic> getUserDetails(var userId) async {
    var details = await http.get("$url/api/v1/users/$userId",
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    return jsonDecode(details.body);
  }

  void goToUserPage(context, var userId) async {
    var userDetails = await getUserDetails(userId);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UserPage(token, userDetails)));
  }

  @override
  

  Widget build(BuildContext context) {
    
    var creation = DateTime.now().difference(DateTime.parse(like['created_at']).toLocal());
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: InkWell(
              onTap: ()=>{
                goToUserPage(context, like['user']['id'])
              },
              child: CircleAvatar(
              backgroundImage:
                  NetworkImage(like['user']['profile_image_url']),
            )),
            subtitle: Text("Liked: $creation hours ago")),
        ],
      )
    );
  }
}
