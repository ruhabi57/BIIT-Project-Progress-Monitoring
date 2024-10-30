import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Committee/committeeDashboard.dart';
import 'package:biit_project_progress_monitoring_system/Models/GetCriteria.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:multi_select_flutter/util/multi_select_list_type.dart';
import '../../Global/global.dart';
import 'package:http/http.dart' as http;

class ScheduleMeetingCom extends StatefulWidget {
  const ScheduleMeetingCom({super.key});

  @override
  State<ScheduleMeetingCom> createState() => _ScheduleMeetingComState();
}

class _ScheduleMeetingComState extends State<ScheduleMeetingCom> {
  List<String> FYPgroups = ['FYP-0', 'FYP-1', 'FYP-2'];
  bool isLoading = false;
  bool loading = true;
  String? selectedGroup;
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  bool isGraded = false;
  List<MultiSelectItem<Object?>> options = [];
  List<dynamic> selectedCriteria = [];

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
        print(_selectedTime);
      });
    }
  }

  addMeeting() async {
    try {
      setState(() {
        isLoading = true;
      });

      var url = baseUrl + "Meeting/AddMeetingsSchedule";

      var data = FormData.fromMap({
        "fyp_type": FYPgroups.indexWhere((element) => element == selectedGroup),
        "description": DescriptionController.text,
        "is_with_supervisor": false,
        "meeting_date": _selectedDate != null
            ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
            : '',
        "meeting_starttime": _selectedTime != null ? _selectedTime! : '',
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
              builder: (context) => committeeDashboard(),
            ));
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> getCriteria() async {
    setState(() {
      loading = true;
    });

    try {
      String uri = '${baseUrl}Grading/GetCriteria?role=${userdata['role']}';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        List<dynamic> responseData = jsonDecode(response.body);
        List<Criteria> criteria = [];
        setState(() {
          criteria =
              responseData.map((data) => Criteria.fromMap(data)).toList();
          for (var i in criteria) {
            options.add(
                MultiSelectItem(i.score_id, '${i.criteria} ${i.score_weight}'));
          }
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
    super.initState();
    getCriteria();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(20)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
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
                          boxShadow: const [
                            BoxShadow(
                              blurRadius: 5,
                              spreadRadius: 5,
                              color: Colors.black12,
                            ),
                          ],
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: selectedGroup,
                            hint: Text("Select a group"),
                            items: FYPgroups.map((String group) {
                              return DropdownMenuItem<String>(
                                value: group,
                                child: Text(group),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
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
                                    DateFormat('yyyy-MM-dd')
                                        .format(_selectedDate!),
                                    style: TextStyle(fontSize: 16),
                                  )
                                : Container(),
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
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              _selectedTime != null
                                  ? _selectedTime!.format(context)
                                  : 'Select Time',
                              style: TextStyle(fontSize: 16),
                            ),
                            Spacer(),
                            IconButton(
                              icon: Icon(Icons.access_time),
                              onPressed: () => _selectTime(context),
                            ),
                          ],
                        ),
                      ),
                      Gap(20),
                      Row(
                        children: [
                          Checkbox(
                              value: isGraded,
                              onChanged: (val) {
                                setState(() {
                                  isGraded = val!;
                                });
                              }),
                          Text(
                            'Is Graded',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Gap(20),
                      MultiSelectDialogField(
                        items: options,
                        listType: MultiSelectListType.LIST,
                        onConfirm: (values) {
                          selectedCriteria = values;
                          print(selectedCriteria);
                        },
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
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
