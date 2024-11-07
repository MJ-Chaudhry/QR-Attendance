/// Reusable classes and functions.
library;

enum UserType { student, lecturer }

class Time {
  int hours;
  int minutes;
  int seconds;

  Time({this.hours = 0, this.minutes = 0, this.seconds = 0});
}

class QRCodeData {
  String className;
  DateTime lessonDatetime;
  int lessonID;

  QRCodeData(this.className, this.lessonDatetime, this.lessonID);
}
