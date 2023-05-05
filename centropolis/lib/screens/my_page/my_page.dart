import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../utils/custom_colors.dart';
import 'amenity_reservation_history.dart';
import 'personal_information.dart';
import 'registered_employee_list.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  // String userType = "member";
  String userType = "admin";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  color: CustomColors.whiteColor,
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 150,
                        decoration: BoxDecoration(
                          color: CustomColors.backgroundColor2,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8.0, left: 15.0, right: 15.0),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/ic_logo.svg',
                              semanticsLabel: 'Back',
                              width: 15,
                              height: 15,
                              alignment: Alignment.center,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              userType == "admin"
                                  ? "Conference Room"
                                  : "Member",
                              style: const TextStyle(
                                fontSize: 12,
                                fontFamily: "Bold",
                                color: CustomColors.textColor8,
                              ),
                            ),
                          ],
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PersonalInformationScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 12.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Hong Gil Dong",
                                style: TextStyle(
                                  fontSize: 22,
                                  fontFamily: "SemiBold",
                                  color: CustomColors.textColor8,
                                ),
                              ),
                              SvgPicture.asset(
                                'assets/images/ic_right_arrow.svg',
                                semanticsLabel: 'Back',
                                width: 12,
                                height: 12,
                                alignment: Alignment.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(
                            top: 20.0,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tr("tenantCompany"),
                                      style: const TextStyle(
                                        fontSize: 14,
                                        fontFamily: "Regular",
                                        color: CustomColors.greyColor1,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    const Text(
                                      "CENTROPOLIS",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontFamily: "SemiBold",
                                        color: CustomColors.textColor9,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (userType == "admin")
                                SvgPicture.asset(
                                  'assets/images/ic_vertical_line.svg',
                                  semanticsLabel: 'Back',
                                  // width: 12,
                                  height: 60,
                                  alignment: Alignment.center,
                                ),
                              if (userType == "admin")
                                Flexible(
                                    child: Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RegisteredEmployeeList(),
                                          ),
                                        );
                                      },
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              tr("numberOfRegisteredEmployee"),
                                              style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: "Regular",
                                                color: CustomColors.greyColor1,
                                              ),
                                            ),
                                          ),

                                          // SvgPicture.asset(
                                          //   'assets/images/ic_right_arrow.svg',
                                          //   semanticsLabel: 'Back',
                                          //   width: 8,
                                          //   height: 8,
                                          //   alignment: Alignment.center,
                                          // ),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 5.0,
                                    ),
                                    Row(
                                      children: [
                                        const Text(
                                          "2 ",
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: CustomColors.textColor9,
                                            fontFamily: 'SemiBold',
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          tr("people"),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: CustomColors.textColorBlack2,
                                            fontFamily: 'SemiBold',
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ],
                                ))
                            ],
                          )),
                      Container(
                        margin: const EdgeInsets.only(top: 20.0, bottom: 20),
                        height: 50,
                        decoration: BoxDecoration(
                            color: CustomColors.whiteColor,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                                color: CustomColors.dividerGreyColor,
                                width: 1.0)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/ic_qr_code.svg',
                              semanticsLabel: 'Back',
                              width: 23,
                              height: 23,
                              alignment: Alignment.center,
                            ),
                            const SizedBox(
                              width: 7,
                            ),
                            Text(
                              tr("qrCode"),
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "SemiBold",
                                color: CustomColors.textColorBlack2,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                if (userType == "admin")
                  Container(
                    height: 78,
                    width: double.infinity,
                    margin:
                        const EdgeInsets.only(top: 20, left: 16.0, right: 16.0),
                    decoration: BoxDecoration(
                        color: CustomColors.whiteColor,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: CustomColors.dividerGreyColor, width: 1.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/ic_car.svg',
                          semanticsLabel: 'Back',
                          width: 23,
                          height: 23,
                          alignment: Alignment.center,
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          tr("freeParkingVehicleRegistration"),
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "SemiBold",
                            color: CustomColors.textColorBlack2,
                          ),
                        ),
                      ],
                    ),
                  ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AmenityReservationHistory(),
                      ),
                    );
                  },
                  child: Container(
                    height: 78,
                    width: double.infinity,
                    margin:
                        const EdgeInsets.only(top: 20, left: 16.0, right: 16.0),
                    decoration: BoxDecoration(
                        color: CustomColors.whiteColor,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: CustomColors.dividerGreyColor, width: 1.0)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/ic_document.svg',
                          semanticsLabel: 'Back',
                          width: 23,
                          height: 23,
                          alignment: Alignment.center,
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              tr("amenityReservationHistory"),
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "SemiBold",
                                color: CustomColors.textColorBlack2,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            const Text(
                              "12",
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: "SemiBold",
                                color: CustomColors.textColor9,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  height: 78,
                  width: double.infinity,
                  margin:
                      const EdgeInsets.only(top: 20, left: 16.0, right: 16.0),
                  decoration: BoxDecoration(
                      color: CustomColors.whiteColor,
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(
                          color: CustomColors.dividerGreyColor, width: 1.0)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/images/ic_light_bulb.svg',
                        semanticsLabel: 'Back',
                        width: 23,
                        height: 23,
                        alignment: Alignment.center,
                      ),
                      const SizedBox(
                        height: 7,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            tr("vocApplicationHistory"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "SemiBold",
                              color: CustomColors.textColorBlack2,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          const Text(
                            "16",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: "SemiBold",
                              color: CustomColors.textColor9,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
