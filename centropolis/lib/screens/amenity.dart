import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AmenityScreen extends StatefulWidget {
  const AmenityScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AmenityScreenState();
}

class _AmenityScreenState extends State<AmenityScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text('Amenity'),
    );
  }
}
