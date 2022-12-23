import 'dart:convert';
import 'package:centropolis/screens/visitor_reservations/reservation_details.dart';
import 'package:centropolis/screens/visitor_reservations/visit_reservation_application.dart';
import 'package:centropolis/widgets/common_app_bar.dart';
import 'package:centropolis/widgets/common_button_with_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/home_page_app_bar.dart';
import 'lookup_condition.dart';

class VisitorReservationsViewAllScreen extends StatefulWidget {
  const VisitorReservationsViewAllScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VisitorReservationsViewAllScreenState();
  }
}

class _VisitorReservationsViewAllScreenState
    extends State<VisitorReservationsViewAllScreen> {
  List<dynamic> todayList = [
    {
      "id": 1,
      "name": "Hong Gil Dong",
      "businessType": "consulting",
      "type": "business",
      "dateTime": "2021.03.21 13:00",
      "status": "before visit"
    },
    {
      "id": 2,
      "name": "Hong Gil Dong",
      "businessType": "consulting",
      "type": "business",
      "dateTime": "2021.03.21 13:00",
      "status": "before visit"
    },
    {
      "id": 3,
      "name": "Hong Gil Dong",
      "businessType": "consulting",
      "type": "business",
      "dateTime": "2021.03.21 13:00",
      "status": "before visit"
    },
    {
      "id": 4,
      "name": "Hong Gil Dong",
      "businessType": "consulting",
      "type": "business",
      "dateTime": "2021.03.21 13:00",
      "status": "before visit"
    },
    {
      "id": 5,
      "name": "Hong Gil Dong",
      "businessType": "consulting",
      "type": "business",
      "dateTime": "2021.03.21 13:00",
      "status": "before visit"
    },
    {
      "id": 6,
      "name": "Hong Gil Dong",
      "businessType": "consulting",
      "type": "business",
      "dateTime": "2021.03.21 13:00",
      "status": "before visit"
    },
    {
      "id": 7,
      "name": "Hong Gil Dong",
      "businessType": "consulting",
      "type": "business",
      "dateTime": "2021.03.21 13:00",
      "status": "before visit"
    },
    {
      "id": 8,
      "name": "Hong Gil Dong",
      "businessType": "consulting",
      "type": "business",
      "dateTime": "2021.03.21 13:00",
      "status": "before visit"
    },
    {
      "id": 9,
      "name": "Hong Gil Dong",
      "businessType": "consulting",
      "type": "business",
      "dateTime": "2021.03.21 13:00",
      "status": "before visit"
    }
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void goToLookupCondition() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LookupConditionScreen(),
      ),
    );
  }

  void goToReservationDetailsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ReservationDetailsScreen(),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child:
                CommonAppBar(tr("lookupCondition"), true, () {
                  onBackButtonPress(context);
                }, () {}),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 30,
                  bottom: 20.0,
                  left: 20,
                  right: 20,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    Text(
                      "TODAY",
                      style: TextStyle(
                        fontSize: 26,
                        color: CustomColors.textColor1,
                        fontFamily: 'SemiBold',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    // SizedBox(
                    //   child: SvgPicture.asset(
                    //     'assets/images/ic_right_arrow.svg',
                    //     semanticsLabel: 'Back',
                    //     width: 15,
                    //     height: 15,
                    //     alignment: Alignment.center,
                    //   ),
                    // ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: todayList.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return InkWell(
                        onTap: () {
                          // goToLookupCondition();
                          goToReservationDetailsScreen();
                        },
                        child: Container(
                            margin:
                                const EdgeInsets.only(top: 5.0, bottom: 5.0),
                            decoration: BoxDecoration(
                              color: CustomColors.backgroundColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      todayList[index]["name"],
                                      style: const TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Regular",
                                          color: CustomColors.textColor1),
                                    ),
                                    Text(
                                      todayList[index]["status"],
                                      style: const TextStyle(
                                          fontSize: 13,
                                          fontFamily: "Bold",
                                          color: CustomColors
                                              .buttonBackgroundColor),
                                    ),
                                  ],
                                ),
                                Container(
                                    margin: const EdgeInsets.only(top: 6),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              todayList[index]["businessType"] +
                                                  " | ",
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "Regular",
                                                  color:
                                                      CustomColors.textColor1),
                                            ),
                                            Text(
                                              todayList[index]["type"],
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "Regular",
                                                  color:
                                                      CustomColors.textColor1),
                                            ),
                                          ],
                                        ),
                                        Text(
                                          todayList[index]["dateTime"],
                                          style: const TextStyle(
                                              fontSize: 12,
                                              fontFamily: "Regular",
                                              color:
                                                  CustomColors.unSelectedColor),
                                        ),
                                      ],
                                    ))
                              ],
                            )));
                  },
                ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 20, right: 20, top: 30),
                child: Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CommonButtonWithIcon(
                      buttonName: tr("visitReservationApplication"),
                      isEnable: true,
                      buttonColor: CustomColors.buttonBackgroundColor,
                      onCommonButtonTap: () {
                        goToVisitReservationApplicationScreen();
                      },
                    )),
              ),
            ],
          ),
          // ),
        ),
      ),
    );
  }

  void goToVisitReservationApplicationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const VisitReservationApplicationScreen(),
      ),
    );
  }

}
