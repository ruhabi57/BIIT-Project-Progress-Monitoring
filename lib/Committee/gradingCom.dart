import 'package:biit_project_progress_monitoring_system/Committee/addGradingCom.dart';
import 'package:biit_project_progress_monitoring_system/Committee/calculateGradingCom.dart';
import 'package:biit_project_progress_monitoring_system/Committee/viewGradingCom.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:dropdown_search/dropdown_search.dart';

class gradingCom extends StatefulWidget {
  const gradingCom({super.key});

  @override
  State<gradingCom> createState() => _gradingComState();
}

class _gradingComState extends State<gradingCom> {
  String? selectedStudent;
  String? selectedCriteria;
  String? selectedProject;
  List<String> selectedvalue = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Grading'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, right: 15, left: 15),
            child: Container(
                height: 400,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const viewGradingCom()));
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
                            Icon(Icons.remove_red_eye_outlined, size: 35),
                            Text("View Grading")
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
                                builder: (context) => const AddGradingCom()));
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
                              Icons.add_box_outlined,
                              size: 35,
                            ),
                            Text("Add Grading")
                          ],
                        )),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.push(
                    //         context,
                    //         MaterialPageRoute(
                    //             builder: (context) =>
                    //                 const calculateGradingCom()));
                    //   },
                    //   child: Container(
                    //     height: 100,
                    //     width: double.infinity,
                    //     decoration: BoxDecoration(
                    //         color: Colors.white,
                    //         borderRadius: BorderRadius.circular(20),
                    //         boxShadow: const [
                    //           BoxShadow(
                    //             blurRadius: 5,
                    //             spreadRadius: 5,
                    //             color: Colors.black12,
                    //           ),
                    //         ]),
                    //     //border: Border.all(color: Colors.black, width: 2)),
                    //     child: const Center(
                    //         child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Icon(
                    //           Icons.loop_outlined,
                    //           size: 35,
                    //         ),
                    //         Text("Calculate Grading")
                    //       ],
                    //     )),
                    //   ),
                    // ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
