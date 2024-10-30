import 'package:biit_project_progress_monitoring_system/Committee/fyp0group.dart';
import 'package:biit_project_progress_monitoring_system/Committee/fyp1group.dart';
import 'package:biit_project_progress_monitoring_system/Committee/fyp2group.dart';
import 'package:biit_project_progress_monitoring_system/Committee/gradingCom.dart';
import 'package:biit_project_progress_monitoring_system/Committee/reAllocateGroup.dart';
import 'package:biit_project_progress_monitoring_system/Committee/restrictedStudents.dart';
import 'package:biit_project_progress_monitoring_system/Committee/supervisorPerformance.dart';
import 'package:biit_project_progress_monitoring_system/Datacell/EnrollStudents.dart';
import 'package:biit_project_progress_monitoring_system/Datacell/StudentDetail.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../progressGraph.dart';

class dashboardCom extends StatefulWidget {
  const dashboardCom({super.key});

  @override
  State<dashboardCom> createState() => _dashboardComState();
}

class _dashboardComState extends State<dashboardCom> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Gap(10),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: SingleChildScrollView(
              child: Container(
                height: 600,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                    //color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const fyp1group()));
                          },
                          child: Container(
                            height: 100,
                            width: 120,
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
                                Icon(Icons.group_outlined, size: 35),
                                Text("FYP-1 Groups")
                              ],
                            )),
                          ),
                        ),
                        Gap(40),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const fyp2group()));
                          },
                          child: Container(
                            height: 100,
                            width: 120,
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
                                Icon(Icons.group_outlined, size: 35),
                                Text("FYP-2 Groups")
                              ],
                            )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
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
                            width: 120,
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
                                Icon(Icons.groups_2_outlined, size: 35),
                                Text("Enroll Students")
                              ],
                            )),
                          ),
                        ),
                        Gap(40),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const reAllocateGroup()));
                          },
                          child: Container(
                            height: 100,
                            width: 120,
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
                                Icon(Icons.loop_outlined, size: 35),
                                Text("Re-Allocation")
                              ],
                            )),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const gradingCom()));
                          },
                          child: Container(
                            height: 100,
                            width: 120,
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
                                Icon(Icons.abc_outlined, size: 35),
                                Text("Grading")
                              ],
                            )),
                          ),
                        ),
                        Gap(40),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const restrictedStudents()));
                              },
                              child: Container(
                                height: 100,
                                width: 120,
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
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.do_not_disturb_alt_outlined,
                                        size: 35),
                                    Text("Restrict Student")
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Gap(40),
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ProgressGraph()));
                          },
                          child: Container(
                            height: 100,
                            width: 120,
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
                                Icon(Icons.auto_graph_outlined, size: 35),
                                Text("Progress Graph")
                              ],
                            )),
                          ),
                        ),
                        Gap(40),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const supervisorPerformnce()));
                          },
                          child: Container(
                            height: 100,
                            width: 120,
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
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.person_2_outlined, size: 35),
                                Text("Supervisor\nPerformace")
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
