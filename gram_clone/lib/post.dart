import 'main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'userPage.dart';
import 'commentsPage.dart';
import 'likesPage.dart';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

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

  Future<dynamic> getLikeList(var postId) async {
    var list = await http.get("$url/api/v1/posts/$postId/likes",
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    return jsonDecode(list.body);
  }

  void goToLikePage(context, var postId) async {
    var likeList = await getLikeList(postId);
    print(likeList.length);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => LikesPage(token, likeList, postId)));
  }

  Future<dynamic> getCommentList(var postId) async {
    var list = await http.get("$url/api/v1/posts/$postId/comments",
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    //print("List: " + list.body);
    return jsonDecode(list.body);
  }

  void goToCommentPage(context, var postId) async {
    var commentList = await getCommentList(postId);
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CommentPage(token, commentList, postId)));
  }

  String getName() {
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
    var userName = post['user_email'].toString();
    print(userName);
    userName = userName
        .replaceFirst('.', ' ')
        .replaceRange(userName.indexOf('@'), userName.lastIndexOf('u') + 1, "");
    List<String> name = userName.split(' ');
    return capitalize(name[0]) + " " + capitalize(name[1]);
  }

  Widget imageContainer() {
    return Container(
        child: Column(
      children: <Widget>[
        Align(
            alignment: Alignment.topLeft,
            child: InkWell(
              onTap: () {
                goToUserPage(context, post['user_id']);
              },
              child: Row(children: <Widget>[
                Container(
                  width: 60.0,
                  height: 60.0,
                  decoration: BoxDecoration(
                      color: Colors.red,
                      image: DecorationImage(
                          image: NetworkImage(post['user_profile_image_url']),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.all(Radius.circular(75.0)),
                      boxShadow: [
                        BoxShadow(blurRadius: 7.0, color: Colors.black)
                      ]),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(getName())
              ]),
            )),
        SizedBox(
          height: 5,
        ),
        Container(
          child: Image.network(post['image_url']),
        )
      ],
    ));
  }

  Widget subbarContainer() {
    var likesCount = post['likes_count'];
    var commentsCount = post['comments_count'];

    List<Widget> barA() {
      return <Widget>[
        SizedBox(
          height: 5,
        ),
        Text(
          getName() + " :   " + post['caption'],
          textAlign: TextAlign.left,
        ),
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          IconButton(
            color: post['liked'] ? Colors.blue : Colors.white,
            icon: Icon(post['liked'] ? Icons.favorite : Icons.favorite_border),
            onPressed: () => {
                  post['liked'] ? removeLike(post['id']) : addLike(post['id']),
                },
          ),
          Text("$likesCount"),
          IconButton(
            icon: Icon(Icons.chat_bubble),
            color: Colors.white,
            onPressed: () => {goToCommentPage(context, post['id'])},
          ),
          Text("$commentsCount"),
        ])
      ];
    }

    List<Widget> barB() {
      var creation = DateTime.parse(post['created_at']).toLocal();
      return <Widget>[
        Align(
            alignment: Alignment.center,
            child: FlatButton(
              child: Column(children: <Widget>[
                Text(
                  "Liked By...",
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("Created: $creation")
              ]),
              onPressed: () => {goToLikePage(context, post['id'])},
            ))
      ];
    }
    
    return Container (
        child: Column(children: <Widget>[
      Column(
        children: barA(),
      ),
      Align(
          alignment: Alignment.topLeft,
          child: Column(
            children: barB(),
          )),
    ]));
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

  Future<dynamic> getLikes(var postId) async {
    var list = await http.get("$url/api/v1/posts/$postId/likes",
        headers: {HttpHeaders.authorizationHeader: "Bearer $token"});
    return jsonDecode(list.body);
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: imageContainer(),
      subtitle: subbarContainer(),
    );
  }
}

class NewPost extends StatefulWidget {
  final token;
  NewPost(this.token);
  @override
  _NewPostState createState() => _NewPostState(token);
}

class _NewPostState extends State<NewPost> {
  File _image;
  final token;

  TextEditingController captionController = TextEditingController();
  _NewPostState(this.token);
  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      _image = image;
    });
  }

  void createPost(String caption) async{
    if(caption.isEmpty){
      return;
    }
    var dio = Dio();
    FormData formData = FormData.from(<String,dynamic>{
      'caption': caption,
      'image': UploadFileInfo(this._image, "image.jpg")
    });

    await dio.post("$url/api/v1/posts",
    data: formData,
    options: Options(headers: {
      "Authorization":"Bearer $token"
    })).then((response){
      print("${response.statusCode}");
    });
    setState(() {
      
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        Center(
        child: _image == null
            ? Column(
              children:<Widget>[
                Text('No image selected.'),
                SizedBox(height:20),
                FloatingActionButton(
                  onPressed: getImage,
                  tooltip: 'Pick Image',
                  child: Icon(Icons.add_a_photo))
              ])
            : Column(children: <Widget>[    
                TextField(
                  controller: captionController,
                  decoration: InputDecoration(
                    hintText: "Caption",
                    contentPadding: const EdgeInsets.all(20)
                  ),
                  onSubmitted: (caption) => createPost(caption),
                ),
                Container(
                  constraints: BoxConstraints(maxHeight: 350),
                  child:  Image.file(_image),),
        FloatingActionButton(
        onPressed: getImage,
        tooltip: 'Pick Image',
        child: Icon(Icons.add_a_photo),
      ),
            ],)
      ),
      ],
    );
  }
}