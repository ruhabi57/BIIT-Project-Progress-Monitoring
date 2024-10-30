import 'package:biit_project_progress_monitoring_system/Committee/committeeDashboard.dart';

import '../Global/global.dart';
import '../Student/Login.dart';
import 'chatSup.dart';
import 'navBarItem/dashboardSup.dart';
import 'package:flutter/material.dart';

import 'navBarItem/meetingSup.dart';
import 'navBarItem/requestSup.dart';
import 'navBarItem/scheduleMeetingSup.dart';

class SupervisorDashboard extends StatefulWidget {
  const SupervisorDashboard({super.key});

  @override
  State<SupervisorDashboard> createState() => _SupervisorDashboardState();
}

class _SupervisorDashboardState extends State<SupervisorDashboard> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    dashboardSup(),
    chatSup(),
    scheduleMeetingSup(),
    meetingSup(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String getTitle() {
    if (_selectedIndex == 0) {
      return "Supervisor Dashboard";
    } else if (_selectedIndex == 1) {
      return "Chat";
    } else if (_selectedIndex == 2) {
      return "Schedule Meetings";
    } else {
      return "Meetings";
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
          if (userdata['role'].toString().toLowerCase() == 'committee')
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => committeeDashboard()),
                  );
                },
                icon: Icon(Icons.swap_vert_circle_outlined)),
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StudentLogin()),
                );
              },
              icon: Icon(Icons.logout))
        ],
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
            label: 'Supervisor Dashboard',
            backgroundColor: Color(0xFF74A2A8),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule Meetings',
            backgroundColor: Color(0xFF74A2A8),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.meeting_room_outlined),
            label: 'Meetings',
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
