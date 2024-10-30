import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Committee/assignProject.dart';
import 'package:biit_project_progress_monitoring_system/Global/global.dart';
import 'package:biit_project_progress_monitoring_system/Models/ProjectAllocationModel.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

class projectAllocationCom extends StatefulWidget {
  const projectAllocationCom({super.key});

  @override
  State<projectAllocationCom> createState() => _projectAllocationComState();
}

class _projectAllocationComState extends State<projectAllocationCom> {
  TextEditingController searchController = TextEditingController();

  List<GetAllGroupsToAssign> getGroupsToAssign = [];
  bool loading = false;

  @override
  void initState() {
    super.initState();
    getAllGroupsIds();
  }

  Future<void> getAllGroupsIds() async {
    setState(() {
      loading = true;
    });

    try {
      String uri = '${baseUrl}AssignProject/GetAllGroups';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        setState(() {
          getGroupsToAssign = responseData
              .map((data) => GetAllGroupsToAssign.fromMap(data))
              .toList();
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Container(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Search Group',
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
            Gap(30),
            loading
                ? Center(child: CircularProgressIndicator())
                : Expanded(
                    child: ListView.builder(
                      itemCount: getGroupsToAssign.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        GetAllGroupsToAssign group = getGroupsToAssign[index];
                        return Container(
                          padding: EdgeInsets.all(8),
                          height: 220,
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
                            children: [
                              Center(
                                child: Text(
                                  ('Group: ${group.group_id}'),
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              Gap(10),
                              ListView.builder(
                                  itemCount: group.Students!.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) {
                                    StudentProjectNotAssigned student =
                                        group.Students![index];
                                    return Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                            'Name: ${student.student_name!.capitalizeFirstLetter()}'),
                                        Text('Platform: ${student.platform}')
                                      ],
                                    );
                                  }),
                              Center(
                                child: ElevatedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AssignProject(
                                                      students: group)));
                                    },
                                    child: const Text(
                                      'Assign',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 15),
                                    )),
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
