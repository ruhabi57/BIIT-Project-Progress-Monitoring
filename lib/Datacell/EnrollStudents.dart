import 'package:biit_project_progress_monitoring_system/Models/studentModel.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import '../Global/global.dart';
import 'dart:convert';

class dropStudentsList extends StatefulWidget {
  const dropStudentsList({super.key});

  @override
  State<dropStudentsList> createState() => _dropStudentsListState();
}

class _dropStudentsListState extends State<dropStudentsList> {
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

  GetEnroledStudent() async {
    try {
      String uri = '${baseUrl}DataCell/GetEnroledStudents';
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

  @override
  void initState() {
    super.initState();
    GetEnroledStudent();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Enroll Students')),
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
                          height: 120,
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
                              Text('Platform: ${student.platform}')
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
