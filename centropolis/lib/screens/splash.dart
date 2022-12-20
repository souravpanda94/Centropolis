import 'dart:async';
import 'dart:io';
import 'package:centropolis/screens/home.dart';
import 'package:centropolis/screens/visitor_reservations.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _SplashScreenState();
  }
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTime();
    // initializeNotifications();
  }

  @override
  void dispose() {
    super.dispose();
  }


  startTime() async {
    var _duration = const Duration(seconds: 2);
    return Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        // builder: (context) => const HomeScreen(),
        builder: (context) => const VisitorReservationsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        // child: Image.asset(
        //   'assets/images/app_logo_orange.png',
        //   fit: BoxFit.contain,
        //   width: 210,
        //   height: 65,
        // ),
        child: Text(
          "Splash screen",
          style: TextStyle(
            fontSize: 40,
            color: Colors.purple,
            fontFamily: 'Regular',
          ),
        ),
      ),
    );
  }

}
