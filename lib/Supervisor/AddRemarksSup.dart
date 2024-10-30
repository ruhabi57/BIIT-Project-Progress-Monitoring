import 'package:flutter/material.dart';

class AddRemarks extends StatefulWidget {
  const AddRemarks({super.key});

  @override
  State<AddRemarks> createState() => _AddRemarksState();
}

class _AddRemarksState extends State<AddRemarks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Remarks')),
    );
  }
}
