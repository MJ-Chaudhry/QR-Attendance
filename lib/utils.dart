/// Reusable classes and functions.
library;

enum UserType {
  student,
  lecturer
}

class Time {
  int hours;
  int minutes;
  int seconds;

  Time({this.hours = 0, this.minutes = 0, this.seconds = 0});
}
