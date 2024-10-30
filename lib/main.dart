import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Student/Login.dart';
import 'package:biit_project_progress_monitoring_system/Supervisor/SupervisorDashboard.dart';
import 'package:biit_project_progress_monitoring_system/shared_prefs/shared_prefs.dart';
import 'package:flutter/material.dart';

import 'package:biit_project_progress_monitoring_system/Committee/committeeDashboard.dart';
import 'package:biit_project_progress_monitoring_system/Datacell/datacellDashboard.dart';
import 'package:biit_project_progress_monitoring_system/Student/studentDashboard.dart';

import 'Global/global.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DataSharedPreferences().initSharedPreferences();
  var data = await DataSharedPreferences().getUserData();
  if (data.isNotEmpty) {
    userdata = jsonDecode(data);
  }
  runApp(const MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    String? role = userdata?['role'];

    Widget homeWidget;

    switch (role?.toLowerCase()) {
      case 'student':
        homeWidget = const StudentDashboard();
        break;
      case 'datacell':
        homeWidget = const datacellDashboard();
        break;
      case 'committee':
        homeWidget = const committeeDashboard();
        break;
      case 'supervisor':
        homeWidget = const SupervisorDashboard();
        break;
      default:
        homeWidget = const StudentLogin();
    }

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: const Color(0xFF74A2A8),
        scaffoldBackgroundColor: const Color(0xFF74A2A8),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: homeWidget,
    );
  }
}
