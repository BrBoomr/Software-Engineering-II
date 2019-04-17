class Clock {
  var minute ,second;
  Clock(this.minute,this.second);

  String getTimeString(){
    return "$minute:$second";
  }
  Duration getTimeDuration(){
    return Duration(minutes: minute, seconds: second);
  }

  void setMinute(var min){
    this.minute=min;
  }
  void setSeconds(var sec){
    this.second=sec;
  }

}