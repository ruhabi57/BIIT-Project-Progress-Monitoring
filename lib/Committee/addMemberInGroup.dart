import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Committee/addMembers.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import '../Global/global.dart';
import '../Models/projects.dart';

class addMemberInGroup extends StatefulWidget {
  const addMemberInGroup({super.key});

  @override
  State<addMemberInGroup> createState() => _addMemberInGroupState();
}

class _addMemberInGroupState extends State<addMemberInGroup> {
  TextEditingController searchController = TextEditingController();
  List<Projects> projects = [];
  String? platform;
  bool loading = true;

  Future<void> GetAssignProjects() async {
    try {
      String uri = '${baseUrl}Projects/GetAssignProjects?fyp_type=1';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        projects = decodedData
            .map<Projects>((projectData) => Projects.fromMap(projectData))
            .toList();
        print(projects);
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

  getVacantProject() async {
    try {
      String uri =
          '${baseUrl}AssignProject/GetVacantProject?tech=${searchController.text}';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        projects.clear();
        for (var e in res) {
          projects.add(Projects.fromMap(e));
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
    GetAssignProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Member in Group'),
      ),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Enter Vacant Project',
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.filter_alt),
                    onPressed: () {
                      setState(() {
                        getVacantProject();
                      });
                    },
                  ),
                ),
              ),
            ),
            Gap(20),
            Expanded(
              child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  Projects project = projects[index];
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              project.project_title,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      addMembers(project: project),
                                ),
                              );
                            },
                            child: Text(
                              'Add Member',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ),
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
}
