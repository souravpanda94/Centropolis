import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../utils/utils.dart';
import '../../widgets/bottom_navigation.dart';
import 'login.dart';

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
    var user = Provider.of<UserProvider>(context, listen: false);
    user.initUserProvider();
    startTime();
  }

  @override
  void dispose() {
    super.dispose();
  }

  startTime() async {
    var duration = const Duration(seconds: 3);
    return Timer(duration, navigationPage);
  }

  void navigationPage() {
    var user = Provider.of<UserProvider>(context, listen: false);
    debugPrint(user.userData.toString());

    if (user.userData.isEmpty) {
      debugPrint("===============================");
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const LoginScreen(),
        ),
      );
    } else {
      String checkedSignedIn = user.userData['checked_signed_in'].toString();
      if (checkedSignedIn == "true") {
        debugPrint("&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&&");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigationScreen(0, 0),
          ),
        );
      } else {
        debugPrint("******************************");
        cleanLoginData(context);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              alignment: Alignment.center,
              image: AssetImage("assets/images/splash_image.png"),
              fit: BoxFit.fill,
            ),
          ),
        ));
  }
}
