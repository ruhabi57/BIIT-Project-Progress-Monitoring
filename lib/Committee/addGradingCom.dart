import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Committee/committeeDashboard.dart';
import 'package:biit_project_progress_monitoring_system/Models/projects.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import '../Global/global.dart';
import '../Models/GetCriteria.dart';

class AddGradingCom extends StatefulWidget {
  const AddGradingCom({super.key});

  @override
  State<AddGradingCom> createState() => _AddGradingComState();
}

class _AddGradingComState extends State<AddGradingCom> {
  bool loading = true;
  int? selectedStudent;
  Criteria? selectedCriteria;
  Projects? selectedProject;
  TextEditingController scoreController = TextEditingController();
  TextEditingController remarks = TextEditingController();
  List<String> selectedvalue = [];
  List<Student> students = [];
  List<Projects> projects = [];

  List<Criteria> criteria = [];

  @override
  void initState() {
    super.initState();
    getAllAssignProjects();
    getCriteria();
  }

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

  Future<void> getCriteria() async {
    setState(() {
      loading = true;
    });

    try {
      String uri = '${baseUrl}Grading/GetCriteria?role=${userdata['role']}';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          criteria =
              responseData.map((data) => Criteria.fromMap(data)).toList();
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

  AddGrading() async {
    try {
      setState(() {
        loading = true;
      });

      var url = baseUrl + "Grading/AddGrading";
      var enroll = true;
      var data = ({
        "user_id": userdata['user_id'],
        "score": scoreController.text,
        "student_id": selectedStudent,
        "score_id": selectedCriteria!.score_id,
        "remarks": remarks.text
      });

      var response = await Dio().post(
        url,
        options: Options(headers: {'Content-Type': "application/json"}),
        data: data,
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response.data)));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => committeeDashboard(),
            ));
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Grading')),
      body: Padding(
        padding: const EdgeInsets.only(left: 8, right: 8, top: 60, bottom: 20),
        child: SingleChildScrollView(
          child: Container(
            height: 650,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Gap(20),
                Column(
                  children: [
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
                    Gap(30),
                    Row(
                      children: [
                        Gap(10),
                        Column(
                          children: [
                            Text(
                              'Select Criteria:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                    Gap(20),
                    Row(
                      children: [
                        SizedBox(
                          width: 240,
                          child: DropdownButtonHideUnderline(
                            child: DropdownButtonFormField(
                              hint: Text('Select Criteria'),
                              decoration: InputDecoration(
                                  filled: true, fillColor: Colors.white),
                              onChanged: (newValue) {
                                setState(() {
                                  selectedCriteria = newValue!;
                                });
                              },
                              items: criteria
                                  .map((criterias) => DropdownMenuItem(
                                        value: criterias,
                                        child: Text(criterias.criteria +
                                            " "
                                                "${(criterias.score_weight)}"),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                        Gap(30),
                        SizedBox(
                          width: 50,
                          child: TextFormField(
                            decoration: InputDecoration(
                                filled: true, fillColor: Colors.grey.shade300),
                            keyboardType: TextInputType.number,
                            controller: scoreController,
                          ),
                        )
                      ],
                    ),
                    Gap(30),
                    Row(
                      children: [
                        Gap(10),
                        Column(
                          children: [
                            Text(
                              'Remarks:',
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ],
                    ),
                    Gap(10),
                    Container(
                      padding: EdgeInsets.all(8),
                      height: 100,
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
                      child: TextField(
                        controller: remarks,
                        decoration: InputDecoration(
                          hintText: 'Enter Remarks',
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Gap(40),
                    ElevatedButton(
                      onPressed: () {
                        AddGrading();
                      },
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    )
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
