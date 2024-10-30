import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../Models/GetTasks.dart';
import 'AddRemarksCom.dart';

class viewUploadedTask extends StatefulWidget {
  final GetTasks tasks;
  viewUploadedTask({super.key, required this.tasks});

  @override
  State<viewUploadedTask> createState() => _viewUploadedTaskState();
}

class _viewUploadedTaskState extends State<viewUploadedTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Uploaded Task')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(20)),
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Row(
                  children: [
                    Gap(10),
                    Column(
                      children: [
                        Text(
                          'Description:',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ],
                ),
                Gap(10),
                Container(
                    padding: EdgeInsets.all(8),
                    height: 60,
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
                    child: Center(
                        child: Text(
                      widget.tasks.task_description,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ))),
                Gap(30),
                Row(
                  children: [
                    Gap(10),
                    Column(
                      children: [
                        Text(
                          'File Name:',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ],
                ),
                Gap(10),
                Container(
                    padding: EdgeInsets.all(8),
                    height: 60,
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
                    child: Text(
                      widget.tasks.file_name,
                      style: TextStyle(fontSize: 18),
                    )),
                Gap(30),
                ElevatedButton(
                  child: Text("Download",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  onPressed: () {},
                ),
                Gap(30),
                ElevatedButton(
                  child: Text(
                    "Remarks",
                    style: TextStyle(
                        color: Colors.black, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AddRemarksCom()));
                  },
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
