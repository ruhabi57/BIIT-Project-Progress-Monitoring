import 'dart:convert';
import 'package:biit_project_progress_monitoring_system/Committee/committeeDashboard.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import '../Global/global.dart';
import '../Models/studentModel.dart';

class restrictedStudents extends StatefulWidget {
  const restrictedStudents({super.key});

  @override
  State<restrictedStudents> createState() => _restrictedStudentsState();
}

class _restrictedStudentsState extends State<restrictedStudents> {
  TextEditingController searchController = TextEditingController();

  List<Student> students = [];
  List<Student> filteredStudents = [];
  var selectedStudent;
  bool loading = true;

  List<Student> searchStudents(String query) {
    return students.where((student) {
      final nameLower = student.student_name.toLowerCase();
      final queryLower = query.toLowerCase();

      return nameLower.contains(queryLower);
    }).toList();
  }

  getAllStudent() async {
    try {
      String uri = '${baseUrl}Student/GetAllStudent';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        for (var e in res) {
          students.add(Student.fromMap(e));
        }
        filteredStudents = students;
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

  EnrollStudent() async {
    try {
      setState(() {
        loading = true;
      });

      var url = baseUrl + "DataCell/EnrollStudent";
      var enroll = false;
      var data = ({
        "student_id": selectedStudent,
        "status": enroll,
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
  void initState() {
    super.initState();
    getAllStudent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drop Student')),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              // margin: EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Enter Student Name',
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        filteredStudents =
                            searchStudents(searchController.text);
                      });
                    },
                  ),
                ),
              ),
            ),
            Gap(30),
            Expanded(
              child: loading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: filteredStudents.length,
                      itemBuilder: (context, index) {
                        Student student = filteredStudents[index];

                        return Container(
                          padding: EdgeInsets.all(8),
                          height: 150,
                          width: double.infinity,
                          margin: EdgeInsets.only(bottom: 20),
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
                              Text(
                                student.student_name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text('CGPA: ${student.cgpa}'),
                              Text('Arid no: ${student.arid_no}'),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  // ElevatedButton(
                                  //     onPressed: () {
                                  //       selectedStudent = student.student_id;
                                  //       EnrollStudent();
                                  //     },
                                  //     child: Text(
                                  //       'Enroll',
                                  //       style: TextStyle(
                                  //           fontWeight: FontWeight.bold,
                                  //           color: Colors.black),
                                  //     )),
                                  Gap(20),
                                  ElevatedButton(
                                      onPressed: () {
                                        selectedStudent = student.student_id;
                                        EnrollStudent();
                                      },
                                      child: Text(
                                        'Drop',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black),
                                      ))
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
