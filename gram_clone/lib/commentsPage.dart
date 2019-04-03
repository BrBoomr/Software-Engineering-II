import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'main.dart';
import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'userPage.dart';

class CommentPage extends StatefulWidget {
  final token;
  final List<dynamic> commentList;
  final postId;

  CommentPage(this.token, this.commentList, this.postId);
  @override
  _CommentPageState createState() => _CommentPageState(token, commentList, postId);
}

class _CommentPageState extends State<CommentPage> {
  final token;
  List<dynamic> commentList;
  final postId;
  var commentController = TextEditingController();
_CommentPageState(this.token, this.commentList, this.postId);

  void postComment(String comment) async{
    http.post("$url/api/v1/posts/$postId/comments?text=$comment",
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    var list =  await http.get("$url/api/v1/posts/$postId/comments",
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    commentList = jsonDecode(list.body);
    setState((){
      
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text("Comment Page"),
          centerTitle: true,
        ),
        body: Container(
          child: Column(children: <Widget>[
            TextField(
              controller: commentController,
              decoration: InputDecoration(
                  hintText: "Leave a comment...",
                  contentPadding: const EdgeInsets.all(20)),
              onSubmitted: (comment)=>{
                postComment(comment)
              },
              ),
              
            Expanded(
              child: ListView.builder(
              itemCount: commentList.length,
              itemBuilder: (BuildContext context, int index) {
                return Comment(commentList[index], token);
              },
            ))
          ]),
        ));
  }
}

class Comment extends StatelessWidget {
  final comment;
  final token;
  Comment(this.comment, this.token);

  String getName() {
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
    var userName = comment['user']['email'].toString();
    print(userName);
    userName = userName
        .replaceFirst('.', ' ')
        .replaceRange(userName.indexOf('@'), userName.lastIndexOf('u') + 1, "");
    List<String> name = userName.split(' ');
    return capitalize(name[0]) + " " + capitalize(name[1]);
  }
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
    var creation = DateTime.now()
        .difference(DateTime.parse(comment['created_at']).toLocal());
    return Container(
        child: Column(
      children: <Widget>[
        ListTile(
            leading: InkWell(
              onTap: ()=>{
                goToUserPage(context, comment['user']['id'])
              },
              child: CircleAvatar(
              backgroundImage:
                  NetworkImage(comment['user']['profile_image_url']),
            )),
            title: Text(comment['text']),
            trailing: Text("$creation"),
            subtitle: Text(getName())),
      ],
    ));
  }
}
