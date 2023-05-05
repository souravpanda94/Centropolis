import 'package:flutter/widgets.dart';

class ConferenceHistory extends StatefulWidget {
  const ConferenceHistory({super.key});

  @override
  State<ConferenceHistory> createState() => _ConferenceHistoryState();
}

class _ConferenceHistoryState extends State<ConferenceHistory> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Conference"),
    );
  }
}
