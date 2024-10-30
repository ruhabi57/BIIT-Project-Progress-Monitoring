import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class gradingSup extends StatefulWidget {
  const gradingSup({super.key});

  @override
  State<gradingSup> createState() => _gradingSupState();
}

class _gradingSupState extends State<gradingSup> {
  String? selectedStudent;
  String? selectedCriteria;
  List<String> ProjectList = [];
  List<String> selectedvalue = [];
  List<String> students = [];
  String? selectedProject;

  List<String> criteriaList = ['Demo', 'API', 'Pitching', 'Documentation'];
  @override
  void initState() {
    selectedvalue.add(criteriaList.first);
    selectedvalue.add(students.first);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Add Grading')),
        body: Padding(
            padding:
                const EdgeInsets.only(left: 8, right: 8, top: 60, bottom: 20),
            child: SingleChildScrollView(
              child: Container(
                height: 500,
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(children: [
                  Gap(20),
                  Gap(20),
                  Column(children: [
                    Gap(20),
                    Row(children: [
                      Gap(10),
                      Column(
                        children: [
                          Text(
                            'Select Project:',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ]),
                    Gap(10),
                    Column(children: [
                      DropdownSearch<String>(
                        popupProps: PopupProps.menu(
                          showSearchBox: true,
                        ),
                        items: ProjectList,
                        dropdownDecoratorProps: DropDownDecoratorProps(
                          dropdownSearchDecoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Select Project",
                          ),
                        ),
                        onChanged: (newValue) {
                          setState(() {
                            selectedProject = newValue;
                          });
                        },
                      ),
                      Column(
                        children: [
                          Gap(20),
                          Row(children: [
                            Gap(10),
                            Column(
                              children: [
                                Text(
                                  'Select Student:',
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ]),
                          Gap(10),
                          Column(
                            children: [
                              DropdownButtonHideUnderline(
                                child: DropdownButtonFormField(
                                    hint: Text('Select Student'),
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.grey.shade300),
                                    onChanged: (newValue) {
                                      setState(() {
                                        selectedStudent = newValue!;
                                      });
                                    },
                                    items: students
                                        .map((student) => DropdownMenuItem(
                                              value: student,
                                              child: Text(student),
                                            ))
                                        .toList()),
                              ),
                              Gap(30),
                              Row(children: [
                                Gap(10),
                                Column(
                                  children: [
                                    Text(
                                      'Select Criteria:',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ]),
                              Gap(20),
                              Row(
                                children: [
                                  SizedBox(
                                    width: 240,
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButtonFormField(
                                          hint: Text('Select Criteria'),
                                          decoration: InputDecoration(
                                              filled: true,
                                              fillColor: Colors.grey.shade300),
                                          onChanged: (newValue) {
                                            setState(() {
                                              selectedCriteria = newValue!;
                                            });
                                          },
                                          items: criteriaList
                                              .map((criteria) =>
                                                  DropdownMenuItem(
                                                    value: criteria,
                                                    child: Text(criteria),
                                                  ))
                                              .toList()),
                                    ),
                                  ),
                                  Gap(30),
                                  SizedBox(
                                    width: 100,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey.shade300),
                                      keyboardType: TextInputType.number,
                                    ),
                                  )
                                ],
                              ),
                              Gap(60),
                              ElevatedButton(
                                  onPressed: () {},
                                  child: Text(
                                    'Save',
                                    style: TextStyle(
                                        color: Colors.black, fontSize: 18),
                                  ))
                            ],
                          )
                        ],
                      ),
                    ]),
                  ]),
                ]),
              ),
            )));
  }
}
