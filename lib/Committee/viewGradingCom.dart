import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Student/grading.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import '../Models/projects.dart';
import 'package:biit_project_progress_monitoring_system/Global/global.dart';

class viewGradingCom extends StatefulWidget {
  const viewGradingCom({super.key});

  @override
  State<viewGradingCom> createState() => _viewGradingComState();
}

class _viewGradingComState extends State<viewGradingCom> {
  bool loading = true;
  List<Student> students = [];
  List<Projects> projects = [];
  List<dynamic> grades = [];
  Projects? selectedProject;
  int? selectedStudent;

  Future<void> getAllAssignProjects() async {
    setState(() {
      loading = true;
    });

    try {
      String uri = '${baseUrl}AssignProject/GetAllAssignProjects';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          projects =
              responseData.map((data) => Projects.fromMap(data)).toList();
          loading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.body),
            duration: const Duration(seconds: 3),
          ),
        );
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });
    }
  }

  Future<void> getGroupdetailsByProject() async {
    setState(() {
      loading = true;
    });

    try {
      String uri =
          '${baseUrl}AssignProject/GetGroupdetailsByProject?project_id=${selectedProject!.project_id}';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        students.clear();
        var responseData = jsonDecode(response.body);
        for (var element in responseData['members']) {
          students.add(Student.fromMap(element['user']['student']));
        }

        setState(() {
          loading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.body),
            duration: const Duration(seconds: 3),
          ),
        );
        setState(() {
          loading = false;
        });
      }
    } catch (e) {
      print(e);
      setState(() {
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getAllAssignProjects();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Grading')),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 60, bottom: 20),
        child: SingleChildScrollView(
          child: Container(
            height: 500,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Gap(20),
                Gap(20),
                Column(
                  children: [
                    Gap(20),
                    Row(
                      children: [
                        Gap(10),
                        Column(
                          children: [
                            Text(
                              'Select Project:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                    Gap(10),
                    Column(
                      children: [
                        DropdownSearch<Projects>(
                          itemAsString: (item) => item.project_title,
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                          ),
                          items: projects.toList(),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Select Project",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                          onChanged: (newValue) {
                            selectedProject = newValue;
                            getGroupdetailsByProject();
                          },
                        ),
                      ],
                    ),
                    Gap(20),
                    Row(
                      children: [
                        Gap(10),
                        Column(
                          children: [
                            Text(
                              'Select Student:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                    Gap(10),
                    Column(
                      children: [
                        DropdownButtonHideUnderline(
                          child: DropdownButtonFormField<Student>(
                            hint: Text('Select Student'),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              hintText: "Select Student",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                selectedStudent = newValue!.student_id;
                              });
                            },
                            items: students
                                .map((student) => DropdownMenuItem<Student>(
                                      value: student,
                                      child: Text(student.student_name),
                                    ))
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                    Gap(60),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => grading(
                                      student_id: selectedStudent!,
                                    )));
                      },
                      child: Text(
                        'View',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
