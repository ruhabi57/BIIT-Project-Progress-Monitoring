import 'package:biit_project_progress_monitoring_system/Supervisor/viewGroupSup.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:biit_project_progress_monitoring_system/Global/global.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Models/projects.dart';

class fyp2groupSup extends StatefulWidget {
  const fyp2groupSup({super.key});

  @override
  State<fyp2groupSup> createState() => _fyp2groupSupState();
}

class _fyp2groupSupState extends State<fyp2groupSup> {
  TextEditingController searchController = TextEditingController();
  String searchtext = '';
  List<Projects> projects = [];
  bool loading = true;

  Future<void> GetAssignProjects() async {
    try {
      String uri = '${baseUrl}Projects/GetAssignProjects?fyp_type=2';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        final decodedData = jsonDecode(response.body);
        projects = decodedData
            .map((projectData) => Projects.fromMap(projectData))
            .cast<Projects>()
            .toList();
        projects = projects
            .where(
                (element) => element.supervisor!.user_id == userdata['user_id'])
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

  @override
  void initState() {
    GetAssignProjects();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('FYP-2 Groups')),
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              // margin: EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Enter Project Title',
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {});
                    },
                  ),
                ),
              ),
            ),
            Gap(30),
            Expanded(
              child: ListView.builder(
                itemCount: projects.length,
                itemBuilder: (context, index) {
                  Projects project = projects[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => (viewGroupSup(
                                    project: project,
                                  ))));
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
                                project.project_title,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  'Supervisor: ${project.supervisor == null ? "" : project.supervisor!.name} '),
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
}
