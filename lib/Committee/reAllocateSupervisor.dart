import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Models/Supervisor.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import '../Global/global.dart';
import '../Models/projects.dart';
import 'committeeDashboard.dart';

class reAllocateSupervisor extends StatefulWidget {
  Projects project;
  reAllocateSupervisor({super.key, required this.project});

  @override
  State<reAllocateSupervisor> createState() => _reAllocateSupervisorState();
}

class _reAllocateSupervisorState extends State<reAllocateSupervisor> {
  List<Student> students = [];
  List<SupervisorModel> supervisorlist = [];
  SupervisorModel? selectedSupervisor;
  bool loading = false;

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

  relocateSupervisor() async {
    try {
      String uri =
          '${baseUrl}AssignProject/RelocateSupervisor?project_id=${widget.project!.project_id}&supervsior_id=${selectedSupervisor!.user_id}';
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
    relocateSupervisor();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Re-Allocate Supervisor')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Gap(10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Container(
                  height: 950,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      Gap(30),
                      ListView.separated(
                        shrinkWrap: true,
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    widget.project.members[index].student
                                        .student_name,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                      'Arid Number: ${widget.project.members[index].student.arid_no}')
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                      'Semester: ${widget.project.members[index].student.semester}'),
                                  Text(
                                      'Platform: ${widget.project.members[index].platform}')
                                ],
                              ),
                            ],
                          ),
                        ),
                        separatorBuilder: (context, index) => SizedBox(
                          height: 10,
                        ),
                        itemCount: widget.project.members.length,
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      Column(
                        children: [
                          Gap(20),
                          Row(
                            children: [
                              Gap(10),
                              Column(
                                children: [
                                  Text(
                                    'Assign Supervisor:',
                                    style: TextStyle(fontSize: 18),
                                  )
                                ],
                              ),
                            ],
                          ),
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
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          relocateSupervisor();
                        },
                        child: Text(
                          'Re-Allocate',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontSize: 16),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
