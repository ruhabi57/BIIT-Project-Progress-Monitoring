import 'dart:convert';

import 'package:biit_project_progress_monitoring_system/Models/GroupFormationRequestsModel.dart';
import 'package:flutter/material.dart';

import '../../Global/global.dart';
import 'package:http/http.dart' as http;

class Request extends StatefulWidget {
  const Request({Key? key}) : super(key: key);

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  initState() {
    super.initState();
    getRequests();
  }

  List<GroupFormationRequest> requests = [];
  bool loading = true;
  getRequests() async {
    try {
      String uri =
          '${baseUrl}AcceptReject/GetStudentRequests?userId=${userdata['user_id']}';
      http.Response response = await http.get(Uri.parse(uri));
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body);
        for (var e in res) {
          requests.add(GroupFormationRequest.fromMap(e));
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

  saveAcceptRequest(bool isAccepted, int requestId) async {
    try {
      String url = baseUrl +
          'AcceptReject/acceptStudentRequest?userId=${userdata['user_id']}&isAccepted=$isAccepted&requestId=$requestId';
      var resp = await http.get(Uri.parse(url));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(resp.body),
          duration: const Duration(seconds: 3),
        ),
      );
      if (isAccepted) {
        setState(() {
          requests.clear();
          Navigator.pop(context);
        });
      }
    } catch (e) {}
  }

  _showDialogBox(String msg, bool isAccepted, int requestId) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            icon: const Icon(
              Icons.info,
              size: 50,
            ),
            content: Text(msg),
            actions: [
              TextButton(
                onPressed: () {
                  saveAcceptRequest(isAccepted, requestId);
                },
                child: Text('OK'),
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : requests.isEmpty
              ? Center(
                  child: Text('No Requests'),
                )
              : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.separated(
                      itemBuilder: (context, index) => Container(
                            height: 175,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 5,
                                  spreadRadius: 5,
                                  color: Colors.black12,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "${requests[index].senderName.capitalizeFirstLetter()} has requested you to join his group!\nPlatform: ${requests[index].technology_preference}\nWould you like to join?",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            _showDialogBox(
                                                'You have Created Fyp Group with ${requests[index].senderName.capitalizeFirstLetter()} Your Platform Is ${requests[index].technology_preference}',
                                                true,
                                                requests[index].request_id);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.green.shade500,
                                            onPrimary: Colors.black,
                                          ),
                                          child: const Text('Accept'),
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () {
                                            saveAcceptRequest(false,
                                                requests[index].request_id);
                                            // _showDialogBox(
                                            //     'Request regected!!');
                                          },
                                          style: ElevatedButton.styleFrom(
                                            primary: Colors.red.shade500,
                                            onPrimary: Colors.black,
                                          ),
                                          child: const Text('Reject'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10),
                      itemCount: requests.length)),
    );
  }
}
