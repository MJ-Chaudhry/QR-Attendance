import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:qr_attendance/database.dart';
import 'package:qr_attendance/dbconfig.dart';
import 'package:qr_attendance/login.dart';
import 'package:qr_attendance/utils.dart';

Logger logger = Logger();

void main() async {
  final Database db = Database();
  try {
    await db.getConnection(
        "localhost", 3306, Database.user, Database.password, Database.db);
    logger.d("Connected to database!");
  } on Exception {
    logger.e("Could not connect to SQL server!");
  }

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const StartPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("QR Attendance"),
            const Text("Select user:"),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(UserType.student),
                  ),
                );
              },
              child: const Text("Student"),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const Login(UserType.lecturer),
                  ),
                );
              },
              child: const Text("Lecturer"),
            ),
          ],
        ),
      )),
      floatingActionButton: IconButton(
          onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DBConfig(),
              )),
          icon: const Icon(Icons.settings)),
    );
  }
}
