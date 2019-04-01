import 'package:flutter/material.dart';

class CommentPage extends StatefulWidget {
  final token;
  final List<dynamic> commentList;

  CommentPage(this.token, this.commentList);
  @override
  _CommentPageState createState() => _CommentPageState(token, commentList);
}

class _CommentPageState extends State<CommentPage> {
  final token;
  final List<dynamic> commentList;

  _CommentPageState(this.token, this.commentList);
  @override
  Widget build(BuildContext context) {
    //print(commentList);
    return new Scaffold(
        appBar: AppBar(
          title: Text("Comment Page"),
          centerTitle: true,
        ),
        body: ListView.builder(
              itemCount: commentList.length,
              itemBuilder: (BuildContext context, int index) {
                return Comment(commentList[index],token);
              },
            ),
        );
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
  @override
  Widget build(BuildContext context) {
    var creation = DateTime.now().difference(DateTime.parse(comment['created_at']).toLocal());
    //print(now);
    //print(creation);
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            leading: CircleAvatar(backgroundImage: NetworkImage(comment['user']['profile_image_url']),),
            title: Text(comment['text']),
            trailing: Text("$creation"),
            subtitle: Text(getName())),
        ],
      )
    );
  }
}
