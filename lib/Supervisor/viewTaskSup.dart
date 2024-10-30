import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Models/projects.dart';
import 'package:flutter/material.dart';

import 'package:biit_project_progress_monitoring_system/Models/GetTasks.dart';
import 'package:http/http.dart' as http;
import '../Global/global.dart';
import 'viewUploadedTaskSup.dart';

class viewTaskSup extends StatefulWidget {
  final Projects projects;

  viewTaskSup({super.key, required this.projects});

  @override
  State<viewTaskSup> createState() => _viewTaskSupState();
}

class _viewTaskSupState extends State<viewTaskSup> {
  bool loading = true;
  List<GetTasks> tasks = [];
  @override
  void initState() {
    super.initState();
    getTasks();
  }

  getTasks() async {
    try {
      String uri =
          '${baseUrl}Tasks/GetTaskByProjectId?projectId=${widget.projects.project_id}';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        for (var e in res) {
          tasks.add(GetTasks.fromMap(e));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.body),
            duration: const Duration(seconds: 3),
          ),
        );
      }
    } catch (e) {
      print(e);
    }
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('View Task')),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 800,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                //color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20)),
            child: ListView.builder(
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => viewUploadedTaskSup(
                                  tasks: tasks[index],
                                )));
                  },
                  child: Container(
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tasks[index].task_description,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(tasks[index].task_status)
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                                "Deadline: ${tasks[index].deadline.toString().split(' ').first}")
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
              itemCount: tasks.length,
            ),
          ),
        ));
  }
}
