import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import '../Global/global.dart';
import '../Models/GetGroupDetailModel.dart';
import '../Models/studentModel.dart';

class restrictedStudentsSup extends StatefulWidget {
  const restrictedStudentsSup({super.key});

  @override
  State<restrictedStudentsSup> createState() => _restrictedStudentsSupState();
}

class _restrictedStudentsSupState extends State<restrictedStudentsSup> {
  TextEditingController searchController = TextEditingController();
  Members? members;
  List<Student> filteredStudents = [];
  List<Student> searchStudents(String query) {
    return students.where((student) {
      final nameLower = student.student_name.toLowerCase();
      final queryLower = query.toLowerCase();

      return nameLower.contains(queryLower);
    }).toList();
  }

  void performSearch() {
    setState(() {
      filteredStudents = searchStudents(searchController.text);
    });
  }

  List<Student> students = [];
  bool loading = true;

  getAllStudent() async {
    try {
      String uri = '${baseUrl}Student/GetAllStudent';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        for (var e in res) {
          students.add(Student.fromMap(e));
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
  void initState() {
    super.initState();
    getAllStudent();
    filteredStudents = students;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Restrict Student')),
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
                      performSearch();
                      setState(() {});
                    },
                  ),
                ),
                onSubmitted: (value) => performSearch(),
              ),
            ),
            Gap(30),
            Expanded(
              child: ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  Student student = students[index];

                  return GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text(
                                  'Do you want to Restrict the Following Student?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text('NO'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text(
                                          'You Restricted ${student.student_name} Successfully'),
                                    ));
                                  },
                                  child: Text('YES'),
                                ),
                              ],
                            );
                          });
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      height: 100,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                student.student_name,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text('Arid no: ${student.arid_no}')
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('CGPA: ${student.cgpa}'),
                              Text('Platform: ${student.platform}')
                            ],
                          ),
                        ],
                      ),
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
