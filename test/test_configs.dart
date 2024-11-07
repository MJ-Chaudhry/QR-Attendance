/// Configuration variables for tests.
/// Edit these variables first before running the tests, for example the
/// username, password, and host url for the database connection.
library;

import 'package:qr_attendance/utils.dart';

const String host = "localhost";
const int port = 3306;
const String user = "jchau";
const String password = "Primus_17";
const String dbName = "uni_db";

// Student details for login tests.
const int studentID = 166335;
const String studentPassword = "Password";

// Lecturer details for login tests.
const int lecturerID = 123456;
const String lecturerPassword = "Password";

// Class details
const String className = "ICS2202_BICS2B";
final DateTime lessonDatetime = DateTime(2024, 10, 30, 8, 15);
final Time lessonDuration = Time(hours: 2);
