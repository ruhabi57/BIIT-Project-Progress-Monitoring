import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Supervisor/SupervisorDashboard.dart';
import 'package:biit_project_progress_monitoring_system/Supervisor/navBarItem/dashboardSup.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import '../../Global/global.dart';
import '../../Models/Supervisor.dart';

class scheduleMeetingSup extends StatefulWidget {
  const scheduleMeetingSup({super.key});

  @override
  State<scheduleMeetingSup> createState() => _scheduleMeetingSupState();
}

class _scheduleMeetingSupState extends State<scheduleMeetingSup> {
  List<SupervisorGroups> groups = [];
  bool isLoading = false;
  SupervisorGroups? selectedGroup;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  TextEditingController DescriptionController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  bool loading = true;
  getProjectsbySupervisor() async {
    try {
      String uri =
          '${baseUrl}Groups/GetProjectsbySupervisor?userid=${userdata['user_id']}';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        for (var e in res) {
          groups.add(SupervisorGroups.fromJson(e));
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
    getProjectsbySupervisor();
    super.initState();
  }

  addMeeting() async {
    try {
      setState(() {
        isLoading = true;
      });

      var url = baseUrl + "Meeting/AddSupervisorMeetingsSchedule";

      var data = FormData.fromMap({
        "group_id": selectedGroup!.GroupId,
        "project_id": selectedGroup!.ProjectId,
        "description": DescriptionController.text,
        "is_with_supervisor": true,
        "meeting_date": _selectedDate != null
            ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
            : '',
        "meeting_starttime": _selectedTime != null ? _selectedTime! : ''
      });

      var response = await Dio().post(
        url,
        options: Options(headers: {'Content-Type': "application/json"}),
        data: data,
      );
      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(response.data)));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SupervisorDashboard(),
            ));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
                // color: Colors.grey.shade300,
                borderRadius: BorderRadius.circular(20)),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Row(
                children: [
                  Gap(10),
                  Column(
                    children: [
                      Text(
                        'Description:',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ],
              ),
              Gap(10),
              Container(
                padding: EdgeInsets.all(8),
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
                child: TextField(
                  controller: DescriptionController,
                  decoration: InputDecoration(
                    hintText: 'Enter Description',
                    border: InputBorder.none,
                  ),
                ),
              ),
              Gap(10),
              Row(
                children: [
                  Gap(10),
                  Column(
                    children: [
                      Text(
                        'Select FYP Groups:',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ],
              ),
              Gap(10),
              Container(
                padding: EdgeInsets.all(8),
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
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    isExpanded: true,
                    value: selectedGroup,
                    hint: Text("Select a group"),
                    items: groups.map((group) {
                      return DropdownMenuItem(
                        value: group,
                        child: Text(group.ProjectTitle),
                      );
                    }).toList(),
                    onChanged: (newValue) {
                      setState(() {
                        selectedGroup = newValue;
                      });
                    },
                  ),
                ),
              ),
              Gap(10),
              Row(
                children: [
                  Gap(10),
                  Column(
                    children: [
                      Text(
                        'Meeting Date:',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ],
              ),
              Gap(10),
              Container(
                padding: EdgeInsets.all(8),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _selectedDate != null
                        ? Text(
                            DateFormat('yyyy-MM-dd').format(_selectedDate!!),
                            style: TextStyle(fontSize: 16),
                          )
                        : Text('yyyy-MM-dd'),
                    IconButton(
                      icon: Icon(Icons.calendar_month_outlined),
                      onPressed: () => _selectDate(context),
                    ),
                  ],
                ),
              ),
              Gap(10),
              Row(
                children: [
                  Gap(10),
                  Column(
                    children: [
                      Text(
                        'Meeting Time:',
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                ],
              ),
              Gap(10),
              Container(
                padding: EdgeInsets.all(8),
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _selectedTime != null
                          ? _selectedTime!.format(context)
                          : 'Select Time',
                      style: TextStyle(fontSize: 16),
                    ),
                    Gap(220),
                    IconButton(
                      icon: Icon(Icons.access_time),
                      onPressed: () => _selectTime(context),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Gap(20),
              ElevatedButton(
                child: Text(
                  "Schedule",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black),
                ),
                onPressed: () {
                  addMeeting();
                },
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
