import 'package:flutter/material.dart';
import 'recipe.dart';
import 'countdown.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AeroPress Timer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    List<CoffeeRecipe> _list = getAllRecipes();
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text("AeroPress Timer"),
        centerTitle: true,
      ),
      body: Center(
          child: ListView.builder(
              itemCount: _list.length,
              itemBuilder: (contex, index) {
                return InkWell(
                  onTap: () => {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RecipeDetail(_list[index])),
                        ),
                      },
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.receipt),
                      title: Text(_list[index].name),
                    ),
                  ),
                );
              })),
    );
  }
}

class RecipeDetail extends StatelessWidget {
  final CoffeeRecipe recipe;

  RecipeDetail(this.recipe);

  @override
  Widget build(BuildContext context) {
    int total = 0;
    for (var _s in recipe.steps) {
      total += _s.time;
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(recipe.name),
          centerTitle: true,
        ),
        body: ListView(
          children: <Widget>[
            Container(child: Column(
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Brew Method
                Container(
                  decoration: BoxDecoration(
                    border: Border.all()
                  ),
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  child: Text(recipe.brewMethod),
                ),
                //Coffee Volume
                Container(
                  decoration: BoxDecoration(
                    border: Border.all()
                  ),
                  alignment: Alignment.center,
                    height: 100,
                    width: 100,
                    child: Text("${recipe.coffeeVolumeGrams} \ngrams", textAlign: TextAlign.center,)),
                //Grind Size
                Container(
                  decoration: BoxDecoration(
                    border: Border.all()
                  ),
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  child: Text(recipe.grindSize),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                //Water Volume
                Container(
                  decoration: BoxDecoration(
                    border: Border.all()
                  ),
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  child: Text("${recipe.waterVolumeGrams}\n Grams", textAlign: TextAlign.center,),
                ),
                //Temp
                Container(
                  decoration: BoxDecoration(
                    border: Border.all()
                  ),
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  child: Text("${recipe.temperature}°\nFarenheit", textAlign: TextAlign.center,),
                ),
                //Total Time
                Container(
                  decoration: BoxDecoration(
                    border: Border.all()
                  ),
                  alignment: Alignment.center,
                  height: 100,
                  width: 100,
                  child: Text("$total \nSeconds", textAlign: TextAlign.center,),
                ),
              ],
            ),
            Divider(),
            Text("Steps"),
            //STEPS HERE
            Column(children: _stepList(recipe)),
            FlatButton(
              color: Colors.pink,
              padding: EdgeInsets.only(left: 100, right: 100, top:20,bottom:20),
              onPressed: () => {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TimerScreen(recipe),
                        )),
                  },
              child: Text("Start Timer"),
            ),
          ],
        ))
          ],
            ));
  }
}

List<Widget> _stepList(CoffeeRecipe recipe) {
  List<Widget> allSteps = List<Widget>();
  for (var _step in recipe.steps) {
    allSteps.add(Card(
      child: ListTile(
        title: Text(_step.subtext),
        leading: Text(_step.text),
        trailing: Text("${_step.time}"),
      ),
    ));
  }
  return allSteps;
}
