import 'dart:io';
import 'package:biit_project_progress_monitoring_system/Global/global.dart';
import 'package:biit_project_progress_monitoring_system/Models/GetTasks.dart';
import 'package:biit_project_progress_monitoring_system/Student/studentDashboard.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class uploadTask extends StatefulWidget {
  final GetTasks getTasks;
  const uploadTask({super.key, required this.getTasks});

  @override
  State<uploadTask> createState() => _uploadTaskState();
}

class _uploadTaskState extends State<uploadTask> {
  File? _image;

  Future<void> _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  uploadTaskByStudent() async {
    try {
      setState(() {
        isLoading = true;
      });
      if (_image == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Upload file')));
        return;
      }
      var url = baseUrl + "Tasks/AddTask";

      var data = FormData.fromMap({
        "isStudent": true,
        "task_id": widget.getTasks.task_id,
        "fileUrl": await MultipartFile.fromFile(_image!.path)
      });
      var response = await Dio().post(
        url,
        options: Options(headers: {'Content-Type': "application/json"}),
        data: data,
      );
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(response.data)));
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => StudentDashboard(),
          ));
    } catch (e) {}
    setState(() {
      isLoading = false;
    });
  }

  String selectedOption = '';
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upload Task')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 800,
          padding: EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20)),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height: 10,
            ),
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
              height: 150,
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(widget.getTasks.task_description),
                    ],
                  ),
                ],
              ),
            ),
            Gap(30),
            ElevatedButton(
              child: Text("Download",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 15)),
              onPressed: () async {
                try {
                  downloadAndSaveFile(
                      filesBaseUrl + "TasksFiles/" + widget.getTasks.file_name,
                      widget.getTasks.file_name);
                } catch (e) {}
              },
            ),
            Gap(30),
            if (savedPath != null)
              Image.file(
                File(savedPath!),
                height: 200,
                width: 200,
              ),
            ElevatedButton(
              child: Text(
                "View",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              onPressed: () {
                setState(() {});
              },
            ),
            Column(children: [
              Gap(20),
              Row(children: [
                Gap(10),
                Column(
                  children: [
                    Text(
                      'Upload File:',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                ),
              ]),
              Column(
                children: [
                  Gap(10),
                  Row(
                    children: [
                      Gap(10),
                      Column(
                        children: [
                          Container(
                              height: 60,
                              width: 300,
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Gap(10),
                                  SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.3,
                                      child: Text(
                                        _image != null
                                            ? _image!.path.split('/').last
                                            : '',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      )),
                                  Icon(Icons.file_open_outlined),
                                  Gap(10),
                                  ElevatedButton(
                                      onPressed: () {
                                        _getImage();
                                      },
                                      child: Text(
                                        'Choose File',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 15),
                                      ))
                                ],
                              ))
                        ],
                      ),
                    ],
                  )
                ],
              ),
            ]),
            Gap(10),
            Gap(30),
            isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    onPressed: () {
                      uploadTaskByStudent();
                    },
                    child: Text(
                      'Upload',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ))
          ]),
        ),
      ),
    );
  }

  String? savedPath;

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
}
