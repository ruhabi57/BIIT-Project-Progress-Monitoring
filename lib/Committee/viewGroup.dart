import 'package:biit_project_progress_monitoring_system/Committee/addTask.dart';
import 'package:biit_project_progress_monitoring_system/Committee/viewTask.dart';
import 'package:biit_project_progress_monitoring_system/Models/projects.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import 'ViewMeetingComments.dart';
import 'ViewTaskComments.dart';

class viewGroup extends StatefulWidget {
  Projects project;
  viewGroup({super.key, required this.project});

  @override
  State<viewGroup> createState() => _viewGroupState();
}

class _viewGroupState extends State<viewGroup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Group')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Container(
              height: 700,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                children: [
                  Gap(30),
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Container(
                            padding: const EdgeInsets.all(8),
                            height: 80,
                            width: double.infinity,
                            margin: const EdgeInsets.only(bottom: 20),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 5,
                                  spreadRadius: 5,
                                  color: Colors.black12,
                                ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.project.members[index].student
                                          .student_name,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    Text(
                                        'Arid Number: ${widget.project.members[index].student.arid_no}')
                                  ],
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                        'Semester: ${widget.project.members[index].student.semester}'),
                                    Text(
                                        'Platform: ${widget.project.members[index].platform}')
                                  ],
                                ),
                              ],
                            ),
                          ),
                      separatorBuilder: (context, index) => SizedBox(
                            height: 10,
                          ),
                      itemCount: widget.project.members.length),
                  Gap(30),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => addTask(
                                    project_id: widget.project.project_id ?? 0,
                                  )),
                        );
                      },
                      child: Text(
                        'Add Task',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      )),
                  Gap(30),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  viewTask(projects: widget.project)),
                        );
                      },
                      child: Text('View Task',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                  Gap(30),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  const ViewMeetingComments()),
                        );
                      },
                      child: Text('View Meeting Comments',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold))),
                  Gap(30),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ViewTaskComments()),
                        );
                      },
                      child: Text('View Task Comments',
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold)))
                ],
              ),
            ),
          ),
        ));
  }
}
