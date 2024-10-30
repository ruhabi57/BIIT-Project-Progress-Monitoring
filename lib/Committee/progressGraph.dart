import 'package:d_chart/d_chart.dart';
import 'package:flutter/material.dart';

class ProgressGraph extends StatefulWidget {
  const ProgressGraph({super.key});

  @override
  State<ProgressGraph> createState() => _ProgressGraphState();
}

class _ProgressGraphState extends State<ProgressGraph> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Progress Graph')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 40,
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: Colors.grey.shade300),
          child: SizedBox(
            child: DChartSingleBar(
              radius: BorderRadius.all(Radius.circular(3)),
              backgroundColor: const Color.fromARGB(255, 153, 138, 138),
              foregroundColor: Colors.green,
              value: 80,
              max: 100,
            ),
          ),
        ),
      ),
    );
  }
}
