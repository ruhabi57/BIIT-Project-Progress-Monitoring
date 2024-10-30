import 'package:biit_project_progress_monitoring_system/Models/projects.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../Models/Supervisor.dart';

class projectReAllocation extends StatefulWidget {
  const projectReAllocation({super.key});

  @override
  State<projectReAllocation> createState() => _projectReAllocationState();
}

class _projectReAllocationState extends State<projectReAllocation> {
  Student? selectedStudent1;
  Student? selectedStudent2;
  Student? selectedStudent3;
  Student? selectedStudent4;
  Student? selectedStudent5;
  String? selectedProject;
  SupervisorModel? selectedSupervisor;
  List<String> projectslist = [];
  List<Student> students = [];
  List<SupervisorModel> supervisorlist = [];
  List<String> technologyList = [
    'Flutter',
    'React Native',
    'IOS',
    'Android',
    'Web'
  ];

  bool loading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Re-Allocation'),
      ),
      body: Container(
        margin: const EdgeInsets.fromLTRB(15, 20, 15, 20),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Students',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Technology',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const Gap(20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Center(
                        child: DropdownSearch<Student>(
                      key: ValueKey('studentDropdown'),
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                      ),
                      items: students,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Select Student",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      selectedItem: selectedStudent1,
                      onChanged: (newValue) {
                        setState(() {
                          selectedStudent1 = newValue;
                        });
                      },
                      itemAsString: (Student student) => student.student_name,
                    )),
                  ),
                  Container(
                      height: 60,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
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
                          technologyList[0],
                          style: const TextStyle(
                            fontSize: 14,
                            // fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const Gap(20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Center(
                        child: DropdownSearch<Student>(
                      key: ValueKey('studentDropdown'),
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                      ),
                      items: students,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Select Student",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      selectedItem: selectedStudent2,
                      onChanged: (newValue) {
                        setState(() {
                          selectedStudent2 = newValue;
                        });
                      },
                      itemAsString: (Student student) => student.student_name,
                    )),
                  ),
                  Container(
                      height: 60,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
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
                          technologyList[1],
                          style: const TextStyle(
                            fontSize: 14,
                            // fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const Gap(20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Center(
                        child: DropdownSearch<Student>(
                      key: ValueKey('studentDropdown'),
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                      ),
                      items: students,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Select Student",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      selectedItem: selectedStudent3,
                      onChanged: (newValue) {
                        setState(() {
                          selectedStudent3 = newValue;
                        });
                      },
                      itemAsString: (Student student) => student.student_name,
                    )),
                  ),
                  Container(
                      height: 60,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
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
                          technologyList[2],
                          style: const TextStyle(
                            fontSize: 14,
                            // fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const Gap(20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Center(
                        child: DropdownSearch<Student>(
                      key: ValueKey('studentDropdown'),
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                      ),
                      items: students,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Select Student",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      selectedItem: selectedStudent4,
                      onChanged: (newValue) {
                        setState(() {
                          selectedStudent4 = newValue;
                        });
                      },
                      itemAsString: (Student student) => student.student_name,
                    )),
                  ),
                  Container(
                      height: 60,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
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
                          technologyList[3],
                          style: const TextStyle(
                            fontSize: 14,
                            // fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
                ],
              ),
            ),
            const Gap(20),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Center(
                        child: DropdownSearch<Student>(
                      key: ValueKey('studentDropdown'),
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                      ),
                      items: students,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Select Student",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      selectedItem: selectedStudent5,
                      onChanged: (newValue) {
                        setState(() {
                          selectedStudent5 = newValue;
                        });
                      },
                      itemAsString: (Student student) => student.student_name,
                    )),
                  ),
                  Container(
                      height: 60,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
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
                          technologyList[4],
                          style: const TextStyle(
                            fontSize: 14,
                            // fontWeight: FontWeight.w500,
                          ),
                        ),
                      )),
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
                    width: MediaQuery.of(context).size.width * 0.9,
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
                      selectedItem: selectedSupervisor,
                      onChanged: (newValue) {
                        setState(() {
                          selectedSupervisor = newValue;
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
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Center(
                        child: DropdownSearch<String>(
                      key: ValueKey('projectDropdown'),
                      popupProps: PopupProps.menu(
                        showSearchBox: true,
                      ),
                      items: projectslist,
                      dropdownDecoratorProps: DropDownDecoratorProps(
                        dropdownSearchDecoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: "Select Project",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),
                      selectedItem: selectedProject,
                      onChanged: (newValue) {
                        setState(() {
                          selectedProject = newValue;
                        });
                      },
                    )),
                  ),
                ],
              ),
            ),
            const Gap(10),
            ElevatedButton(
                onPressed: () {},
                child: const Text(
                  'Create',
                  style: TextStyle(color: Colors.black, fontSize: 18),
                )),
          ],
        ),
      ),
    );
  }
}
