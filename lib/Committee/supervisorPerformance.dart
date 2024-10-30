import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Committee/performanceDetail.dart';
import 'package:biit_project_progress_monitoring_system/Models/GetScoreCounts.dart';
import 'package:biit_project_progress_monitoring_system/Models/Supervisor.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import '../Global/global.dart';
import '../Models/GradesCounts.dart';

class supervisorPerformnce extends StatefulWidget {
  const supervisorPerformnce({super.key});

  @override
  State<supervisorPerformnce> createState() => _supervisorPerformnceState();
}

class _supervisorPerformnceState extends State<supervisorPerformnce> {
  TextEditingController searchController = TextEditingController();
  List<GetScoreCounts> filteredSupervisor = [];
  List<GetScoreCounts> supervisors = [];

  bool loading = false;

  List<GetScoreCounts> searchSupervisors(String query) {
    return supervisors.where((supervisor) {
      final nameLower = supervisor.supervisorname.toLowerCase();
      final queryLower = query.toLowerCase();

      return nameLower.contains(queryLower);
    }).toList();
  }

  Future<void> getAllSupervisorList() async {
    try {
      String uri = '${baseUrl}Grading/GetScoreCounts';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        for (var data in jsonDecode(response.body)) {
          supervisors.add(GetScoreCounts.fromMap(data));
        }

        print(supervisors);
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
    getAllSupervisorList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Supervisors')),
        body: Container(
          margin: const EdgeInsets.all(20.0),
          child: Column(children: [
            Container(
              // margin: EdgeInsets.symmetric(vertical: 10.0),
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: 'Enter Supervisor Name',
                  filled: true,
                  fillColor: Colors.white,
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search),
                    onPressed: () {
                      setState(() {
                        filteredSupervisor =
                            searchSupervisors(searchController.text);
                      });
                    },
                  ),
                ),
              ),
            ),
            Gap(30),
            Expanded(
              child: loading
                  ? Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: supervisors.length,
                      itemBuilder: (context, index) {
                        GetScoreCounts getscore = supervisors[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => (performanceDetail(
                                          supervisorModel: getscore,
                                        ))));
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            height: 70,
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
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  supervisors[index].supervisorname,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                                Text(
                                  '(${supervisors[index].totalcounts.toString()})',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ]),
        ));
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
