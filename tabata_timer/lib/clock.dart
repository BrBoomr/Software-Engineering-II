class Clock {
  var minute ,second;
  Clock(this.minute,this.second);

  String getTimeString(){
    return "$minute:$second";
  }
  Duration getTimeDuration(){
    return Duration(minutes: minute, seconds: second);
  }
  double getTimeDouble(){
    return getTimeDuration().inSeconds.toDouble();
  }
  void setTime(var min, var sec){
    this.minute=min;
    this.second=sec;
  }

  void setTimeDouble(double seconds){
    this.minute = (seconds/60) as int;
    this.second = seconds - (minute*60);
  }

}