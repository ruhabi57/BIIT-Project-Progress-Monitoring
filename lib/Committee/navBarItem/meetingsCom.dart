import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;

import '../../Global/global.dart';
import '../../Models/GetMeetings.dart';

class MeetingCom extends StatefulWidget {
  const MeetingCom({super.key});

  @override
  State<MeetingCom> createState() => _MeetingComState();
}

class _MeetingComState extends State<MeetingCom> {
  List<GetAllMeetings> meetings = [];
  bool loading = true;

  @override
  void initState() {
    getMeetings();
    super.initState();
  }

  getMeetings() async {
    try {
      String uri = '${baseUrl}Meeting/GetAllMeetings';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        for (var e in res) {
          meetings.add(GetAllMeetings.fromJson(e));
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Gap(20),
          Expanded(
            child: ListView.separated(
              itemCount: meetings.length,
              separatorBuilder: (context, index) => SizedBox(height: 10),
              itemBuilder: (context, index) {
                return Container(
                  height: 110,
                  margin: EdgeInsets.fromLTRB(10, 0, 10, 10),
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
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Gap(5),
                                Text(
                                  "${meetings[index].description}",
                                  style: TextStyle(fontWeight: FontWeight.w700),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.person_outline),
                                Text(meetings[index].isWithSupervisor
                                    ? "Supervisor"
                                    : "Committee")
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.date_range_outlined),
                                Text(
                                    "Date: ${meetings[index].meetingDate.toString().split(' ').first}")
                              ],
                            ),
                            Row(
                              children: [
                                Icon(Icons.date_range_outlined),
                                Text(
                                    "Start Time: ${meetings[index].meetingStartTime.toString().split(' ').first}")
                              ],
                            ),
                          ],
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
    );
  }
}
