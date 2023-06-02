String todaysDateFormatted(){
  var dateTime = DateTime.now();

  String year = dateTime.year.toString();

  String month = dateTime.month.toString();
  if(month.length == 1){
    month = '0$month';
  }

  String day = dateTime.day.toString();
  if(day.length == 1){
    day = '0$day';
  }

  String yyyymmdd = year + month + day;

  return yyyymmdd;
}

DateTime createNewHabitDatetimeObject(String yyyymmdd){
  int year = int.parse(yyyymmdd.substring(0,4));
  int month = int.parse(yyyymmdd.substring(4,6));
  int day = int.parse(yyyymmdd.substring(6,8));


  DateTime dateTime = DateTime(year, month, day);

  return dateTime;
}

String convertDatetimeToString(DateTime dateTime){
  var dateTime = DateTime.now();

  String year = dateTime.year.toString();

  String month = dateTime.month.toString();
  if(month.length == 1){
    month = '0$month';
  }

  String day = dateTime.day.toString();
  if(day.length == 1){
    day = '0$day';
  }

  String yyyymmdd = year + month + day;

  return yyyymmdd;
}

