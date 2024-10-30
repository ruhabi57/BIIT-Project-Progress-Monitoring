import 'package:biit_project_progress_monitoring_system/Models/GetTasks.dart';
import 'package:biit_project_progress_monitoring_system/Supervisor/addTaskSup.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../Models/projects.dart';
import 'viewTaskSup.dart';

class viewGroupSup extends StatefulWidget {
  Projects project;
  viewGroupSup({super.key, required this.project});

  @override
  State<viewGroupSup> createState() => _viewGroupSupState();
}

class _viewGroupSupState extends State<viewGroupSup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Group')),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20)),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Gap(30),
                  ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Container(
                            padding: const EdgeInsets.all(8),
                            height: 100,
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
                              builder: (context) => addTasKSup(
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
                                  viewTaskSup(projects: widget.project)),
                        );
                      },
                      child: Text('View Task',
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
