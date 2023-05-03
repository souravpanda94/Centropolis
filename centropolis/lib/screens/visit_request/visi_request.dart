import 'package:centropolis/screens/visit_request/visit_reservations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../../utils/custom_colors.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_button_with_icon.dart';
import '../../widgets/common_modal.dart';
import '../unused_code/visitor_reservations/VisitReservationViewAll.dart';

class VisitRequestScreen extends StatefulWidget {
  const VisitRequestScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VisitRequestScreenState();
  }
}

class _VisitRequestScreenState extends State<VisitRequestScreen> {
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

  @override
  Widget build(BuildContext context) {
    // todayList = [];
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: SingleChildScrollView(
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(
                  top: 15.0,
                  bottom: 20.0,
                  left: 16.0,
                  right: 16.0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      tr("today"),
                      style: const TextStyle(
                        fontSize: 22,
                        color: CustomColors.textColorBlack2,
                        fontFamily: 'SemiBold',
                      ),
                      textAlign: TextAlign.center,
                    ),
                    InkWell(
                      onTap: () {
                        goToViewAllVisitorReservation();
                      },
                      child: SizedBox(
                        child: SvgPicture.asset(
                          'assets/images/ic_drawer.svg',
                          semanticsLabel: 'Back',
                          width: 25,
                          height: 25,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              todayList.isNotEmpty
                  ? Container(
                      margin: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: todayList.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return InkWell(
                              onTap: () {
                                goToReservationDetailsScreen();
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 5.0, bottom: 5.0),
                                  decoration: BoxDecoration(
                                    color: CustomColors.whiteColor,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: CustomColors.borderColor,
                                        width: 1.0),
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
                                                fontSize: 14,
                                                fontFamily: "Bold",
                                                color: CustomColors.textColor8),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color:
                                                  CustomColors.backgroundColor,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            padding: const EdgeInsets.only(
                                                top: 5,
                                                bottom: 5,
                                                left: 10,
                                                right: 10),
                                            child: Text(
                                              todayList[index]["status"],
                                              style: const TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "Bold",
                                                  color: CustomColors
                                                      .textColorBlack2),
                                            ),
                                          )
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
                                                    todayList[index]
                                                        ["businessType"],
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "Regular",
                                                        color: CustomColors
                                                            .textColorBlack2),
                                                  ),
                                                  const Text(
                                                    "  |  ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "Regular",
                                                        color: CustomColors
                                                            .borderColor),
                                                  ),
                                                  Text(
                                                    todayList[index]["type"],
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "Regular",
                                                        color: CustomColors
                                                            .textColorBlack2),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                      Container(
                                          margin: const EdgeInsets.only(top: 6),
                                          child: Row(
                                            children: [
                                              Text(
                                                tr("visitDate"),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: "Regular",
                                                    color: CustomColors
                                                        .textColor3),
                                              ),
                                              Text(
                                                todayList[index]["dateTime"],
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: "Regular",
                                                    color: CustomColors
                                                        .textColor3),
                                              ),
                                            ],
                                          )),
                                    ],
                                  )));
                        },
                      ))
                  : Container(
                      decoration: BoxDecoration(
                        color: CustomColors.backgroundColor,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      margin: const EdgeInsets.only(
                        top: 20,
                        left: 16,
                        right: 16,
                      ),
                      padding: const EdgeInsets.only(
                          top: 25, bottom: 25, left: 35, right: 35),
                      child: Text(
                        tr("thereAreNoScheduledVisitorReservations"),
                        style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "Regular",
                            color: CustomColors.textColor5),
                      ),
                    )
            ],
          ),
          // ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        height: 46,
        margin: const EdgeInsets.only(left: 16, right: 16, top: 30),
        child: CommonButtonWithIcon(
          buttonName: tr("visitReservationApplication"),
          isEnable: true,
          buttonColor: CustomColors.buttonBackgroundColor,
          onCommonButtonTap: () {
            goToVisitReservationApplicationScreen();
          },
        ),
      ),
    );
  }

  void goToViewAllVisitorReservation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const VisitReservationsScreen(),
      ),
    );
  }

  void goToVisitReservationApplicationScreen() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const VisitReservationApplicationScreen(),
    //   ),
    // );
  }

  void goToReservationDetailsScreen() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const ReservationDetailsScreen(),
    //   ),
    // );
  }
}
