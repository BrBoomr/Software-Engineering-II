class Clock {
  double _second;
  Clock(this._second);
  
  String getTimeString(){
    Duration time = Duration(seconds: _second.toInt());
    int mins = time.inMinutes;
    int secs = time.inSeconds-(mins*60);
    //return "$mins:$secs";
    String minText = "$mins".padLeft(2, "0");
    String secText = "$secs".padLeft(2, "0");
    return minText+":"+secText;
  }
  Duration getTimeDuration(){
    Duration time = Duration(seconds: _second.toInt());
    int mins = time.inMinutes;
    int secs = time.inSeconds - (mins*60);
    return Duration(minutes: mins, seconds: secs);
  }
  void setTimeDouble(double secs){
    this._second = secs;
  }
  int getTimeInt(){
    return getTimeDuration().inSeconds;
  }
  double getTimeDouble(){
    return getTimeDuration().inSeconds.toDouble();
  }

}