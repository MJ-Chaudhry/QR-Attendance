import 'package:flutter/material.dart';

class Student extends StatelessWidget {
  const Student({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Student"),
        centerTitle: true,
      ),
      body: const Placeholder(),
    );
  }
}
