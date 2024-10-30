import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class addMember extends StatefulWidget {
  const addMember({super.key});

  @override
  State<addMember> createState() => _addMemberState();
}

class _addMemberState extends State<addMember> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Member'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: EdgeInsets.all(8),
          height: 100,
          width: double.infinity,
          margin: EdgeInsets.only(bottom: 20),
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
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Text('Student Name:'), Text('Platform:')],
                ),
                Gap(10),
                Center(
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        'Add',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.black),
                      )),
                ),
              ]),
        ),
      ),
    );
  }
}
