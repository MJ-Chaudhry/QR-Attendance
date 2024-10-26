import 'package:flutter_test/flutter_test.dart';
import 'package:logger/logger.dart';
import 'package:mysql1/mysql1.dart';
import 'package:qr_attendance/database.dart';

import 'test_configs.dart';

final Logger logger = Logger();

void main() {
  test(
    "Test database connection and return students table",
    () async {
      Database db = Database();

      await db.getConnection(
        host,
        port,
        user,
        password,
        dbName,
      );

      Results results = await db.conn!.query("select * from students;");
      expect(
        results.fields.length,
        2,
      ); // Check that the results contain 2 fields.
    },
  );
}
