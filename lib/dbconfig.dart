import 'package:flutter/material.dart';
import 'package:qr_attendance/database.dart';

class DBConfig extends StatefulWidget {
  const DBConfig({super.key});

  @override
  State<DBConfig> createState() => _DBConfigState();
}

class _DBConfigState extends State<DBConfig> {
  TextEditingController urlInput = TextEditingController();
  TextEditingController portInput = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Database configuration"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            const Text("URL:"),
            TextField(
              controller: urlInput,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            const Text("Port:"),
            TextField(
              controller: portInput,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            ElevatedButton(
              onPressed: () async {
                try {
                  Database db = Database();

                  await db.getConnection(
                      urlInput.text,
                      int.parse(portInput.text),
                      Database.user,
                      Database.password,
                      Database.db);

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Successfully connected to database!"),
                      ),
                    );
                  }
                } on Exception {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                            "Invalid URL or port! Could not connect to database."),
                      ),
                    );
                  }
                }
              },
              child: const Text("Connect"),
            ),
          ],
        ),
      ),
    );
  }
}
