import 'package:flutter/material.dart';
import 'package:qr_attendance/database.dart';
import 'package:qr_attendance/lecturer.dart';
import 'package:qr_attendance/student.dart';
import 'package:qr_attendance/utils.dart';

class Login extends StatefulWidget {
  const Login(this.userType, {super.key});

  final UserType userType;

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final idController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "${widget.userType == UserType.student ? "Student" : "Lecturer"} login",
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: idController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "ID Number",
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "Password",
                ),
                obscureText: true,
                autocorrect: false,
              ),
              const SizedBox(
                height: 18,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    int? id = int.tryParse(idController.text);

                    if (id == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Invalid ID!"),
                        ),
                      );
                      return;
                    }

                    Database db = Database();
                    bool loginSuccessfull = false;

                    if (widget.userType == UserType.student) {
                      loginSuccessfull = await db.loginStudent(
                        id,
                        passwordController.text,
                      );
                    } else {
                      loginSuccessfull = await db.loginLecturer(
                        id,
                        passwordController.text,
                      );
                    }

                    if (context.mounted) {
                      if (!loginSuccessfull) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Incorrect login details!"),
                          ),
                        );
                        return;
                      }

                      Navigator.popUntil(
                        context,
                        (route) => false,
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              widget.userType == UserType.student
                                  ? const Student()
                                  : const Lecturer(),
                        ),
                      );
                    }
                  },
                  child: const Text("Login"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
