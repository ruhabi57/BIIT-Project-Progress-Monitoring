import 'dart:io';

import 'package:biit_project_progress_monitoring_system/Models/GetTasks.dart';
import 'package:biit_project_progress_monitoring_system/Supervisor/AddRemarksSup.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

import '../Global/global.dart';

class viewUploadedTaskSup extends StatefulWidget {
  final GetTasks tasks;

  viewUploadedTaskSup({super.key, required this.tasks});

  @override
  State<viewUploadedTaskSup> createState() => _viewUploadedTaskSupState();
}

class _viewUploadedTaskSupState extends State<viewUploadedTaskSup> {
  String? savedPath;
  File? _image;
  TextEditingController remarksController = TextEditingController();
  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> downloadAndSaveFile(String url, String fileName) async {
    try {
      // Make the HTTP GET request to download the file
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // Get the temporary directory
        final directory = await getApplicationDocumentsDirectory();

        // Construct the file path
        final filePath = directory.path + '/' + fileName;

        // Create the file and write the response body
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);
        savedPath = filePath;
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Saved successfully!')));
      } else {
        print('Failed to download file: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('View Uploaded Tasks')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Expanded(
            child: Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Colors.grey.shade300,
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
                    child: Center(
                        child: Text(
                      widget.tasks.task_description,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ))),
                Gap(30),
                Row(
                  children: [
                    Gap(10),
                    Column(
                      children: [
                        Text(
                          'File Name:',
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
                    child: Text(
                      widget.tasks.file_name,
                      style: TextStyle(fontSize: 18),
                    )),
                Gap(30),
                ElevatedButton(
                  child: Text("Download",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    try {
                      downloadAndSaveFile(
                          filesBaseUrl + "TasksFiles/" + widget.tasks.file_name,
                          widget.tasks.file_name);
                    } catch (e) {}
                  },
                ),

                Gap(30),
                ElevatedButton(
                  child: Text("Add Remarks",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold)),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AddRemarks()));
                  },
                ),
                // Gap(30),
                // Row(
                //   children: [
                //     Gap(10),
                //     Column(
                //       children: [
                //         Text(
                //           'Remarks:',
                //           style: TextStyle(fontSize: 18),
                //         )
                //       ],
                //     ),
                //   ],
                // ),
                // Gap(10),
                // Container(
                //   padding: EdgeInsets.all(8),
                //   height: 120,
                //   width: double.infinity,
                //   decoration: BoxDecoration(
                //     color: Colors.white,
                //     borderRadius: BorderRadius.circular(20),
                //     //border: Border.all(color: Colors.black, width: 2),
                //     boxShadow: const [
                //       BoxShadow(
                //         blurRadius: 5,
                //         spreadRadius: 5,
                //         color: Colors.black12,
                //       ),
                //     ],
                //   ),
                //   child: TextField(
                //     controller: remarksController,
                //     decoration: InputDecoration(
                //       hintText: 'Enter Remarks',
                //       border: InputBorder.none,
                //     ),
                //   ),
                // ),
                // Gap(30),
                // if (savedPath != null)
                //   Image.file(
                //     File(savedPath!),
                //     height: 600,
                //     width: 600,
                //   ),
                // ElevatedButton(
                //   child: Text(
                //     "View",
                //     style: TextStyle(
                //         color: Colors.black, fontWeight: FontWeight.bold),
                //   ),
                //   onPressed: () {
                //     setState(() {});
                //   },
                // ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
