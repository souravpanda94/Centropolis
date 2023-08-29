import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:loading_overlay/loading_overlay.dart';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../models/user_info_model.dart';
import '../../providers/user_info_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../home/bar_code.dart';
import 'amenity_reservation_history.dart';
import 'personal_information.dart';
import 'web_view_ui.dart';
import 'registered_employee_list.dart';
import 'voc_reservation_history.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  // String userType = "member";
  // String userType = "tenant_admin";
  String userType = "";
  String displayUserType = "";
  String companyName = "";
  String name = "";
  late String apiKey, language;
  late FToast fToast;
  late String email, mobile;
  int page = 1;
  final int limit = 10;
  int totalPages = 0;
  int totalRecords = 0;
  bool isFirstLoadRunning = true;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    //name = user.userData['name'].toString();
    //companyName = user.userData['company_name'].toString();
    userType = user.userData['user_type'].toString();
    //displayUserType = user.userData['display_user_type'].toString();
    language = tr("lang");
    debugPrint("userType  ===> $userType");
    loadPersonalInformation();
    if (userType == "tenant_admin") {
      firstTimeLoadEmployeeList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.whiteColor,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isFirstLoadRunning,
      child: Scaffold(
          backgroundColor: CustomColors.backgroundColor,
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: CustomColors.whiteColor,
                  padding:
                      const EdgeInsets.only(left: 16.0, right: 16.0, top: 16),
                  margin: const EdgeInsets.only(bottom: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: CustomColors.backgroundColor2,
                          borderRadius: BorderRadius.circular(50),
                        ),
                        padding: const EdgeInsets.only(
                            top: 6.0, bottom: 6.0, left: 12.0, right: 12.0),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
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
                              displayUserType,
                              style: const TextStyle(
                                height: 1.5,
                                fontSize: 12,
                                fontFamily: "SemiBold",
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
                              Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: SvgPicture.asset(
                                  'assets/images/ic_right_arrow.svg',
                                  semanticsLabel: 'Back',
                                  width: 12,
                                  height: 12,
                                  alignment: Alignment.center,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
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
                                      tr("lightOutDetailCompany"),
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
                                Padding(
                                  padding: const EdgeInsets.only(left: 25),
                                  child: SvgPicture.asset(
                                    'assets/images/ic_vertical_line.svg',
                                    semanticsLabel: 'Back',
                                    // width: 12,
                                    height: 60,
                                    alignment: Alignment.center,
                                  ),
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
                                          ).then((value) {
                                            if (value) {
                                              firstTimeLoadEmployeeList();
                                            }
                                          });
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
                                                  color:
                                                      CustomColors.greyColor1,
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
                                          Text(
                                            "${totalRecords.toString()}  ",
                                            style: const TextStyle(
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
                                              color:
                                                  CustomColors.textColorBlack2,
                                              fontFamily: 'SemiBold',
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                )
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
                            return WebViewUiScreen(
                                tr("freeParkingVehicleRegistration"),
                                WebViewLinks.freeParkingVehicleRegistrationUrl);
                          });
                    },
                    child: Container(
                      height: 78,
                      width: double.infinity,
                      margin: const EdgeInsets.only(
                          top: 20, left: 16.0, right: 16.0),
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: CustomColors.dividerGreyColor
                                  .withOpacity(0.2),
                              offset: const Offset(0.0, 3.0), //(x,y)
                              blurRadius: 3.0,
                            ),
                          ],
                          color: CustomColors.whiteColor,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              color: CustomColors.backgroundColor2,
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
                              fontFamily: "Medium",
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
                        boxShadow: [
                          BoxShadow(
                            color:
                                CustomColors.dividerGreyColor.withOpacity(0.2),
                            offset: const Offset(0.0, 3.0), //(x,y)
                            blurRadius: 3.0,
                          ),
                        ],
                        color: CustomColors.whiteColor,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: CustomColors.backgroundColor2, width: 1.0)),
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
                                fontFamily: "Medium",
                                color: CustomColors.textColorBlack2,
                              ),
                            ),
                            // const SizedBox(
                            //   width: 5,
                            // ),
                            // const Text(
                            //   "12",
                            //   style: TextStyle(
                            //     fontSize: 14,
                            //     fontFamily: "SemiBold",
                            //     color: CustomColors.textColor9,
                            //   ),
                            // ),
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
                    margin: const EdgeInsets.only(
                        top: 20, left: 16.0, right: 16.0, bottom: 50),
                    decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color:
                                CustomColors.dividerGreyColor.withOpacity(0.2),
                            offset: const Offset(0.0, 3.0), //(x,y)
                            blurRadius: 3.0,
                          ),
                        ],
                        color: CustomColors.whiteColor,
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(
                            color: CustomColors.backgroundColor2, width: 1.0)),
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
                                fontFamily: "Medium",
                                color: CustomColors.textColorBlack2,
                              ),
                            ),
                            // const SizedBox(
                            //   width: 5,
                            // ),
                            // const Text(
                            //   "16",
                            //   style: TextStyle(
                            //     fontSize: 14,
                            //     fontFamily: "SemiBold",
                            //     color: CustomColors.textColor9,
                            //   ),
                            // ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          )),
    );
  }

  void firstTimeLoadEmployeeList() {
    setState(() {
      isFirstLoadRunning = true;
      page = 1;
    });

    loadEmployeeList();
  }

  void loadEmployeeList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callEmployeeListApi();
    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
         showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callEmployeeListApi() {
    Map<String, String> body;

    body = {
      "page": page.toString(),
      "limit": limit.toString(),
    };

    debugPrint("Employee List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.registeredEmployeeListUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Employee List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          totalPages = responseJson['total_pages'];
          totalRecords = responseJson['total_records'];
        } else {
          if (responseJson['message'] != null) {
             debugPrint("Server error response ${responseJson['message']}");
              // showCustomToast(
              //     fToast, context, responseJson['message'].toString(), "");
              showErrorCommonModal(context: context,
                  heading :responseJson['message'].toString(),
                  description: "",
                  buttonName: tr("check"));
          }
        }
        setState(() {
          isFirstLoadRunning = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
       showErrorCommonModal(context: context,
          heading: tr("errorDescription"),
          description:"",
          buttonName : tr("check"));
      if (mounted) {
        setState(() {
          isFirstLoadRunning = false;
        });
      }
    });
  }

  void loadPersonalInformation() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadPersonalInformationApi();
    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
       showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callLoadPersonalInformationApi() {
    setState(() {
      isFirstLoadRunning = true;
    });
    Map<String, String> body = {};

    debugPrint("Get personal info input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getPersonalInfoUrl, body, language, apiKey.trim());
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Get personal info ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          UserInfoModel userInfoModel = UserInfoModel.fromJson(responseJson);
          Provider.of<UserInfoProvider>(context, listen: false)
              .setItem(userInfoModel);

          setState(() {
            displayUserType = userInfoModel.displayUserType.toString();
            companyName = userInfoModel.companyName.toString();
            name = userInfoModel.name.toString();
          });
        } else {
          if (responseJson['message'] != null) {
            debugPrint("Server error response ${responseJson['message']}");
              // showCustomToast(
              //     fToast, context, responseJson['message'].toString(), "");
              showErrorCommonModal(context: context,
                  heading :responseJson['message'].toString(),
                  description: "",
                  buttonName: tr("check"));
          }
        }
      }
      setState(() {
        isFirstLoadRunning = false;
      });
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
       showErrorCommonModal(context: context,
          heading: tr("errorDescription"),
          description:"",
          buttonName : tr("check"));
      setState(() {
        isFirstLoadRunning = false;
      });
    });
  }
}
