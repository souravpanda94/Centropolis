import 'package:flutter/cupertino.dart';

class Lounge extends StatelessWidget {
  const Lounge({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Lounge',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
    );
  }
}
