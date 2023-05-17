import 'dart:ffi';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:centropolis/screens/amenity/gx_reservation.dart';
import 'package:centropolis/screens/amenity/tenant_service.dart';
import 'package:centropolis/screens/visit_request/visit_reservation_application.dart';
import 'package:centropolis/screens/voc/air_conditioning_application.dart';
import 'package:centropolis/screens/voc/complaints_received.dart';
import 'package:centropolis/screens/voc/light_out_request.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_button_with_border.dart';
import '../amenity/conference_reservation.dart';
import '../amenity/fitness_reservation.dart';
import '../amenity/lounge_reservation.dart';
import '../amenity/sleeping_room_reservation.dart';
import 'bar_code.dart';
import 'notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController controller = CarouselController();
  int pageIndex = 0;
  List<dynamic> dataList = [
    {
      "id": 0,
      "type": "visitorReservation",
      "image": 'assets/images/ic_slider_1.png'
    },
    {
      "id": 1,
      "type": "centropolisExecutive",
      "image": 'assets/images/ic_slider_2.png'
    },
    {"id": 2, "type": "conference", "image": 'assets/images/ic_slider_3.png'},
    {"id": 3, "type": "fitness", "image": 'assets/images/ic_slider_4.png'},
    {"id": 4, "type": "refresh", "image": 'assets/images/ic_slider_5.png'},
    {"id": 5, "type": "voc", "image": 'assets/images/ic_slider_6.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CarouselSlider(
        carouselController: controller,
        items: dataList.map((data) {
          setState(() {
            pageIndex = data["id"];
          });
          return Container(
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  data['image'].trim().toString(),
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Stack(
              children: [
                Column(
                  children: [
                    Container(
                      margin:
                          const EdgeInsets.only(left: 16, right: 16, top: 50),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              goToQrCodeScreen();
                            },
                            icon: SvgPicture.asset(
                              'assets/images/ic_qr_code_white.svg',
                              semanticsLabel: 'Back',
                              width: 25,
                              height: 25,
                              alignment: Alignment.center,
                            ),
                          ),
                          Expanded(
                            child: SvgPicture.asset(
                              'assets/images/ic_logo_for_home.svg',
                              semanticsLabel: 'Back',
                              // width: 12,
                              // height: 12,
                              alignment: Alignment.center,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              goToNotificationScreen();
                            },
                            icon: SvgPicture.asset(
                              'assets/images/ic_notification_white.svg',
                              semanticsLabel: 'Back',
                              width: 25,
                              height: 25,
                              alignment: Alignment.center,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 16, right: 16, top: 30),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          setTitle(data["type"]),
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "SemiBold",
                            color: CustomColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin:
                          const EdgeInsets.only(left: 16, right: 16, top: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          setHeading(data["type"]),
                          style: const TextStyle(
                            fontSize: 22,
                            fontFamily: "SemiBold",
                            color: CustomColors.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        if (data["type"] == "visitorReservation") {
                          goToVisitReservationHomeScreen();
                        } else if (data["type"] == "voc") {
                          goToVOCHomeScreen();
                        } else if (data["type"] == "centropolisExecutive") {
                          goToLoungeHomeScreen();
                        } else if (data["type"] == "conference") {
                        } else if (data["type"] == "refresh") {
                        } else if (data["type"] == "fitness") {}
                      },
                      child: Container(
                          margin: const EdgeInsets.only(
                              left: 16, right: 16, top: 25),
                          child: Row(
                            children: [
                              Text(
                                tr("viewMore"),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: "Regular",
                                  color: CustomColors.whiteColor,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              SvgPicture.asset(
                                'assets/images/ic_right_arrow_white.svg',
                                semanticsLabel: 'Back',
                                width: 8,
                                height: 8,
                                alignment: Alignment.center,
                              ),
                            ],
                          )),
                    ),
                  ],
                ),
                if (data["type"] == "visitorReservation" ||
                    data["type"] == "centropolisExecutive" ||
                    data["type"] == "conference" ||
                    data["type"] == "refresh")
                  Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        margin: const EdgeInsets.only(
                            left: 16, right: 16, bottom: 65),
                        child: SizedBox(
                          height: 78,
                          child: CommonButtonWithBorder(
                            onCommonButtonTap: () {
                              if (data["type"] == "conference") {
                                goToConferenceReservationScreen();
                              } else if (data["type"] ==
                                  "centropolisExecutive") {
                                goToLoungeReservationScreen();
                              } else if (data["type"] == "refresh") {
                                goToSleepingRoomReservationScreen();
                              } else if (data["type"] == "visitorReservation") {
                                goToVisitorReservationScreen();
                              }
                            },
                            buttonName: tr("makeReservation"),
                            buttonColor: CustomColors.homeButtonBackgroundColor,
                            buttonBorderColor: CustomColors.whiteColor,
                            buttonTextColor: CustomColors.whiteColor,
                          ),
                        ),
                      )),
                if (data["type"] == "fitness")
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 65),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 78,
                            child: CommonButtonWithBorder(
                              onCommonButtonTap: () {
                                goToGXReservationScreen();
                              },
                              buttonName: tr("gxReservation"),
                              buttonColor:
                                  CustomColors.homeButtonBackgroundColor,
                              buttonBorderColor: CustomColors.whiteColor,
                              buttonTextColor: CustomColors.whiteColor,
                            ),
                          ),
                          Container(
                            height: 78,
                            margin: const EdgeInsets.only(top: 15.0),
                            child: CommonButtonWithBorder(
                              onCommonButtonTap: () {
                                goToPaidPTReservationScreen();
                              },
                              buttonName: tr("paidPtReservation"),
                              buttonColor:
                                  CustomColors.homeButtonBackgroundColor,
                              buttonBorderColor: CustomColors.whiteColor,
                              buttonTextColor: CustomColors.whiteColor,
                            ),
                          ),
                          Container(
                            height: 78,
                            margin: const EdgeInsets.only(top: 15.0),
                            child: CommonButtonWithBorder(
                              onCommonButtonTap: () {
                                goToFitnessReservationScreen();
                              },
                              buttonName: tr("fitnessReservation"),
                              buttonColor:
                                  CustomColors.homeButtonBackgroundColor,
                              buttonBorderColor: CustomColors.whiteColor,
                              buttonTextColor: CustomColors.whiteColor,
                            ),
                          ),
                          Container(
                            height: 78,
                            margin: const EdgeInsets.only(top: 15.0),
                            child: CommonButtonWithBorder(
                              onCommonButtonTap: () {
                                goToPaidLockerReservationScreen();
                              },
                              buttonName: tr("paidLockersReservation"),
                              buttonColor:
                                  CustomColors.homeButtonBackgroundColor,
                              buttonBorderColor: CustomColors.whiteColor,
                              buttonTextColor: CustomColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                if (data["type"] == "voc")
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      // color: Colors.purple,
                      margin: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 65),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            height: 78,
                            child: CommonButtonWithBorder(
                              onCommonButtonTap: () {
                                goToCustomerComplaintsScreen();
                              },
                              buttonName: tr("customerComplaints"),
                              buttonColor:
                                  CustomColors.homeButtonBackgroundColor,
                              buttonBorderColor: CustomColors.whiteColor,
                              buttonTextColor: CustomColors.whiteColor,
                            ),
                          ),
                          Container(
                            height: 78,
                            margin: const EdgeInsets.only(top: 15.0),
                            child: CommonButtonWithBorder(
                              onCommonButtonTap: () {
                                goToLightOutRequestScreen();
                              },
                              buttonName: tr("requestForLightsOut"),
                              buttonColor:
                                  CustomColors.homeButtonBackgroundColor,
                              buttonBorderColor: CustomColors.whiteColor,
                              buttonTextColor: CustomColors.whiteColor,
                            ),
                          ),
                          Container(
                            height: 78,
                            margin: const EdgeInsets.only(top: 15.0),
                            child: CommonButtonWithBorder(
                              onCommonButtonTap: () {
                                goToAirConditiongRequestScreen();
                              },
                              buttonName: tr("requestForHeatingAndCooling"),
                              buttonColor:
                                  CustomColors.homeButtonBackgroundColor,
                              buttonBorderColor: CustomColors.whiteColor,
                              buttonTextColor: CustomColors.whiteColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 25.0),
                      child: DotsIndicator(
                        dotsCount: dataList.length,
                        position: pageIndex.toDouble(),
                        decorator: const DotsDecorator(
                          shape: Border(
                              top: BorderSide(
                                  color: CustomColors.whiteColor, width: 1.0),
                              bottom: BorderSide(
                                  color: CustomColors.whiteColor, width: 1.0),
                              left: BorderSide(
                                  color: CustomColors.whiteColor, width: 1.0),
                              right: BorderSide(
                                  color: CustomColors.whiteColor, width: 1.0)),
                          spacing: EdgeInsets.all(4),
                          color: Colors.transparent, // Inactive color
                          activeColor: Colors.white,
                        ),
                      ),
                    )),
              ],
            ),
          );
        }).toList(),
        options: CarouselOptions(
            height: MediaQuery.of(context).size.height,
            viewportFraction: 1,
            onPageChanged: (val, _) {
              setState(() {
                debugPrint("new index $val");
                controller.jumpToPage(val);
              });
            }),
      ),
    );
  }

  String setTitle(type) {
    if (type == "visitorReservation") {
      return tr("visitor");
    } else if (type == "centropolisExecutive") {
      return "Centropolis Executive Lounge By HAEVICHI";
    } else if (type == "conference") {
      return tr("conference");
    } else if (type == "fitness") {
      return tr("fitness");
    } else if (type == "refresh") {
      return tr("sleepingRoom");
    } else if (type == "voc") {
      return tr("facilityManagement");
    } else {
      return "";
    }
  }

  String setHeading(type) {
    if (type == "visitorReservation") {
      return tr("visitor");
    } else if (type == "centropolisExecutive") {
      return tr("centropolisExecutive");
    } else if (type == "conference") {
      return tr("conference");
    } else if (type == "fitness") {
      return tr("fitness");
    } else if (type == "refresh") {
      return tr("refresh");
    } else if (type == "voc") {
      return tr("voc");
    } else {
      return "";
    }
  }

  void goToQrCodeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BarCodeScreen(),
      ),
    );
  }

  void goToNotificationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const NotificationScreen(),
      ),
    );
  }

  void goToGXReservationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FitnessReservation(position: 0),
      ),
    );
  }

  void goToPaidPTReservationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FitnessReservation(position: 1),
      ),
    );
  }

  void goToFitnessReservationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FitnessReservation(position: 2),
      ),
    );
  }

  void goToPaidLockerReservationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const FitnessReservation(position: 3),
      ),
    );
  }

  void goToConferenceReservationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ConferenceReservation(),
      ),
    );
  }

  void goToLoungeReservationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoungeReservation(),
      ),
    );
  }

  void goToSleepingRoomReservationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const SleepingRoomReservation(),
      ),
    );
  }

  void goToVisitorReservationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const VisitReservationApplication(),
      ),
    );
  }

  void goToCustomerComplaintsScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ComplaintsReceived(),
      ),
    );
  }

  void goToLightOutRequestScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LightOutRequest(),
      ),
    );
  }

  void goToAirConditiongRequestScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const AirConditioningApplication(),
      ),
    );
  }

  void goToVisitReservationHomeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigationScreen(2),
      ),
    );
  }

  void goToVOCHomeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigationScreen(3),
      ),
    );
  }

  void goToLoungeHomeScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigationScreen(1),
      ),
    );
  }
}
