import 'package:biit_project_progress_monitoring_system/Student/navBarItem/chat.dart';
import 'package:biit_project_progress_monitoring_system/Student/navBarItem/dashboard.dart';
import 'package:biit_project_progress_monitoring_system/Student/navBarItem/meeting.dart';
import 'package:biit_project_progress_monitoring_system/Student/navBarItem/request.dart';
import 'package:biit_project_progress_monitoring_system/Student/navBarItem/task.dart';
import 'package:biit_project_progress_monitoring_system/Student/Login.dart';
import 'package:flutter/material.dart';

import '../shared_prefs/shared_prefs.dart';

class StudentDashboard extends StatefulWidget {
  const StudentDashboard({Key? key}) : super(key: key);

  @override
  State<StudentDashboard> createState() => _StudentDashboardState();
}

class _StudentDashboardState extends State<StudentDashboard> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    dashboard(),
    Chat(),
    Request(),
    meeting(),
    task(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String getTitle() {
    if (_selectedIndex == 0) {
      return "Dashboard";
    } else if (_selectedIndex == 1) {
      return "Chat";
    } else if (_selectedIndex == 2) {
      return "Request";
    } else if (_selectedIndex == 3) {
      return "Meetings";
    } else {
      return "Tasks";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(getTitle()),
        backgroundColor: Colors.grey.shade300,
        actions: <Widget>[
          SizedBox(width: 10),
          IconButton(
              onPressed: () async {
                await DataSharedPreferences().setUserData('');
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => StudentLogin()),
                );
              },
              icon: Icon(Icons.logout))
        ],
        // leading: IconButton(
        //   icon: Icon(Icons.logout),
        //   onPressed: () {
        //     Navigator.push(context,
        //         MaterialPageRoute(builder: (context) => StudentLogin()));
        //   },
        // ),
      ),
      backgroundColor: Color(0xFF74A2A8),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Dashboard',
            backgroundColor: Color(0xFF74A2A8),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_add),
            label: 'Request',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Meetings',
            backgroundColor: Color(0xFF74A2A8),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Tasks',
            backgroundColor: Color(0xFF74A2A8),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Color(0xFF74A2A8),
        backgroundColor: Colors.grey.shade300,
        onTap: _onItemTapped,
      ),
    );
  }
}
