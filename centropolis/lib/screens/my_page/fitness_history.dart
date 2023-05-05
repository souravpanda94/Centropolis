import 'package:flutter/widgets.dart';

class FitnessHistory extends StatefulWidget {
  const FitnessHistory({super.key});

  @override
  State<FitnessHistory> createState() => _FitnessHistoryState();
}

class _FitnessHistoryState extends State<FitnessHistory> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("fitness"),
    );
  }
}
