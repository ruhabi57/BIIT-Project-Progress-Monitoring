import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Global/global.dart';
import 'package:biit_project_progress_monitoring_system/Supervisor/SupervisorDashboard.dart';
import 'package:biit_project_progress_monitoring_system/shared_prefs/shared_prefs.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:biit_project_progress_monitoring_system/Committee/committeeDashboard.dart';
import 'package:biit_project_progress_monitoring_system/Datacell/datacellDashboard.dart';
import 'package:biit_project_progress_monitoring_system/Student/studentDashboard.dart';

class StudentLogin extends StatefulWidget {
  const StudentLogin({Key? key}) : super(key: key);

  @override
  State<StudentLogin> createState() => _StudentLoginState();
}

class _StudentLoginState extends State<StudentLogin> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              // SizedBox(height: 16),
              // Text('Loading...'),
            ],
          ),
        );
      },
    );
  }

  Future login(String username, String pass) async {
    showLoadingDialog(context);
    try {
      String uri = '${baseUrl}AUTH/Login?username=$username&password=$pass';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        userdata = jsonDecode(response.body);
        if (userdata != null) {
          navigate(userdata['role']);
          await DataSharedPreferences().setUserData(jsonEncode(userdata));
        }
      } else {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.body),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
      Navigator.pop(context);
    }
  }

  navigate(String role) {
    Navigator.pop(context);
    if (role.toLowerCase() == 'student') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const StudentDashboard()),
      );
    } else if (role.toLowerCase() == 'datacell') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const datacellDashboard()),
      );
      // } else if (role.toLowerCase() == 'committee') {
      //   showDialog(
      //       context: context,
      //       builder: (context) {
      //         return AlertDialog(
      //           title: Text('Do you want to login as Committee or Supervisor'),
      //           actions: [
      //             TextButton(
      //                 onPressed: () {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => const committeeDashboard()),
      //                   );
      //                 },
      //                 child: Text('Committee')),
      //             TextButton(
      //                 onPressed: () {
      //                   Navigator.push(
      //                     context,
      //                     MaterialPageRoute(
      //                         builder: (context) => const SupervisorDashboard()),
      //                   );
      //                 },
      //                 child: Text('Supervisor'))
      //           ],
      //         );
      //       });
    } else if (role.toLowerCase() == 'supervisor') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SupervisorDashboard()),
      );
    } else if (role.toLowerCase() == 'committee') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const committeeDashboard()),
      );
    } else if (role.toLowerCase() == 'director') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const committeeDashboard()),
      );
    }
    usernameController.clear();
    passwordController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Login Successfull'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: (const Color(0xFF74A2A8)),
      body: SingleChildScrollView(
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 60.0),
                          child: ClipOval(
                            child: Image.asset(
                              'assets/barani_logo.jpeg',
                              height: 110,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 15.0,
                        ),
                        const Text(
                          'Barani Institute Of\nInformation Technology',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 110.0,
                    ),
                    const Text(
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 24.0,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Login to continue your Account',
                      style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 50.0,
                    ),
                    Center(
                      child: Container(
                        width: 400,
                        // height: 200,
                        padding: const EdgeInsets.all(30),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text("Username"),
                            Container(
                              //margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: TextField(
                                controller: usernameController,
                                decoration: const InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                ),
                              ),
                            ),
                            const Text("Password"),
                            Container(
                              // margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: TextField(
                                controller: passwordController,
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  filled: true,
                                  fillColor: Colors.white,
                                  suffixIcon: IconButton(
                                    icon: Icon(
                                      _obscureText
                                          ? Icons.visibility_off
                                          : Icons.visibility,
                                      color: _obscureText
                                          ? Colors.black
                                          : Colors.black,
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        _obscureText = !_obscureText;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  if (usernameController.text.isNotEmpty &&
                                      passwordController.text.isNotEmpty) {
                                    login(usernameController.text,
                                        passwordController.text);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Please enter username/pasword'),
                                        duration: Duration(seconds: 3),
                                      ),
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                  shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                  ),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          const Color(0xFF74A2A8)),
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                ),
                                child: const Text('LOGIN'),
                              ),
                            ),
                            const Center(
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
