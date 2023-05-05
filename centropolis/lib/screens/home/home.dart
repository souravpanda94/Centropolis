import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/custom_colors.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  CarouselController controller = CarouselController();
  List<String> imageList = [
    "https://thumbs.dreamstime.com/b/red-flower-jpg-178844159.jpg",
    "https://thumbs.dreamstime.com/b/hd-flower-wallpaper-closeup-jpg-nature-159668373.jpg",
    "https://thumbs.dreamstime.com/b/red-flower-jpg-178844159.jpg",
    "https://thumbs.dreamstime.com/b/hd-flower-wallpaper-closeup-jpg-nature-159668373.jpg",
    "https://thumbs.dreamstime.com/b/yellow-orange-starburst-flower-nature-jpg-192959431.jpg"
  ];

  List<dynamic> dataList = [
    {
      "id": 1,
      "type": "visitorReservation",
      "image": 'assets/images/ic_slider_1.png'
    },
    {
      "id": 2,
      "type": "centropolisExecutive",
      "image": 'assets/images/ic_slider_2.png'
    },
    {"id": 3, "type": "conference", "image": 'assets/images/ic_slider_3.png'},
    {"id": 4, "type": "fitness", "image": 'assets/images/ic_slider_4.png'},
    {"id": 5, "type": "refresh", "image": 'assets/images/ic_slider_5.png'},
    {"id": 6, "type": "voc", "image": 'assets/images/ic_slider_6.png'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CarouselSlider(
        carouselController: controller,
        items: dataList.map((data) {
          // return SizedBox(
          //   width: MediaQuery.of(context).size.width,
          //   child: Image.network(
          //     data.trim().toString(),
          //     fit: BoxFit.fill,
          //     width: MediaQuery.of(context).size.width,
          //     height: MediaQuery.of(context).size.height,
          //   ),
          // );

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
                          SvgPicture.asset(
                            'assets/images/ic_qr_code_white.svg',
                            semanticsLabel: 'Back',
                            width: 25,
                            height: 25,
                            alignment: Alignment.center,
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
                          SvgPicture.asset(
                            'assets/images/ic_notification_white.svg',
                            semanticsLabel: 'Back',
                            width: 25,
                            height: 25,
                            alignment: Alignment.center,
                          ),
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
                    Container(
                        margin:
                            const EdgeInsets.only(left: 16, right: 16, top: 25),
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
                  ],
                ),
                Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      margin: const EdgeInsets.only(
                          left: 16, right: 16, bottom: 30),
                      child: Container(
                          height: 78,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: CustomColors.homeButtonBackgroundColor,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: CustomColors.whiteColor, width: 1.0),
                          ),
                          child: Center(
                            child: Text(
                              tr("makeReservation"),
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Bold",
                                color: CustomColors.whiteColor,
                              ),
                            ),
                          )),
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
      floatingActionButton: yourButtonWidget(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
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
      return tr("visitorReservation");
    } else if (type == "voc") {
      return tr("voc");
    } else {
      return "";
    }
  }

  yourButtonWidget() {}
}
