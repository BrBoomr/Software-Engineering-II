import 'package:flutter/material.dart';

class LikesPage extends StatefulWidget {
  final token;
  final List<dynamic> likeList;

  LikesPage(this.token, this.likeList);
  @override
  _LikesPageState createState() => _LikesPageState(token, likeList);
}

class _LikesPageState extends State<LikesPage> {
  final token;
  final List<dynamic> likeList;

  _LikesPageState(this.token, this.likeList);
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
  @override
  Widget build(BuildContext context) {

    var creation = DateTime.now().difference(DateTime.parse(like['created_at']).toLocal());
    //print(now);
    //print(creation);
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(like['user_id'].toString()),
            subtitle: Text("Liked: $creation hours ago")),
        ],
      )
    );
  }
}
