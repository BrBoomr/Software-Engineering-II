import 'package:flutter/material.dart'; //imported flutter material package

class HomePage extends StatefulWidget{ // creating a stateful widget
  @override
  State createState() => new HomePageState(); // creating the state
}

class HomePageState extends State<HomePage>{ 
  var ansStr = "0";

  @override
  Widget build(BuildContext context) { // creating the widget
    return new Scaffold(
      appBar: new AppBar( //defines the content of the Appbar
        title: new Text("Calculator"),
      ),
     body: Container(
        child: Column( //Since we have multiple children arranged vertically, we are using column
                mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Equal vertical space between all the children of column
          children: <Widget>[ // the column widget uses the children property
            Container( // Display Container
              constraints: BoxConstraints.expand( // Creating a boxed container 
                height: Theme.of(context).textTheme.display1.fontSize * 1.1 + 100.0,
              ),
              alignment: Alignment.bottomRight, // Aligning the text to the bottom right of our display screen
              color: Colors.white, // Seting the background color of the container
              child: Text(
                "$ansStr",
                style: TextStyle( // Styling the text
                  fontSize: 50.0,
                  color: Colors.black
                ),
                textAlign: TextAlign.right,
              ),
            ),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                 _button("7",def), // using custom widget _button
                 _button("8",def),
                 _button("9",def),
                 _button("*",def)               
              ],
            ),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                 _button("4",def), // using custom widget _button
                 _button("5",def),
                 _button("6",def),
                 _button("-",def)               
              ],
            ),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                 _button("1",def), // using custom widget _button
                 _button("2",def),
                 _button("3",def),
                 _button("+",def)               
              ],
            ),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                 _button("C",def), // using custom widget _button
                 _button("0",def),
                 _button("=",def),
                 _button("/",def)               
              ],
            ),
          ],
        ),
      )
    );
  }
  Widget _button (String symbol, Function() f){ // Creating a method of return type Widget with symbol and function f as a parameter
    
    return MaterialButton(
      height: 100.0,
      child: Text(symbol,
      style:  TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0)),
      textColor: Colors.black,
      color: Colors.grey[100],
      onPressed: f,
    );
  }
  def(){

  }
  bool isNumeric(String sym){
    if(sym==null){
      return false;
    }
    return double.tryParse(sym) != null || int.tryParse(sym)!=null;
  }
  number(String number){
    //ansStr+=number;
  }
  arithmetic(String op){

  }
}
