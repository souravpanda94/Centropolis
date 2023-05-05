import 'package:flutter/material.dart';

class EmployeeBeforeApproval extends StatefulWidget {
  const EmployeeBeforeApproval({super.key});

  @override
  State<EmployeeBeforeApproval> createState() => _EmployeeBeforeApprovalState();
}

class _EmployeeBeforeApprovalState extends State<EmployeeBeforeApproval> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text("Before Approval"),
    );
  }
}
