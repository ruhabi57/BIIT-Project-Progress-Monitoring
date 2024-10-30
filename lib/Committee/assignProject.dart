import 'dart:convert';
import 'package:biit_project_progress_monitoring_system/Committee/committeeDashboard.dart';
import 'package:biit_project_progress_monitoring_system/Models/Supervisor.dart';
import 'package:biit_project_progress_monitoring_system/Models/projects.dart';
import 'package:biit_project_progress_monitoring_system/Models/sessionModel.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:http/http.dart' as http;

import '../Global/global.dart';
import '../Models/ProjectAllocationModel.dart';

class AssignProject extends StatefulWidget {
  final GetAllGroupsToAssign students;
  AssignProject({super.key, required this.students});

  @override
  State<AssignProject> createState() => _AssignProjectState();
}

class _AssignProjectState extends State<AssignProject> {
  Projects? selectedProject;
  SupervisorModel? selectedSupervisor;

  bool loading = false;
  List<SupervisorModel> supervisorlist = [];
  List<Projects> projects = [];
  List<Sessions> session = [];
  Sessions? selectedSession;

  Future<void> getGetAllSupervisors() async {
    try {
      String uri = '${baseUrl}Student/GetAllSupervisors';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        for (var data in jsonDecode(response.body)) {
          supervisorlist.add(SupervisorModel.fromMap(data));
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

  Future<void> getAllSessions() async {
    try {
      String uri = '${baseUrl}AssignProject/GetAllSessions';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        for (var data in jsonDecode(response.body)) {
          session.add(Sessions.fromMap(data));
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

  Future<void> getNotAssignProjects() async {
    try {
      String uri = '${baseUrl}Projects/GetNotAssignProjects';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        for (var data in jsonDecode(response.body)) {
          projects.add(Projects.fromMap(data));
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

  projectAllocation() async {
    try {
      String uri =
          '${baseUrl}AssignProject/ProjectAllocation?project_id=${selectedProject!.project_id}&supervisor_id=${selectedSupervisor!.user_id}&group_id=${widget.students.group_id}&session_id=${selectedSession!.session_id}';
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
    getGetAllSupervisors();
    getAllSessions();
    getNotAssignProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Assign Project')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            height: 650,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              Gap(20),
              Expanded(
                child: ListView.builder(
                  itemCount: widget.students.Students!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(8),
                      height: 80,
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
                                widget.students.Students![index].student_name ??
                                    '',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                  'Arid No: ${widget.students.Students![index].arid_no}')
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'CGPA: ${widget.students.Students![index].cgpa}'),
                              Text(
                                  'Platform: ${widget.students.Students![index].platform}')
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Column(
                children: [
                  Gap(20),
                  Row(children: [
                    Gap(10),
                    Column(
                      children: [
                        Text(
                          'Assign Project:',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ]),
                  Gap(10),
                  Center(
                    child: DropdownButtonHideUnderline(
                      child: DropdownSearch<Projects>(
                        itemAsString: (item) => item.project_title,
                        popupProps: PopupProps.menu(
                          showSearchBox: true,
                        ),
                        items: projects,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Select Project",
                            contentPadding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5),
                              borderSide: BorderSide(color: Colors.black),
                            ),
                          ),
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedProject = newValue;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Gap(20),
                  Row(children: [
                    Gap(10),
                    Column(
                      children: [
                        Text(
                          'Assign Supervisor:',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ]),
                  Gap(10),
                  Center(
                    child: DropdownSearch<SupervisorModel>(
                      itemAsString: (item) => item.username ?? '',
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                      ),
                      items: supervisorlist,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Select Supervisor",
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                      onChanged: (newValue) {
                        setState(() {
                          selectedSupervisor = newValue;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Gap(20),
                  Row(children: [
                    Gap(10),
                    Column(
                      children: [
                        Text(
                          'Select Session:',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ]),
                  Gap(10),
                  Center(
                    child: DropdownButtonHideUnderline(
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.black),
                        ),
                        child: DropdownButton<Sessions>(
                          isExpanded: true,
                          value: selectedSession,
                          hint: Text("Select Session"),
                          items: session.map((Sessions session) {
                            return DropdownMenuItem<Sessions>(
                              value: session,
                              child: Text(session.session_name ?? ''),
                            );
                          }).toList(),
                          onChanged: (Sessions? newValue) {
                            setState(() {
                              selectedSession = newValue;
                            });
                          },
                          icon:
                              Icon(Icons.arrow_drop_down, color: Colors.black),
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                          dropdownColor: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Gap(30),
              loading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : ElevatedButton(
                      onPressed: () {
                        projectAllocation();
                      },
                      child: const Text(
                        'Allocate',
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )),
            ]),
          ),
        ),
      ),
    );
  }
}
