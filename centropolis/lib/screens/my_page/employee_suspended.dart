import 'package:flutter/material.dart';

class EmployeeSuspended extends StatefulWidget {
  const EmployeeSuspended({super.key});

  @override
  State<EmployeeSuspended> createState() => _EmployeeSuspendedState();
}

class _EmployeeSuspendedState extends State<EmployeeSuspended> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Suspended"),
    );
  }
}
