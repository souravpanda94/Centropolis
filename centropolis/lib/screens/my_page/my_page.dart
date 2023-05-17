import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../home/bar_code.dart';
import 'amenity_reservation_history.dart';
import 'personal_information.dart';
import 'privacy_policy_and_terms_of_use.dart';
import 'registered_employee_list.dart';
import 'voc_reservation_history.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  // String userType = "member";
  String userType = "tenant_admin";
  // String userType = "";
  late String apiKey,language, name, companyName;
  late FToast fToast;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    name = user.userData['name'].toString();
    companyName = user.userData['company_name'].toString();
    userType = user.userData['user_type'].toString();
    language = tr("lang");
    debugPrint("userType  ===> $userType");
  }

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
                              userType == "tenant_admin"
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
                               Text(
                                name,
                                style: const TextStyle(
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
                                     Text(
                                      // "CENTROPOLIS",
                                       companyName,
                                       overflow: TextOverflow.ellipsis,
                                       maxLines: 1,
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontFamily: "SemiBold",
                                        color: CustomColors.textColor9,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (userType == "tenant_admin")
                                SvgPicture.asset(
                                  'assets/images/ic_vertical_line.svg',
                                  semanticsLabel: 'Back',
                                  // width: 12,
                                  height: 60,
                                  alignment: Alignment.center,
                                ),
                              if (userType == "tenant_admin")
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
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const BarCodeScreen(),
                            ),
                          );
                        },
                        child: Container(
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
                        ),
                      )
                    ],
                  ),
                ),
                if (userType == "tenant_admin")
                  InkWell(
                    onTap: () {
                      showGeneralDialog(
                          context: context,
                          barrierColor: Colors.black12.withOpacity(0.6),
                          // Background color
                          barrierDismissible: false,
                          barrierLabel: 'Dialog',
                          transitionDuration: const Duration(milliseconds: 400),
                          pageBuilder: (_, __, ___) {
                            return PrivacyPolicyAndTermsOfUseScreen(
                                tr("freeParkingVehicleRegistration"),
                                WebViewLinks.termsOfUseUrl);
                          });
                    },
                    child: Container(
                      height: 78,
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          top: 20, left: 16.0, right: 16.0),
                      decoration: BoxDecoration(
                          color: CustomColors.whiteColor,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: CustomColors.dividerGreyColor,
                              width: 1.0)),
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
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const VOCReservationHistory(),
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
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
