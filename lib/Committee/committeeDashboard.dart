import 'package:biit_project_progress_monitoring_system/Committee/navBarItem/dashboardCom.dart';
import 'package:biit_project_progress_monitoring_system/Committee/navBarItem/meetingsCom.dart';
import 'package:biit_project_progress_monitoring_system/Committee/navBarItem/projectAllocationCom.dart';
import 'package:biit_project_progress_monitoring_system/Committee/navBarItem/scheduleMeetingCom.dart';
import 'package:biit_project_progress_monitoring_system/Student/Login.dart';
import 'package:biit_project_progress_monitoring_system/Supervisor/SupervisorDashboard.dart';
import 'package:flutter/material.dart';

class committeeDashboard extends StatefulWidget {
  const committeeDashboard({super.key});

  @override
  State<committeeDashboard> createState() => _committeeDashboardState();
}

class _committeeDashboardState extends State<committeeDashboard> {
  int _selectedIndex = 0;

  static const List<Widget> _widgetOptions = <Widget>[
    dashboardCom(),
    projectAllocationCom(),
    ScheduleMeetingCom(),
    MeetingCom(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  String getTitle() {
    if (_selectedIndex == 0) {
      return "Committee Dashboard";
    } else if (_selectedIndex == 1) {
      return "Project Allocation";
    } else if (_selectedIndex == 2) {
      return "Schedule Meeting";
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
          IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SupervisorDashboard()),
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
            icon: Icon(Icons.person_2_outlined),
            label: 'Project Allocation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule Meeting',
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
