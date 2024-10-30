import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Global/global.dart';
import 'package:biit_project_progress_monitoring_system/Models/GetGroupDetailModel.dart';
import 'package:biit_project_progress_monitoring_system/Models/Supervisor.dart';
import 'package:biit_project_progress_monitoring_system/Student/studentDashboard.dart';
import 'package:dropdown_search/dropdown_search.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

class supervisorRequest extends StatefulWidget {
  const supervisorRequest({super.key});

  @override
  State<supervisorRequest> createState() => _supervisorRequestState();
}

class _supervisorRequestState extends State<supervisorRequest> {
  List<SupervisorModel> supervisorlist = [];
  List<SupervisorPreference> selectedvalue = [];
  GroupDetail? group;
  Members? members;
  User? user;
  SupervisorModel? selectedSupervisor1;
  SupervisorModel? selectedSupervisor2;
  SupervisorModel? selectedSupervisor3;
  bool loading = false;

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

  @override
  void initState() {
    getGroupDetails();
    getGetAllSupervisors();

    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Supervisor Preferences')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            height: 700,
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20)),
            child: Column(children: [
              Gap(20),
              Expanded(
                child: ListView.builder(
                  itemCount: group == null ? 0 : group!.members!.length,
                  itemBuilder: (context, index) {
                    Members student = group!.members![index];
                    return Container(
                      padding: const EdgeInsets.all(8),
                      height: 90,
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
                                student.user!.username!.capitalizeFirstLetter(),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text('Arid Number: ${student.user!.arid_no}')
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Semester: ${student.user!.semester}'),
                              Text('Platform: ${student.platform}')
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Column(
                children: [
                  Row(children: [
                    Gap(10),
                    Column(
                      children: [
                        Text(
                          'Supervisor Prefrence:',
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ]),
                  const Gap(10),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 7),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.6,
                          child: Center(
                              child: DropdownSearch<SupervisorModel>(
                            key: ValueKey('supervisorDropdown'),
                            popupProps: PopupProps.menu(
                              showSearchBox: true,
                            ),
                            items: supervisorlist,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Select Supervisor",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                            selectedItem: selectedSupervisor1,
                            onChanged: (newValue) {
                              setState(() {
                                selectedSupervisor1 = newValue;
                              });
                            },
                            itemAsString: (item) => item.username ?? '',
                          )),
                        ),
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
                              child: DropdownSearch<SupervisorModel>(
                            key: ValueKey('supervisorDropdown'),
                            popupProps: PopupProps.menu(
                              showSearchBox: true,
                            ),
                            items: supervisorlist,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Select Supervisor",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                            selectedItem: selectedSupervisor2,
                            onChanged: (newValue) {
                              setState(() {
                                selectedSupervisor2 = newValue;
                              });
                            },
                            itemAsString: (item) => item.username ?? '',
                          )),
                        ),
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
                              child: DropdownSearch<SupervisorModel>(
                            key: ValueKey('supervisorDropdown'),
                            popupProps: PopupProps.menu(
                              showSearchBox: true,
                            ),
                            items: supervisorlist,
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                hintText: "Select Supervisor",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                            ),
                            selectedItem: selectedSupervisor3,
                            onChanged: (newValue) {
                              setState(() {
                                selectedSupervisor3 = newValue;
                              });
                            },
                            itemAsString: (item) => item.username ?? '',
                          )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(20),
              ElevatedButton(
                  onPressed: () {
                    supervisorRequest();
                  },
                  child: Text(
                    'Send Request',
                    style: TextStyle(color: Colors.black, fontSize: 18),
                  ))
            ]),
          ),
        ),
      ),
    );
  }

  supervisorRequest() async {
    try {
      selectedvalue = [];
      if (selectedSupervisor1 != null) {
        selectedvalue.add(SupervisorPreference(
            group_id: userdata['group_id'],
            supervisor_id: selectedSupervisor1!.user_id,
            status: false));
      }
      if (selectedSupervisor2 != null) {
        selectedvalue.add(SupervisorPreference(
            group_id: userdata['group_id'],
            supervisor_id: selectedSupervisor2!.user_id,
            status: false));
      }
      if (selectedSupervisor3 != null) {
        selectedvalue.add(SupervisorPreference(
            group_id: userdata['group_id'],
            supervisor_id: selectedSupervisor3!.user_id,
            status: false));
      }

      setState(() {
        loading = true;
      });

      String uri = '${baseUrl}AUTH/SupervisorPreferences';
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
      }
    } catch (e) {
      setState(() {
        loading = false;
      });
    }
  }
}
