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
  @override
  Widget build(BuildContext context) {
    var creation = DateTime.now().difference(DateTime.parse(comment['created_at']).toLocal());
    //print(now);
    //print(creation);
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(comment['text']),
            trailing: Text(comment['user_id'].toString()),
            subtitle: Text("Created: $creation hours ago")),
        ],
      )
    );
  }
}
