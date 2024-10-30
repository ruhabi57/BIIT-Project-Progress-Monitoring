// ignore_for_file: avoid_print

import 'package:biit_project_progress_monitoring_system/Global/global.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:timeago/timeago.dart' as timeago;
import 'package:intl/intl.dart';
import '../Models/projects.dart';

class ChatGroup extends StatefulWidget {
  final Projects project;
  const ChatGroup({super.key, required this.project});

  @override
  State<ChatGroup> createState() => _ChatGroupState();
}

class _ChatGroupState extends State<ChatGroup> {
  TextEditingController textController = TextEditingController();
  List<Message> messages = [];
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    fetchMessages();
    _timer =
        Timer.periodic(const Duration(seconds: 1), (timer) => fetchMessages());
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  Future<void> sendMessage(String text) async {
    String uri = '${baseUrl}Chat/AddChat';
    final response = await http.post(
      Uri.parse(uri),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'sender_id': userdata['user_id'], // Replace with actual sender_id
        'receiver_id': widget.project.members.first
            .group_id, // Assuming project.id is the group ID
        'chat': text
      }),
    );

    if (response.statusCode == 200) {
      setState(() {
        textController.clear();
      });
    } else {
      // Handle error
      print('Failed to send message: ${response.body}');
    }
  }

  Future<void> fetchMessages() async {
    String uri =
        '${baseUrl}Chat/GetChats?groupid=${widget.project.members.first.group_id}';
    final response = await http.get(Uri.parse(uri));

    if (response.statusCode == 200) {
      List<dynamic> responseBody = json.decode(response.body);
      print(responseBody);
      setState(() {
        messages = responseBody.map((json) => Message.fromJson(json)).toList();
      });
    } else {
      // Handle error
      print('Failed to fetch messages: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.project.project_title)),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              reverse: true, // This makes the new messages appear at the bottom
              itemBuilder: (context, index) {
                final message = messages[index];
                return MessageBubble(
                  text: message.text,
                  senderName: message.senderName,
                  timestamp: message.createdAt,
                  isMe: message.senderId == userdata['user_id'],
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          blurRadius: 5,
                          offset:
                              const Offset(0, 3), // changes position of shadow
                        ),
                      ],
                    ),
                    child: TextField(
                      controller: textController,
                      decoration: const InputDecoration(
                        hintText: 'Enter your message...',
                        border: InputBorder.none, // Hides the underline
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 10.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.send,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    if (textController.text.isNotEmpty) {
                      sendMessage(textController.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Message {
  final int senderId;
  final String senderName;
  final int receiverId;
  final String text;
  final String createdAt;

  Message({
    required this.senderId,
    required this.senderName,
    required this.receiverId,
    required this.text,
    required this.createdAt,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      senderId: json['sender_id'],
      senderName: json['SenderName'],
      receiverId: json['receiver_id'],
      text: json['chat'],
      createdAt: json['created_at'],
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String text;
  final String senderName;
  final String timestamp;
  final bool isMe;

  const MessageBubble({
    Key? key,
    required this.text,
    required this.senderName,
    required this.timestamp,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final parsedDate = DateFormat('M/d/yyyy h:mm:ss a').parse(timestamp);
    final formattedTime = timeago.format(parsedDate);

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment:
            isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          isMe
              ? const SizedBox()
              : Text(
                  senderName,
                  style: const TextStyle(
                    fontSize: 12.0,
                    color: Colors.black54,
                  ),
                ),
          Material(
            borderRadius: isMe
                ? const BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  )
                : const BorderRadius.only(
                    topRight: Radius.circular(30.0),
                    bottomLeft: Radius.circular(30.0),
                    bottomRight: Radius.circular(30.0),
                  ),
            elevation: 5.0,
            color: isMe ? Colors.lightBlueAccent : Colors.white,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 15.0,
                  color: isMe ? Colors.white : Colors.black54,
                ),
              ),
            ),
          ),
          Text(
            formattedTime,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
        ],
      ),
    );
  }
}
