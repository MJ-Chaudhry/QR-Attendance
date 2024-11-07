import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mysql1/mysql1.dart';
import 'package:qr_attendance/database.dart';

import 'test_configs.dart';

final Logger logger = Logger();

void main() {
  logger.i("""
Make sure to run these tests when connected to a database that is configured using 
the `uni_db.sql` file. If you want to re-run the test, make sure to recreate the database again.
""");

  test(
    "Test database connection and return students table",
    () async {
      Database db = Database();

      await db.getConnection(host, port, user, password, dbName);

      Results results = await db.conn!.query("select * from students;");
      expect(
        results.fields.length,
        2,
      ); // Check that the results contain 2 fields.
    },
  );

  group(
    "Student login tests: success, invalid password, and incorrect user",
    () {
      test("Succesful login test", () async {
        Database db = Database();

        await db.getConnection(host, port, user, password, dbName);

        bool loggedIn = await db.loginStudent(studentID, studentPassword);

        expect(loggedIn, true);
      });

      test("Invalid password test", () async {
        Database db = Database();

        await db.getConnection(host, port, user, password, dbName);

        bool loggedIn =
            await db.loginStudent(studentID, "this is an incorrect password");

        expect(loggedIn, false);
      });

      test("Incorrect user test", () async {
        Database db = Database();

        await db.getConnection(host, port, user, password, dbName);

        bool loggedIn = await db.loginStudent(000000, studentPassword);

        expect(loggedIn, false);
      });
    },
  );

  group(
    "Lecturer login tests: success, invalid password, and incorrect user",
    () {
      test("Succesful login test", () async {
        Database db = Database();

        await db.getConnection(host, port, user, password, dbName);

        bool loggedIn = await db.loginLecturer(lecturerID, lecturerPassword);

        expect(loggedIn, true);
      });

      test("Invalid password test", () async {
        Database db = Database();

        await db.getConnection(host, port, user, password, dbName);

        bool loggedIn =
            await db.loginLecturer(lecturerID, "this is an incorrect password");

        expect(loggedIn, false);
      });

      test("Incorrect user test", () async {
        Database db = Database();

        await db.getConnection(host, port, user, password, dbName);

        bool loggedIn = await db.loginLecturer(000000, lecturerPassword);

        expect(loggedIn, false);
      });
    },
  );

  group("Query all classes tests", () {
    test("Get list of all classes", () async {
      Database db = Database();

      await db.getConnection(host, port, user, password, dbName);

      List<String> classes = await db.getClasses();

      expect(classes.length, 2);
    });

    test("Get list of classes using filter", () async {
      Database db = Database();

      await db.getConnection(host, port, user, password, dbName);

      List<String> classes = await db.getClasses(matchString: "ICS2202");

      expect(classes.length, 1);
    });

    test("Test with non-existent class", () async {
      Database db = Database();

      await db.getConnection(host, port, user, password, dbName);

      List<String> classes =
          await db.getClasses(matchString: "non-existent-class");

      expect(classes.length, 0);
    });
  });

  group("Adding new lessons to a class", () {
    test("Add a new lesson to the class", () async {
      Database db = Database();

      await db.getConnection(host, port, user, password, dbName);

      int lessonID =
          await db.addLessonToClass(className, lessonDatetime, lessonDuration);

      Results results =
          await db.conn!.query("select * from ${className}_attendance;");

      expect(results.fields.last.name, "lesson_$lessonID");
    });

    test("Test for invalid class name", () async {
      Database db = Database();

      await db.getConnection(host, port, user, password, dbName);

      var lessonID = db.addLessonToClass(
          "invalid_class_name", lessonDatetime, lessonDuration);
      await expectLater(lessonID, throwsA(isA<Exception>()));
    });
  });

  group("Test if student belongs to a class", () {
    test("Valid student test", () async {
      Database db = Database();

      await db.getConnection(host, port, user, password, dbName);

      bool valid = await db.studentInClass(studentID, className);

      expect(valid, true);
    });

    test("Invalid student test", () async {
      Database db = Database();

      await db.getConnection(host, port, user, password, dbName);

      bool valid = await db.studentInClass(secondStudentID, className);

      expect(valid, false);
    });
  });

  group("Mark attendance tests", () {
    test("Mark attendance test", () async {
      Database db = Database();

      await db.getConnection(host, port, user, password, dbName);

      bool success = await db.markAttendance(studentID, className, 2);

      expect(success, true);

      Results results = await db.conn!.query(
          "select lesson_2 from ${className}_attendance where student_id = $studentID;");

      for (ResultRow row in results) {
        expect(row[0], 1);
      }
    });

    test("Invalid student in class", () async {
      Database db = Database();

      await db.getConnection(host, port, user, password, dbName);

      bool success = await db.markAttendance(secondStudentID, className, 2);

      expect(success, false);
    });
  });
}
