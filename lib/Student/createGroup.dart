import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:biit_project_progress_monitoring_system/Models/GroupFormationModel.dart';
import 'package:biit_project_progress_monitoring_system/Models/studentModel.dart';
import 'package:biit_project_progress_monitoring_system/Student/studentDashboard.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import '../Global/global.dart';

class createGroup extends StatefulWidget {
  const createGroup({super.key});

  @override
  State<createGroup> createState() => _createGroupState();
}

class _createGroupState extends State<createGroup> {
  List<GroupFormationModel> selectedvalue = [];
  Student? selectedStudent1;
  Student? selectedStudent2;
  Student? selectedStudent3;
  Student? selectedStudent4;
  Student? selectedStudent5;
  List<Student> students = [];
  List<String> technologyList = [
    'Flutter',
    'React Native',
    'IOS',
    'Android',
    'Web'
  ];

  bool loading = true;

  Future<void> getGroupDetails() async {
    try {
      String uri = '${baseUrl}Student/GetAllStudentNotMember';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        for (var data in jsonDecode(response.body)) {
          students.add(Student.fromMap(data));
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
    getGroupDetails();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Group'),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(15, 70, 15, 80),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Students',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Technology',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Gap(20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Center(
                        child: DropdownSearch<Student>(
                      key: ValueKey('studentDropdown'),
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                      ),
                      items: students,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Select Student",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      selectedItem: selectedStudent1,
                      onChanged: (newValue) {
                        setState(() {
                          selectedStudent1 = newValue;
                        });
                      },
                      itemAsString: (Student student) => student.student_name,
                    )),
                  ),
                  Container(
                      height: 60,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
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
                          technologyList[0],
                          style: const TextStyle(
                            fontSize: 14,
                            // fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const Gap(10),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Center(
                        child: DropdownSearch<Student>(
                      key: ValueKey('studentDropdown'),
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                      ),
                      items: students,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Select Student",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      selectedItem: selectedStudent2,
                      onChanged: (newValue) {
                        setState(() {
                          selectedStudent2 = newValue;
                        });
                      },
                      itemAsString: (Student student) => student.student_name,
                    )),
                  ),
                  Container(
                      height: 60,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
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
                          technologyList[1],
                          style: const TextStyle(
                            fontSize: 14,
                            // fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const Gap(10),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Center(
                        child: DropdownSearch<Student>(
                      key: ValueKey('studentDropdown'),
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                      ),
                      items: students,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Select Student",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      selectedItem: selectedStudent3,
                      onChanged: (newValue) {
                        setState(() {
                          selectedStudent3 = newValue;
                        });
                      },
                      itemAsString: (Student student) => student.student_name,
                    )),
                  ),
                  Container(
                      height: 60,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
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
                          technologyList[2],
                          style: const TextStyle(
                            fontSize: 14,
                            // fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const Gap(10),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Center(
                        child: DropdownSearch<Student>(
                      key: ValueKey('studentDropdown'),
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                      ),
                      items: students,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Select Student",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      selectedItem: selectedStudent4,
                      onChanged: (newValue) {
                        setState(() {
                          selectedStudent4 = newValue;
                        });
                      },
                      itemAsString: (Student student) => student.student_name,
                    )),
                  ),
                  Container(
                      height: 60,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
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
                          technologyList[3],
                          style: const TextStyle(
                            fontSize: 14,
                            // fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const Gap(10),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Center(
                        child: DropdownSearch<Student>(
                      key: ValueKey('studentDropdown'),
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                      ),
                      items: students,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Select Student",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      selectedItem: selectedStudent5,
                      onChanged: (newValue) {
                        setState(() {
                          selectedStudent5 = newValue;
                        });
                      },
                      itemAsString: (Student student) => student.student_name,
                    )),
                  ),
                  Container(
                      height: 60,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
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
                          technologyList[4],
                          style: const TextStyle(
                            fontSize: 14,
                            // fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const Gap(30),
            loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: () {
                      createGroup();
                    },
                    child: const Text(
                      'Create',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    )),
          ],
        ),
      ),
    );
  }

  createGroup() async {
    try {
      if (selectedStudent1 != null) {
        selectedvalue.add(GroupFormationModel(
            user_id: userdata['user_id'],
            technology: technologyList[0],
            student_id: selectedStudent1!.student_id ?? 0));
      }
      if (selectedStudent2 != null) {
        selectedvalue.add(GroupFormationModel(
            user_id: userdata['user_id'],
            technology: technologyList[1],
            student_id: selectedStudent2!.student_id ?? 0));
      }
      if (selectedStudent3 != null) {
        selectedvalue.add(GroupFormationModel(
            user_id: userdata['user_id'],
            technology: technologyList[2],
            student_id: selectedStudent3!.student_id ?? 0));
      }
      if (selectedStudent4 != null) {
        selectedvalue.add(GroupFormationModel(
            user_id: userdata['user_id'],
            technology: technologyList[3],
            student_id: selectedStudent4!.student_id ?? 0));
      }
      if (selectedStudent5 != null) {
        selectedvalue.add(GroupFormationModel(
            user_id: userdata['user_id'],
            technology: technologyList[4],
            student_id: selectedStudent5!.student_id ?? 0));
      }

      setState(() {
        loading = true;
      });

      String uri = '${baseUrl}AUTH/CreateGroup';
      var data = selectedvalue.map((e) => e.toMap()).toList();
      http.Response response = await http.post(Uri.parse(uri),
          body: jsonEncode(data),
          headers: {'Content-Type': 'application/json'});
      setState(() {
        loading = false;
      });
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.body),
            duration: const Duration(seconds: 3),
          ),
        );
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StudentDashboard(),
            ));
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
    } catch (e) {}
  }
}
