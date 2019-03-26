import 'package:flutter/material.dart';

class UserPage extends StatelessWidget {
  final token;
  final userDetails;
  UserPage(this.token, this.userDetails);

  String getName(){
    String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
    var userName = userDetails['email'].toString();
    userName = userName.replaceFirst('.', ' ').replaceRange(userName.indexOf('0'), userName.lastIndexOf('u')+1, "");
    List<String> name = userName.split(' ');
    return capitalize(name[0]) +  " " + capitalize(name[1]);
  }
  @override
  Widget build(BuildContext context) {
    var userName = getName();
    return new Scaffold(
      appBar: AppBar(
        title: Text(userName + " Page")
      ),
      body: new Stack(
      children: <Widget>[
        ClipPath(
          child: Container(color: Colors.black.withOpacity(0.8)),
          clipper: GetClipper(),
        ),
        Positioned(
            width: 350.0,
            top: MediaQuery.of(context).size.height / 5,
            child: Column(
              children: <Widget>[
                Container(
                    width: 150.0,
                    height: 150.0,
                    decoration: BoxDecoration(
                        color: Colors.red,
                        image: DecorationImage(
                            image: NetworkImage(
                                userDetails['profile_image_url']),
                            fit: BoxFit.cover),
                        borderRadius: BorderRadius.all(Radius.circular(75.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 7.0, color: Colors.black)
                        ])),
                SizedBox(height: 30.0),
                Text(
                  userName,
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                SizedBox(height: 15.0),
                Text(
                  userDetails["bio"] as String,
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Montserrat'),
                ),
                
              ],
            ))
      ],
    ));
  }
}

class GetClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = new Path();
    path.lineTo(0.0, size.height / 1.9);
    path.lineTo(size.width + 125, 0.0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
