import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Models/ScoreModel.dart';
import 'package:biit_project_progress_monitoring_system/Models/studentModel.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import '../Global/global.dart';

class grading extends StatefulWidget {
  int student_id;
  grading({Key? key, required this.student_id}) : super(key: key);

  @override
  State<grading> createState() => _gradingState();
}

class _gradingState extends State<grading> {
  Grade? grades;
  bool loading = true;

  Future<void> getCalculatedGrades() async {
    try {
      String uri =
          '${baseUrl}Grading/GetCalculatedGrades?student_id=${widget.student_id}';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        grades = Grade.fromMap(res);
        print(grades);
        setState(() {
          loading = false;
        });
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
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
    getCalculatedGrades();
    super.initState();
  }

  // String calculateLetterGrade() {

  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gradings'),
      ),
      body: loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    height: 650,
                    width: 500,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.shade300,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 20),
                          const Text(
                            'Individual Grading:',
                            style: TextStyle(fontSize: 18),
                          ),
                          Gap(20),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.55,
                            child: ListView.builder(
                                itemCount: grades!.scores.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14.0),
                                    child: Row(
                                      children: [
                                        Container(
                                          height: 60,
                                          width: 150,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: const [
                                              BoxShadow(
                                                blurRadius: 5,
                                                spreadRadius: 5,
                                                color: Colors.black12,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              grades!.scores![index]!.Criteria!,
                                              style:
                                                  const TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        const Gap(30),
                                        Container(
                                          height: 60,
                                          width: 100,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            boxShadow: const [
                                              BoxShadow(
                                                blurRadius: 5,
                                                spreadRadius: 5,
                                                color: Colors.black12,
                                              ),
                                            ],
                                          ),
                                          child: Center(
                                            child: Text(
                                              grades != null
                                                  ? grades!.scores![index]!
                                                          .AverageScore!
                                                          .toString() +
                                                      "/" +
                                                      grades!.scores![index]!
                                                          .ScoreWeight!
                                                          .toString()
                                                  : '-',
                                              style:
                                                  const TextStyle(fontSize: 18),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          const Text(
                            'Cumulative Grade:',
                            style: TextStyle(fontSize: 18),
                          ),
                          const Gap(10),
                          Container(
                            height: 60,
                            width: 100,
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
                            child: Center(
                              child: Text(
                                grades!.Grades,
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
