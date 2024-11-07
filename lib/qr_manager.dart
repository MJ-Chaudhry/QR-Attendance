/// QR code manager class.
/// Used for generating the qr code data and parsing it.
library;

import 'package:mysql1/mysql1.dart';
import 'package:qr_attendance/database.dart';
import 'package:qr_attendance/utils.dart';

class QRManager {
  /// Generates the QR code data string from a QRCodeData object.
  static String createCode(QRCodeData data) {
    return "${data.className} ${data.lessonDatetime.toIso8601String()} ${data.lessonID}";
  }

  /// Validates the qr code data string.
  /// Make sure to have the database connected before running this function
  /// as it checks the data against the database in real time.
  static Future<QRCodeData?> validateCode(String qrCode) async {
    List<String> chunks = qrCode.split(" ");

    if (chunks.length != 3) return null;

    String className = chunks[0];
    DateTime? lessonDatetime = DateTime.tryParse(chunks[1]);
    int? lessonID = int.tryParse(chunks[2]);

    Database db = Database();

    // Validate the className.
    List<String> classes = await db.getClasses(matchString: className);
    if (classes.length != 1) return null;

    // Validate the datetime.
    if (lessonDatetime == null) return null;

    // Validate the lessonID.
    if (lessonID == null) return null;

    Results results = await db.conn!.query(
        "select lesson_id from ${className}_details where lesson_id = ?",
        [lessonID]);

    if (results.isEmpty) return null;

    return QRCodeData(className, lessonDatetime, lessonID);
  }
}
