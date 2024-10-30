import 'package:biit_project_progress_monitoring_system/Supervisor/gradingSup.dart';
import 'package:biit_project_progress_monitoring_system/Supervisor/restrictedStudentsSup.dart';
import 'package:flutter/material.dart';
import '../fyp0groupSup.dart';
import '../fyp1groupSup.dart';
import '../fyp2groupSup.dart';

class dashboardSup extends StatefulWidget {
  const dashboardSup({super.key});

  @override
  State<dashboardSup> createState() => _dashboardSupState();
}

class _dashboardSupState extends State<dashboardSup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
                height: 600,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    //color: Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    // const SizedBox(
                    //   height: 30,
                    // ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) => const fyp0groupSup()));
                    //   },
                    //   child: Container(
                    //     height: 100,
                    //     width: double.infinity,
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(20),
                    //         //  border: Border.all(color: Colors.black, width: 2),
                    //         boxShadow: const [
                    //           BoxShadow(
                    //             blurRadius: 5,
                    //             spreadRadius: 5,
                    //             color: Colors.black12,
                    //           ),
                    //         ]),
                    //     child: const Center(
                    //         child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Icon(Icons.group_outlined, size: 35),
                    //         Text("FYP-0 Groups")
                    //       ],
                    //     )),
                    //   ),
                    // ),
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const fyp1groupSup()));
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
                              Icons.group_outlined,
                              size: 35,
                            ),
                            Text("FYP-1 Groups")
                          ],
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const fyp2groupSup()));
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                spreadRadius: 5,
                                color: Colors.black12,
                              ),
                            ]),
                        // border: Border.all(color: Colors.black, width: 2)),
                        child: const Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.group_outlined,
                              size: 35,
                            ),
                            Text("FYP-2 Groups")
                          ],
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const restrictedStudentsSup()));
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                spreadRadius: 5,
                                color: Colors.black12,
                              ),
                            ]),
                        //border: Border.all(color: Colors.black, width: 2)),
                        child: const Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.do_not_disturb_alt_outlined,
                              size: 35,
                            ),
                            Text("Restricted Students")
                          ],
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const gradingSup()));
                      },
                      child: Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                spreadRadius: 5,
                                color: Colors.black12,
                              ),
                            ]),
                        //border: Border.all(color: Colors.black, width: 2)),
                        child: const Center(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.abc_outlined,
                              size: 35,
                            ),
                            Text("Grading")
                          ],
                        )),
                      ),
                    )
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
