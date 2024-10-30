// import 'package:biit_project_progress_monitoring_system/Student/navBarItem/dashboard.dart';
// import 'package:biit_project_progress_monitoring_system/Student/navBarItem/meeting.dart';
// import 'package:biit_project_progress_monitoring_system/Student/navBarItem/request.dart';
// import 'package:biit_project_progress_monitoring_system/Student/navBarItem/task.dart';
import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Global/global.dart';
import 'package:biit_project_progress_monitoring_system/Models/projects.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import '../Models/GetGroupDetailModel.dart';

class groupDetail extends StatefulWidget {
  const groupDetail({super.key});

  @override
  State<groupDetail> createState() => _groupDetailState();
}

class _groupDetailState extends State<groupDetail> {
  GroupDetail? group;
  Projects? projects;
  Members? members;
  User? user;
  bool loading = true;

  Future<void> getGroupDetails() async {
    try {
      String uri =
          '${baseUrl}Groups/getGroupDetails?user_id=${userdata['user_id']}';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        group = GroupDetail.fromMap(jsonDecode(response.body));
        // print(group!.groupName);
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
      appBar: AppBar(title: const Text('Group Details')),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : group == null
              ? const Center(child: Text('Nothing Found'))
              : Column(
                  children: [
                    const Gap(30),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                          height: 600,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              //color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                height: 60,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20),
                                  //border: Border.all(color: Colors.black, width: 2),
                                  boxShadow: const [
                                    BoxShadow(
                                      blurRadius: 5,
                                      spreadRadius: 5,
                                      color: Colors.black12,
                                    ),
                                  ],
                                ),
                                child: Center(
                                    child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                            group!.projectdetail == null
                                                ? 'Project Not Assigned'
                                                : group!.projectdetail!
                                                            .project_status ==
                                                        null
                                                    ? 'Project Not Assigned'
                                                    : group!.projectdetail!
                                                        .project_title
                                                        .capitalizeFirstLetter(),
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18))
                                      ],
                                    )
                                  ],
                                )),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Expanded(
                                child: ListView.builder(
                                  itemCount: group == null
                                      ? 0
                                      : group!.members!.length,
                                  itemBuilder: (context, index) {
                                    Members student = group!.members![index];
                                    return Container(
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
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                student.user!.student_name!
                                                    .capitalizeFirstLetter(),
                                                style: const TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 16,
                                                ),
                                              ),
                                              Text('${student.user!.arid_no}')
                                            ],
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                  'Semester: ${student.user!.semester}'),
                                              Text(
                                                  'Platform: ${student.platform}')
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
    );
  }
}
