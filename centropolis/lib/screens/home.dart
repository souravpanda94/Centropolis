import 'package:centropolis/utils/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: CustomColors.appBackgroundColor,
        leading: IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/images/ic_drawer.svg')),
        title: Image.asset('assets/images/logo_image.png'),
        actions: [
          IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(
                'assets/images/ic_notification_with_indicator.svg',
              ))
        ],
      ),
      body: Column(
        children: [
          Image.asset(
            'assets/images/home_image.png',
            height: 510,
          ),
        ],
      ),
    );
  }
}
