import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Models/GetGradedStudent.dart';
import 'package:biit_project_progress_monitoring_system/Models/Supervisor.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../Global/global.dart';
import '../Models/GetScoreCounts.dart';

class FGrade extends StatefulWidget {
  GetScoreCounts supervisor;
  FGrade({super.key, required this.supervisor});

  @override
  State<FGrade> createState() => _FGradeState();
}

class _FGradeState extends State<FGrade> {
  List<GetGradedStudent> getGradedStudent = [];
  bool loading = false;

  Future<void> getGradedStudents() async {
    try {
      String uri =
          '${baseUrl}Grading/GetGradedStudents?supid=${widget.supervisor.supervisorid}&grade=F';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        for (var data in jsonDecode(response.body)) {
          getGradedStudent.add(GetGradedStudent.fromMap(data));
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
    getGradedStudents();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('F Grade Students'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: getGradedStudent.length,
            itemBuilder: (context, index) {
              return Container(
                  padding: EdgeInsets.all(8),
                  height: 100,
                  width: double.infinity,
                  margin: EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
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
                      children: [
                        Container(
                          height: 80,
                          width: 350,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                blurRadius: 5,
                                spreadRadius: 5,
                                color: Colors.black12,
                              ),
                            ],
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Text(
                                  '${getGradedStudent[index].student_name}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '  ${getGradedStudent[index].arid_no}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '  ${getGradedStudent[index].project_title}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]));
            }),
      ),
    );
    ;
  }
}
