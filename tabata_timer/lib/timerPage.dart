import 'package:flutter/material.dart';

class TimerPage extends StatefulWidget {
  final Map<String, int> valueSet;

  TimerPage(this.valueSet);

  @override
  _TimerPageState createState() => _TimerPageState(valueSet);
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
  final Map<String, int> valueSet;
  _TimerPageState(this.valueSet);

  AnimationController animationController;

  int currentStep = 0;
  int currentRound = 0;
  List<CurrentTimer> timerList = <CurrentTimer>[];
  int totalRounds = 0;
  int totalSteps = 0;
  bool complete = false;

  String get timerString {
    Duration duration =
        animationController.duration * animationController.value;
    return '${(duration.inSeconds)}';
  }

  @override
  void initState() {
    super.initState();
    currentStep = 0;
    totalRounds = valueSet['_numRounds'];
    timerList.add(CurrentTimer("Prep", valueSet["_prepTime"]));
    for (int x = 1; x < totalRounds; x++) {
      timerList.add(CurrentTimer("Work", valueSet["_workTime"]));
      timerList.add(CurrentTimer("Rest", valueSet["_restTime"]));
    }
    timerList.add(CurrentTimer("Work", valueSet["_workTime"]));
    totalSteps = timerList.length;

    print("Total Steps: $totalSteps");
    print("Total Rounds: $totalRounds");
    animationController = AnimationController(
        vsync: this, duration: Duration(seconds: timerList[currentStep].time));
    animationController.reverse(
        from:
            animationController.value == 0.0 ? 1.0 : animationController.value);
  }

  bool timerFinished() {
    return animationController.value == 0;
  }

  bool onLastRound() {
    return currentRound == totalRounds;
  }

  bool finishedAllSteps() {
    return timerFinished() && onLastRound();
  }

  void restartTimer() {
    if (currentStep % 2 == 1) {
      currentRound++;
    }
    animationController.duration =
        Duration(seconds: timerList[currentStep].time);
    animationController.reverse(
        from:
            animationController.value == 0.0 ? 1.0 : animationController.value);
  }

  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(centerTitle: true, title: Text("Timer")),
        body: AnimatedBuilder(
            animation: animationController,
            builder: (BuildContext context, Widget child) {
              if (finishedAllSteps()){
                animationController.dispose();
              }
              if (timerFinished() && !onLastRound()) {
                currentStep += 1;
                restartTimer();
              }
              return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(timerList[currentStep].title,
                          style: TextStyle(color: timerList[currentStep].title == "Work" ? Colors.red[400] : Colors.blue, 
                          fontSize: 80,)),
                      Text(timeText(int.parse(timerString)),
                          style: TextStyle(fontSize: 130)),
                      Text("$currentRound / ${valueSet['_numRounds']}",
                          style: TextStyle(fontSize: 65)),
                      Text(
                        finishedAllSteps() ? "Complete!" : " ",
                        style: TextStyle(color: Colors.green, fontSize: 40),
                      ),
                    ]),
              );
            }));
  }
}

class CurrentTimer {
  String title;
  int time;
  bool paused = false;
  CurrentTimer(this.title, this.time);
}

String timeText(int secs) {
  int min, sec;
  min = secs ~/ 60;
  sec = secs - (min * 60);
  String minText = "$min".padLeft(2, "0");
  String secText = "$sec".padLeft(2, "0");
  return minText + ":" + secText;
}
