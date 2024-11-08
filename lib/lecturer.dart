import 'package:flutter/material.dart';

class Lecturer extends StatelessWidget {
  const Lecturer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Lecturer"),
        centerTitle: true,
      ),
      body: const Placeholder(),
    );
  }
}
