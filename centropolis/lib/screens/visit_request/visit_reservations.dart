import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import 'view_visit_reservation.dart';
import 'visit_inquiry.dart';
import 'visit_reservation_filter.dart';

class VisitReservationsScreen extends StatefulWidget {
  const VisitReservationsScreen({super.key});

  @override
  State<VisitReservationsScreen> createState() =>
      _VisitReservationsScreenState();
}

class _VisitReservationsScreenState extends State<VisitReservationsScreen> {
  final List<Tab> myTabs = <Tab>[
    Tab(text: tr("viewVisitReservation")),
    Tab(text: tr("visitInquiry")),
  ];

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
    return DefaultTabController(
      length: 2,
      // initialIndex: widget.page,
      initialIndex: 0,
      child: Scaffold(
        backgroundColor: CustomColors.whiteColor,
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
            tr("visitor"),
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
          actions: [
            IconButton(
              icon: SvgPicture.asset(
                "assets/images/ic_filter.svg",
                semanticsLabel: 'Back',
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const VisitReservationFilter(),
                  ),
                );
              },
            )
          ],
          bottom: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: Column(
              children: [
                // const Divider(
                //   color: CustomColors.borderColor,
                //   height: 1.0,
                // ),
                DecoratedBox(
                  decoration: const BoxDecoration(
                    color: CustomColors.whiteColor,
                    border: Border(
                        bottom: BorderSide(
                            color: CustomColors.backgroundColor2, width: 0.5)),
                  ),
                  child: TabBar(
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
                      // insets: EdgeInsets.symmetric(horizontal:16.0)
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        body: const TabBarView(
          // physics: const NeverScrollableScrollPhysics(),
          children: [
            ViewVisitReservationScreen(),
            VisitInquiryScreen(),
          ],
        ),
      ),
    );
  }
}
