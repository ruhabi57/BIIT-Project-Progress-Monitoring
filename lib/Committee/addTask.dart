import 'dart:io';

import 'package:biit_project_progress_monitoring_system/Committee/committeeDashboard.dart';
import 'package:biit_project_progress_monitoring_system/Global/global.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class addTask extends StatefulWidget {
  int project_id;
  addTask({super.key, required this.project_id});

  @override
  State<addTask> createState() => _addTaskState();
}

class _addTaskState extends State<addTask> {
  bool isLoading = false;
  File? _image;
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  String? _selectedDate;

  TextEditingController detailController = TextEditingController();
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        _selectedDate = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  addTask() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (_image == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Upload file')));
        return;
      }
      var url = baseUrl + "Tasks/AddTask";

      var data = FormData.fromMap({
        "isStudent": false,
        "fileUrl": await MultipartFile.fromFile(_image!.path),
        "project_id": widget.project_id,
        "deadline": _selectedDate.toString(),
        "task_desc": detailController.text,
        "isFromSupervisor": false,
        "toSupervisor": false,
      });
      var response = await Dio().post(
        url,
        options: Options(headers: {'Content-Type': "application/json"}),
        data: data,
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.data)));
      Navigator.pop(
          context,
          MaterialPageRoute(
            builder: (context) => committeeDashboard(),
          ));
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add Task')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 600,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20)),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Gap(10),
                  Column(
                    children: [
                      Text(
                        'Task Detail:',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ],
              ),
              Gap(10),
              Container(
                padding: EdgeInsets.all(8),
                height: 150,
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
                child: CustomPaint(
                  child: TextField(
                    maxLines: null,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Task Details',
                    ),
                    onChanged: (text) {},
                    controller: detailController,
                  ),
                ),
              ),
              Column(children: [
                Gap(20),
                Row(children: [
                  Gap(10),
                  Column(
                    children: [
                      Text(
                        'Upload File:',
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                ]),
                Column(
                  children: [
                    Gap(10),
                    Row(
                      children: [
                        Gap(10),
                        Column(
                          children: [
                            Container(
                                height: 60,
                                width: 300,
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
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Gap(10),
                                    SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.3,
                                        child: Text(
                                          _image != null
                                              ? _image!.path.split('/').last
                                              : '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                    Icon(Icons.file_open_outlined),
                                    Gap(10),
                                    ElevatedButton(
                                        onPressed: () {
                                          _getImage();
                                        },
                                        child: Text(
                                          'Choose File',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15),
                                        ))
                                  ],
                                ))
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ]),
              Gap(30),
              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Select Deadline:',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              Gap(30),
              Container(
                  padding: EdgeInsets.all(8),
                  height: 60,
                  width: 350,
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _selectedDate != null
                          ? Text(
                              _selectedDate!,
                              style: TextStyle(fontSize: 16),
                            )
                          : Container(),
                      IconButton(
                        icon: Icon(Icons.calendar_month_outlined),
                        onPressed: () => _selectDate(context),
                      ),
                    ],
                  )),
              Gap(30),
              Gap(30),
              isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: addTask,
                      child: Text(
                        'Add',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ))
            ]),
          ),
        ),
      ),
    );
  }
}
