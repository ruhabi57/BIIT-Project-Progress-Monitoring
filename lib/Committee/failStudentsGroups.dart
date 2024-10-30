import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../Global/global.dart';
import '../Models/projects.dart';
import 'addMember.dart';

class FailStudentsGroups extends StatefulWidget {
  const FailStudentsGroups({super.key});

  @override
  State<FailStudentsGroups> createState() => _FailStudentsGroupsState();
}

class _FailStudentsGroupsState extends State<FailStudentsGroups> {
  List<Projects> projects = [];
  bool loading = true;

  Future<void> getFailProjectAndMembers() async {
    try {
      String uri = '${baseUrl}Groups/GetFailProjectAndMembers';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var decodedData = jsonDecode(response.body);
        projects = decodedData
            .map((projectData) => Projects.fromMap(projectData))
            .cast<Projects>()
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
    getFailProjectAndMembers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Fail Students/Groups'),
      ),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: projects.length,
              itemBuilder: (context, index) {
                return ProjectCard(project: projects[index]);
              },
            ),
    );
  }
}

class ProjectCard extends StatelessWidget {
  final Projects project;

  const ProjectCard({Key? key, required this.project}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      height: 280,
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
          Text(
            project.project_title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          const Gap(10),
          Text('Supervised By: ${project?.name ?? 'N/A'}'),
          const Gap(10),
          Text(
            'Failed Members:   ${project.fyp_type.toUpperCase()}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
              fontSize: 16,
            ),
          ),
          const Gap(10),
          ...project.student.map((student) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(student.student_name,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  Text(student.platform,
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              )),
          const Gap(20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Re-Allocate',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const addMember(),
                    ),
                  );
                },
                child: const Text(
                  'Add Member',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
