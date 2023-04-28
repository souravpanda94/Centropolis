
import 'package:centropolis/widgets/amenity/amenity_row.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../utils/custom_colors.dart';
import '../../../widgets/home_page_app_bar.dart';
import '../../home/bar_code.dart';
import 'facilities.dart';
import 'fitness.dart';
import 'lounge.dart';
import 'meeting_room.dart';


class AmenityScreen extends StatefulWidget {
  const AmenityScreen({super.key});

  @override
  State<StatefulWidget> createState() => _AmenityScreenState();
}

class _AmenityScreenState extends State<AmenityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: HomePageAppBar(tr("amenity"), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BarCodeScreen(),
                ),
              );
            }, () {}),
          ),
        ),
      ),
      body: DefaultTabController(
          length: 4,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const TabBar(
                  isScrollable: true,
                  labelColor: CustomColors.buttonBackgroundColor,
                  indicatorColor: CustomColors.buttonBackgroundColor,
                  unselectedLabelColor: CustomColors.textColor1,
                  tabs: [
                    Tab(
                      child: Text(
                        'Meeting room',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Regular',
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Fitness',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Regular',
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Facilities',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Regular',
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Lounge',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'Regular',
                            fontWeight: FontWeight.w400),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height -
                      kToolbarHeight -
                      MediaQuery.of(context).padding.top -
                      kBottomNavigationBarHeight -
                      kTextTabBarHeight,
                  child: const TabBarView(children: <Widget>[
                    MeetingRoom(),
                    Fitness(),
                    Facilities(),
                    Lounge()
                  ]),
                )
              ],
            ),
          )),
    );
  }
}
