import 'package:mysql1/mysql1.dart';
import 'package:qr_attendance/utils.dart';

class Database {
  Database._privateConstructor();

  static const String user = "jchau";
  static const String password = "Primus_17";
  static const String db = "uni_db";

  ConnectionSettings? settings;
  MySqlConnection? conn;

  static final Database _instance = Database._privateConstructor();

  factory Database() {
    return _instance;
  }

  Future<void> getConnection(
      String url, int port, String user, String password, String db) async {
    settings = ConnectionSettings(
      host: url,
      port: port,
      user: user,
      password: password,
      db: db,
    );

    conn = await MySqlConnection.connect(settings!);
  }

  /// Login the student. Returns `true` if the student has been logged in
  /// successfuly or `false` if not.
  Future<bool> loginStudent(int id, String password) async {
    Results results = await conn!.query(
        'select * from students where id = ? and password = ?;',
        [id, password]);

    // Check if student was found in table with matching ID and password.
    if (results.length == 1) {
      return true;
    } else {
      return false;
    }
  }

  /// Login the lecturer. Returns `true` if the lecturer has been logged in
  /// successfuly or `false` if not.
  Future<bool> loginLecturer(int id, String password) async {
    Results results = await conn!.query(
        'select * from lecturers where id = ? and password = ?;',
        [id, password]);

    // Check if student was found in table with matching ID and password.
    if (results.length == 1) {
      return true;
    } else {
      return false;
    }
  }

  /// Returns a list of all classes. `matchString` is used to filter the results.
  Future<List<String>> getClasses({String? matchString}) async {
    Results results = await conn!.query(
      "select * from classes where class_id like ?;",
      ["%${matchString ?? ""}%"],
    );

    List<String> classes = [];

    for (ResultRow row in results) {
      classes.add(row[0]);
    }

    return classes;
  }

  /// Create a new lesson and add it to the class details and attendance table.
  /// Returns the lesson ID of the new lesson.
  Future<int> addLessonToClass(
      String className, DateTime lessonDate, Time lessonDuration) async {
    // To prevent a potential SQL injection using the className variable,
    // make sure the class name exists within the table of classes.
    List<String> classes = await getClasses(matchString: className);

    if (classes.isEmpty) {
      throw Exception("Invalid class name provided and risk of SQL injection!");
    }

    String lessonDateInput =
        "${lessonDate.year}-${lessonDate.month}-${lessonDate.day} ${lessonDate.hour}:${lessonDate.minute}:00";

    String lessonDurationInput =
        "${lessonDuration.hours}:${lessonDuration.minutes}:00";

    Results results =
        await conn!.query("select count(*) from ${className}_details;");

    int lessonID = results.first[0] + 1;

    await conn!.query("insert into ${className}_details values (?, ?, ?);",
        [lessonID, lessonDateInput, lessonDurationInput]);

    await conn!.query(
        "alter table ${className}_attendance add lesson_$lessonID bool not null default false;");

    return lessonID;
  }

  /// Validates whether a student is in a class or not.
  Future<bool> studentInClass(int studentID, String className) async {
    Results results = await conn!.query(
        "select student_id from ${className}_attendance where student_id = ?;",
        [studentID]);

    if (results.isEmpty) return false;

    return true;
  }

  /// Sign attendance for a student.
  ///
  /// This function assumes that the className, lessonDatetime, and lessonID are all
  /// validated from the QR code. Before running this function for security reasons,
  /// make sure to validate the QR code data using the QR code class.
  ///
  /// The studentID is also checked to make sure the student belongs to the class.
  ///
  /// Return `true` on success and `false` on an error.
  Future<bool> markAttendance(
      int studentID, String className, int lessonID) async {
    if (!await studentInClass(studentID, className)) return false;

    await conn!.query(
        "update ${className}_attendance set lesson_$lessonID = 1 where student_id = $studentID;");

    return true;
  }
}
