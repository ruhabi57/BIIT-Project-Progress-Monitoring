import 'package:flutter/material.dart';

class ViewTaskComments extends StatefulWidget {
  const ViewTaskComments({super.key});

  @override
  State<ViewTaskComments> createState() => _ViewTaskCommentsState();
}

class _ViewTaskCommentsState extends State<ViewTaskComments> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('View Task Comments')),
    );
  }
}
