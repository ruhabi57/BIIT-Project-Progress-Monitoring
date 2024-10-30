import 'dart:convert';
import 'package:biit_project_progress_monitoring_system/Global/global.dart';
import 'package:biit_project_progress_monitoring_system/Models/GetTasks.dart';
import 'package:biit_project_progress_monitoring_system/Student/uploadTask.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

class task extends StatefulWidget {
  const task({super.key});

  @override
  State<task> createState() => _taskState();
}

class _taskState extends State<task> {
  List<GetTasks> tasks = [];
  bool loading = true;
  @override
  void initState() {
    getTasks();
    super.initState();
  }

  getTasks() async {
    try {
      String uri =
          '${baseUrl}Tasks/GetTask?groupId=${userdata['group_id']}&role=Student';
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
      body: Column(
        children: [
          const Gap(20),
          Padding(
            padding: const EdgeInsets.all(1.0),
            child: Container(
                height: 600,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                    // color: Colors.grey.shade400,

                    borderRadius: BorderRadius.circular(20)),
                child: ListView.separated(
                    itemCount: tasks.length,
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => uploadTask(
                                        getTasks: tasks[index],
                                      )));
                        },
                        child: Container(
                          height: 110,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            //border: Border.all(color: Colors.black, width: 2),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                spreadRadius: 5,
                                color: Colors.black12,
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(children: [
                                      Gap(5),
                                      Text(
                                        "${tasks[index].task_description.capitalizeFirstLetter()}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w700),
                                      )
                                    ]),
                                    Row(children: [
                                      Icon(Icons.person_outline),
                                      Text(tasks[index].is_from_supervisor
                                          ? "Supervisor"
                                          : "Committee")
                                    ]),
                                    Row(children: [
                                      Icon(Icons.date_range_outlined),
                                      Text(
                                          "Deadline: ${tasks[index].deadline.toString().split(' ').first}")
                                    ]),
                                  ],
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.lock_clock),
                                  Text(tasks[index].task_status)
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    })),
          ),
        ],
      ),
    );
  }
}
