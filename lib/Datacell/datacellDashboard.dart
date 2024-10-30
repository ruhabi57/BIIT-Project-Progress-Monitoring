import 'package:biit_project_progress_monitoring_system/Datacell/EnrollStudents.dart';
import 'package:biit_project_progress_monitoring_system/Datacell/DropStudents.dart';
import 'package:biit_project_progress_monitoring_system/Student/Login.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'StudentDetail.dart';

class datacellDashboard extends StatefulWidget {
  const datacellDashboard({super.key});

  @override
  State<datacellDashboard> createState() => _datacellDashboardState();
}

class _datacellDashboardState extends State<datacellDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Datacell'),
        backgroundColor: Colors.grey.shade300,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.notifications,
              size: 35,
            ),
            onPressed: () {},
          ),
          SizedBox(width: 10),
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
      body: Column(
        children: [
          const Gap(30),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                height: 550,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 60,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const EnrollStudents()));
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            // border: Border.all(color: Colors.black, width: 2)),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                spreadRadius: 5,
                                color: Colors.black12,
                              ),
                            ]),
                        child: const Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_2_outlined,
                              size: 35,
                            ),
                            Text("Student Detail")
                          ],
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const dropStudentsList()));
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            // border: Border.all(color: Colors.black, width: 2)),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                spreadRadius: 5,
                                color: Colors.black12,
                              ),
                            ]),
                        child: const Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.verified_outlined,
                              size: 35,
                            ),
                            Text("Enroll Students")
                          ],
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 60,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const RestrictStudent()));
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            //  border: Border.all(color: Colors.black, width: 2),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                spreadRadius: 5,
                                color: Colors.black12,
                              ),
                            ]),
                        child: const Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.no_accounts_outlined, size: 35),
                            Text("Drop Student")
                          ],
                        )),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
