import 'package:biit_project_progress_monitoring_system/Committee/failStudentsGroups.dart';
import 'package:flutter/material.dart';

import 'addMemberInGroup.dart';
import 'groupsReAllocateSupervisor.dart';

class reAllocateGroup extends StatefulWidget {
  const reAllocateGroup({super.key});

  @override
  State<reAllocateGroup> createState() => _reAllocateGroupState();
}

class _reAllocateGroupState extends State<reAllocateGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Re-Allocation'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60, right: 15, left: 15),
            child: Container(
                height: 500,
                padding: const EdgeInsets.symmetric(horizontal: 30),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const FailStudentsGroups()));
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
                            Icon(Icons.cancel_outlined, size: 35),
                            Text("Fail Students/Groups")
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
                                    const addMemberInGroup()));
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
                              Icons.person_add_alt_1_outlined,
                              size: 35,
                            ),
                            Text("Add Member in Group")
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
                    //                 const projectReAllocation()));
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
                    //     // border: Border.all(color: Colors.black, width: 2)),
                    //     child: const Center(
                    //         child: Column(
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Icon(
                    //           Icons.loop_outlined,
                    //           size: 35,
                    //         ),
                    //         Text("Project Re-Allocation")
                    //       ],
                    //     )),
                    //   ),
                    // ),
                    // const SizedBox(
                    //   height: 40,
                    // ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const groupsReAllocateSupervisor()));
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
                              Icons.loop_outlined,
                              size: 35,
                            ),
                            Text("Re-Allocate Supervisor")
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
