import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Models/projects.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import '../Global/global.dart';
import 'committeeDashboard.dart';

class addMembers extends StatefulWidget {
  Projects project;
  addMembers({super.key, required this.project});

  @override
  State<addMembers> createState() => _addMembersState();
}

class _addMembersState extends State<addMembers> {
  List<Student> studentsnotmember = [];
  List<Student> students = [];
  List<String> filteredTechnologies = [];
  String? selectedTechnology;
  final List<String> _technologies = [
    'Flutter',
    'React Native',
    'IOS',
    'Android',
    'Web'
  ];
  Student? selectedStudent;
  bool loading = true;

  Future<void> getGroupDetails() async {
    try {
      String uri = '${baseUrl}Student/GetAllStudentNotMember';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        for (var data in jsonDecode(response.body)) {
          studentsnotmember.add(Student.fromMap(data));
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

  Future<void> getStudentsbyProjectID() async {
    try {
      print('id>>>> ${widget.project.project_id}');
      String uri =
          '${baseUrl}Groups/GetStudentsbyProjectID?projectid=${widget.project.project_id}';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        for (var data in jsonDecode(response.body)) {
          students.add(Student.fromMap(data));
        }
        print(students);

        setFilteredTechnologies();

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

  void setFilteredTechnologies() {
    final existingPlatforms =
        students.map((student) => student.platform).toSet();
    filteredTechnologies = _technologies
        .where((tech) => !existingPlatforms.contains(tech))
        .toList();
  }

  addMembertoExistingProject() async {
    try {
      String uri =
          '${baseUrl}AssignProject/AddMembertoExistingProject?project_id=${widget.project.project_id}&student_id=${selectedStudent!.student_id}&tech=${selectedTechnology}';
      http.Response response = await http.post(Uri.parse(uri));
      if (response.statusCode == 200) {
        setState(() {
          loading = false;
        });
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => committeeDashboard(),
            ));
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.body),
            duration: const Duration(seconds: 3),
          ),
        );
      } else {
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
    getStudentsbyProjectID();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add Members')),
        body: SingleChildScrollView(
          child: Column(children: [
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  height: 950,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(children: [
                    Gap(30),
                    ListView.separated(
                      shrinkWrap: true,
                      itemCount: students.length,
                      itemBuilder: (context, index) => Container(
                        padding: const EdgeInsets.all(8),
                        height: 100,
                        width: double.infinity,
                        margin: const EdgeInsets.only(bottom: 20),
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
                                  students[index].student_name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text('Arid Number: ${students[index].arid_no}')
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Semester: ${students[index].semester}'),
                                Text('Platform: ${students[index].platform}')
                              ],
                            ),
                          ],
                        ),
                      ),
                      separatorBuilder: (context, index) => SizedBox(
                        height: 10,
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Column(
                      children: [
                        Center(
                            child: DropdownSearch<Student>(
                          key: ValueKey('studentDropdown'),
                          popupProps: PopupProps.menu(
                            showSearchBox: true,
                          ),
                          items: studentsnotmember,
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
                          selectedItem: selectedStudent,
                          onChanged: (newValue) {
                            setState(() {
                              selectedStudent = newValue;
                            });
                          },
                          itemAsString: (Student student) =>
                              student.student_name,
                        )),
                        const SizedBox(height: 10),
                        Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                            border: Border.all(color: Colors.black12),
                          ),
                          child: DropdownButton<String>(
                            isExpanded: true,
                            underline: SizedBox(),
                            hint: Text('Select a technology'),
                            value: selectedTechnology,
                            onChanged: (newValue) {
                              setState(() {
                                selectedTechnology = newValue;
                              });
                            },
                            items:
                                filteredTechnologies.map((String technology) {
                              return DropdownMenuItem<String>(
                                value: technology,
                                child: Text(technology),
                              );
                            }).toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            onPressed: () {
                              addMembertoExistingProject();
                            },
                            child: Text(
                              'Add',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black),
                            ))
                      ],
                    )
                  ])),
            ),
          ]),
        ));
  }
}
