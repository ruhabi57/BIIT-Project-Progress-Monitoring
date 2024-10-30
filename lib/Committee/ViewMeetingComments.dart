import 'package:flutter/material.dart';

class ViewMeetingComments extends StatefulWidget {
  const ViewMeetingComments({super.key});

  @override
  State<ViewMeetingComments> createState() => _ViewMeetingCommentsState();
}

class _ViewMeetingCommentsState extends State<ViewMeetingComments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Meeting Comments')),
    );
  }
}
