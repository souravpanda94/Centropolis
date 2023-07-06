import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_svg/svg.dart';

import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import 'conference_history.dart';
import 'facility_history.dart';
import 'fitness_history.dart';
import 'lounge_history.dart';

class AmenityReservationHistory extends StatefulWidget {
  const AmenityReservationHistory({super.key});

  @override
  State<AmenityReservationHistory> createState() =>
      _AmenityReservationHistoryState();
}

class _AmenityReservationHistoryState extends State<AmenityReservationHistory> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: tr("lounge")),
    Tab(text: tr("conferenceHeading")),
    Tab(text: tr("fitness")),
    Tab(text: tr("sleepingRoom")),
    // Tab(
    //     child: Text(
    //   tr("lounge"),
    //   textAlign: TextAlign.center,
    // )),
    // Tab(
    //     child: Text(
    //   tr("conferenceHeading"),
    //   textAlign: TextAlign.center,
    // )),
    // Tab(
    //     child: Text(
    //   tr("fitness"),
    //   textAlign: TextAlign.center,
    // )),
    // Tab(
    //     child: Text(
    //   tr("sleepingRoom"),
    //   maxLines: 1,
    //   textAlign: TextAlign.center,
    // )),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 4,
        child: Scaffold(
          backgroundColor: CustomColors.backgroundColor,
          appBar: AppBar(
            toolbarHeight: 54,
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            elevation: 0,
            backgroundColor: CustomColors.whiteColor,
            title: Text(
              tr("amenityReservationHistory"),
              style: const TextStyle(
                color: CustomColors.textColor8,
                fontFamily: 'SemiBold',
                fontSize: 16.0,
              ),
              textAlign: TextAlign.center,
            ),
            leading: IconButton(
              icon: SvgPicture.asset(
                "assets/images/ic_back.svg",
                semanticsLabel: 'Back',
              ),
              onPressed: () {
                onBackButtonPress(context);
              },
            ),
            bottom: PreferredSize(
              preferredSize: AppBar().preferredSize,
              child: Column(
                children: [
                  DecoratedBox(
                    decoration: const BoxDecoration(
                      color: CustomColors.whiteColor,
                      border: Border(
                          bottom: BorderSide(
                              color: CustomColors.backgroundColor2,
                              width: 0.5)),
                    ),
                    child: TabBar(
                      labelPadding: EdgeInsets.zero,
                      tabs: myTabs,
                      labelColor: CustomColors.textColor8,
                      labelStyle: const TextStyle(
                        color: CustomColors.textColor8,
                        fontSize: 14,
                        fontFamily: 'SemiBold',
                      ),
                      unselectedLabelColor: CustomColors.greyColor1,
                      unselectedLabelStyle: const TextStyle(
                        color: CustomColors.greyColor1,
                        fontSize: 14,
                        fontFamily: 'Regular',
                      ),
                      indicatorColor: CustomColors.textColor9,
                      indicator: const UnderlineTabIndicator(
                        borderSide: BorderSide(
                            width: 2.0, color: CustomColors.textColor9),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              LoungeHistory(),
              ConferenceHistory(),
              FitnessHistory(),
              FacilityHistory()
            ],
          ),
        ));
  }
}
