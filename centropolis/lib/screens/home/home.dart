import 'dart:convert';
import 'dart:io';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:centropolis/screens/visit_request/visit_reservation_application.dart';
import 'package:centropolis/screens/voc/air_conditioning_application.dart';
import 'package:centropolis/screens/voc/complaints_received.dart';
import 'package:centropolis/screens/voc/light_out_request.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import '../../models/user_info_model.dart';
import '../../providers/user_info_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../services/notification_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/common_button_with_border.dart';
import '../../widgets/common_modal.dart';
import '../amenity/conference_reservation.dart';
import '../amenity/fitness_reservation.dart';
import '../amenity/lounge_reservation.dart';
import '../amenity/sleeping_room_reservation.dart';
import 'package:http/http.dart' as http;
import 'bar_code.dart';
import 'app_update.dart';
import 'notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late String apiKey, language;
  late FToast fToast;
  bool isLoading = false;
  UserInfoModel? userInfoModel;
  CarouselController controller = CarouselController();
  int pageIndex = 0;
  int unreadNotificationCount = 0;
  // List<dynamic> dataList = [
  //   {
  //     "id": 0,
  //     "type": "visitorReservation",
  //     "image": 'assets/images/ic_slider_1.png'
  //   },
  //   {
  //     "id": 1,
  //     "type": "centropolisExecutive",
  //     "image": 'assets/images/ic_slider_2.png'
  //   },
  //   {"id": 2, "type": "conference", "image": 'assets/images/ic_slider_3.png'},
  //   {"id": 3, "type": "fitness", "image": 'assets/images/ic_slider_4.png'},
  //   {"id": 4, "type": "refresh", "image": 'assets/images/ic_slider_5.png'},
  //   {"id": 5, "type": "voc", "image": 'assets/images/ic_slider_6.png'},
  // ];
  List<dynamic> dataList = [
    {
      "id": 0,
      "type": "visitorReservation",
      "image": 'assets/images/ic_slider_1.png'
    },
    {"id": 1, "type": "fitness", "image": 'assets/images/ic_slider_4.png'},
    {"id": 2, "type": "refresh", "image": 'assets/images/ic_slider_5.png'},
    {"id": 3, "type": "conference", "image": 'assets/images/ic_slider_3.png'},
    {
      "id": 4,
      "type": "centropolisExecutive",
      "image": 'assets/images/ic_slider_2.png'
    },
    {"id": 5, "type": "voc", "image": 'assets/images/ic_slider_6.png'},
  ];
  String deviceType = '';
  String deviceId = '';
  String fcmToken = '';
  String appVersion = "";
  String accountType = "";





  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    getDeviceIdAndDeviceType();
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    debugPrint("apiKey :: $apiKey");
    // setFirebase();
    getAppVersion();
    internetCheckingForMethods();
  }

  

  @override
  Widget build(BuildContext context) {
    userInfoModel = Provider.of<UserInfoProvider>(context).getUserInformation;

    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.textColor3,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isLoading,
      child: Scaffold(
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
                color: CustomColors.blackColor,
                image: DecorationImage(
                  opacity: 0.7,
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
                            EdgeInsets.only(top: Platform.isAndroid ? 35 : 0),
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
                              icon: unreadNotificationCount > 0
                                  ? SvgPicture.asset(
                                      'assets/images/ic_notification_white.svg',
                                      semanticsLabel: 'Back',
                                      width: 25,
                                      height: 25,
                                      alignment: Alignment.center,
                                    )
                                  : SvgPicture.asset(
                                      'assets/images/ic_notification.svg',
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
                              fontFamily: "Medium",
                              color: CustomColors.whiteColor,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin:
                            const EdgeInsets.only(left: 16, right: 16, top: 8),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            setHeading(data["type"]),
                            style: const TextStyle(
                              fontSize: 24,
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
                            goToConferenceHomeScreen();
                          } else if (data["type"] == "refresh") {
                            goToFacilityHomeScreen();
                          } else if (data["type"] == "fitness") {
                            goToFitnessHomeScreen();
                          }
                        },
                        child: Container(
                            margin: const EdgeInsets.only(
                                left: 16, right: 16, top: 15),
                            child: Row(
                              children: [
                                Text(
                                  tr("viewMoreHomePage"),
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
                                  width: 12,
                                  height: 12,
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
                              left: 16, right: 16, bottom: 50),
                          child: SizedBox(
                            height: Platform.isAndroid ? 78 : 79,
                            child: CommonButtonWithBorder(
                              onCommonButtonTap: () {
                                if (data["type"] == "conference") {
                                  goToConferenceReservationScreen();
                                } else if (data["type"] ==
                                    "centropolisExecutive") {
                                  goToLoungeReservationScreen();
                                } else if (data["type"] == "refresh") {
                                  goToSleepingRoomReservationScreen();
                                } else if (data["type"] ==
                                    "visitorReservation") {
                                  goToVisitorReservationScreen();
                                }
                              },
                              buttonName: tr("makeReservation"),
                              buttonColor:
                                  CustomColors.whiteColor.withOpacity(0.2),
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
                            left: 16, right: 16, bottom: 50),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              height: Platform.isAndroid ? 78 : 79,
                              child: CommonButtonWithBorder(
                                onCommonButtonTap: () {
                                  goToFitnessReservationScreen();
                                },
                                buttonName: tr("fitnessReservation"),
                                buttonColor:
                                    CustomColors.whiteColor.withOpacity(0.2),
                                buttonBorderColor: CustomColors.whiteColor,
                                buttonTextColor: CustomColors.whiteColor,
                              ),
                            ),
                            Container(
                              height: Platform.isAndroid ? 78 : 79,
                              margin: EdgeInsets.only(
                                  top: Platform.isAndroid ? 15.0 : 10.0),
                              child: CommonButtonWithBorder(
                                onCommonButtonTap: () {
                                  goToGXReservationScreen();
                                },
                                buttonName: tr("gxReservation"),
                                buttonColor:
                                    CustomColors.whiteColor.withOpacity(0.2),
                                buttonBorderColor: CustomColors.whiteColor,
                                buttonTextColor: CustomColors.whiteColor,
                              ),
                            ),
                            Container(
                              height: Platform.isAndroid ? 78 : 79,
                              margin: EdgeInsets.only(
                                  top: Platform.isAndroid ? 15.0 : 10.0),
                              child: CommonButtonWithBorder(
                                onCommonButtonTap: () {
                                  goToPaidPTReservationScreen();
                                },
                                buttonName: tr("paidPtReservation"),
                                buttonColor:
                                    CustomColors.whiteColor.withOpacity(0.2),
                                buttonBorderColor: CustomColors.whiteColor,
                                buttonTextColor: CustomColors.whiteColor,
                              ),
                            ),
                            Container(
                              height: Platform.isAndroid ? 78 : 79,
                              margin: EdgeInsets.only(
                                  top: Platform.isAndroid ? 15.0 : 10.0),
                              child: CommonButtonWithBorder(
                                onCommonButtonTap: () {
                                  goToPaidLockerReservationScreen();
                                },
                                buttonName: tr("paidLockersReservationHome"),
                                buttonColor:
                                    CustomColors.whiteColor.withOpacity(0.2),
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
                            left: 16, right: 16, bottom: 50),
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
                                    CustomColors.whiteColor.withOpacity(0.2),
                                buttonBorderColor: CustomColors.whiteColor,
                                buttonTextColor: CustomColors.whiteColor,
                              ),
                            ),
                            Container(
                              height: 78,
                              margin: EdgeInsets.only(
                                  top: Platform.isAndroid ? 15.0 : 10.0),
                              child: CommonButtonWithBorder(
                                onCommonButtonTap: () {
                                  goToLightOutRequestScreen();
                                },
                                buttonName: tr("lightOutDetail"),
                                buttonColor:
                                    CustomColors.whiteColor.withOpacity(0.2),
                                buttonBorderColor: CustomColors.whiteColor,
                                buttonTextColor: CustomColors.whiteColor,
                              ),
                            ),
                            Container(
                              height: 78,
                              margin: EdgeInsets.only(
                                  top: Platform.isAndroid ? 15.0 : 10.0),
                              child: CommonButtonWithBorder(
                                onCommonButtonTap: () {
                                  goToAirConditiongRequestScreen();
                                },
                                buttonName: tr("requestForHeatingAndCooling"),
                                buttonColor:
                                    CustomColors.whiteColor.withOpacity(0.2),
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
                          decorator: DotsDecorator(
                            size: const Size(7, 7),
                            activeSize: const Size(7, 7),
                            shapes: [
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: const BorderSide(
                                      color: CustomColors.whiteColor,
                                      width: 1.0)),
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: const BorderSide(
                                      color: CustomColors.whiteColor,
                                      width: 1.0)),
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: const BorderSide(
                                      color: CustomColors.whiteColor,
                                      width: 1.0)),
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: const BorderSide(
                                      color: CustomColors.whiteColor,
                                      width: 1.0)),
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: const BorderSide(
                                      color: CustomColors.whiteColor,
                                      width: 1.0)),
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                  side: const BorderSide(
                                      color: CustomColors.whiteColor,
                                      width: 1.0)),
                            ],
                            spacing: const EdgeInsets.all(4),
                            color: Colors.transparent,
                            // Inactive color
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
      ),
    );
  }

  String setTitle(type) {
    if (type == "visitorReservation") {
      return tr("visitor");
    } else if (type == "centropolisExecutive") {
      return tr("centropolisExecutiveLounge");
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
      return tr("visitReservationHomeHeading");
    } else if (type == "centropolisExecutive") {
      return tr("loungeHomeHeading");
    } else if (type == "conference") {
      return tr("conferenceHomeHeading");
    } else if (type == "fitness") {
      return tr("fitnessHomeHeading");
    } else if (type == "refresh") {
      return tr("refreshHomeHeading");
    } else if (type == "voc") {
      return tr("vocHomeHeading");
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
        // builder: (context) => const BarCodeScannerScreen(),
        // builder: (context) => const QrScannerScreen(),
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
    if (accountType == "tenant_manager" || accountType == "tenant_conference_employee") {
                            Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ConferenceReservation(),
      ),
    );

      }else {
           showErrorModal(tr("accessDenied"));
        }

    
  }

  void goToLoungeReservationScreen() {

    if (accountType == "tenant_manager" || accountType == "tenant_lounge_employee") {
                            Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LoungeReservation(),
      ),
    );
       }else {
           showErrorModal(tr("accessDenied"));
        }
    
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
        builder: (context) => const ComplaintsReceived(parentInquirId: ""),
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
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigationScreen(2, 0),
      ),
    );
  }

  void goToVOCHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigationScreen(3, 0),
      ),
    );
  }

  void goToLoungeHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigationScreen(1, 0),
      ),
    );
  }

  void goToConferenceHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigationScreen(1, 1),
      ),
    );
  }

  void goToFitnessHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigationScreen(1, 2),
      ),
    );
  }

  void goToFacilityHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigationScreen(1, 3),
      ),
    );
  }

  

  void callLoadPersonalInformationApi() {
    setState(() {
      isLoading = true;
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
            unreadNotificationCount = userInfoModel.unreadNotificationCount!;
            accountType = userInfoModel.accountType.toString();

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
      setDeviceInformation();
      setState(() {
        isLoading = false;
      });
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(context: context,
          heading: tr("errorDescription"),
          description:"",
          buttonName : tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  

  void callLoadFetchAppUpdateDetailsApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};
    debugPrint("user appVersion  ==> $appVersion");

    debugPrint("FetchAppUpdateDetail input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.appUpdateUrl, body, language, apiKey.trim());
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for FetchAppUpdateDetail ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          int userAppVersion = getExtendedVersionNumber(appVersion);
          int minAppVersion = getExtendedVersionNumber(Platform.isAndroid
              ? responseJson["minimum_android_version"]
              : responseJson["minimum_ios_version"]);
          int latestAppVersion = getExtendedVersionNumber(Platform.isAndroid
              ? responseJson["latest_android_version"]
              : responseJson["latest_ios_version"]);

          if (userAppVersion < minAppVersion) {
            //Force update
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => AppUpdateScreen(
                    forceUpdateFlag: true,
                    latestVersion: Platform.isAndroid
                        ? responseJson["latest_android_version"]
                        : responseJson["latest_ios_version"]),
              ),
            );
          } else if (userAppVersion >= minAppVersion &&
              userAppVersion < latestAppVersion) {
            //Normal update
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AppUpdateScreen(
                    forceUpdateFlag: false,
                    latestVersion: Platform.isAndroid
                        ? responseJson["latest_android_version"]
                        : responseJson["latest_ios_version"]),
              ),
            );
          }
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
        isLoading = false;
      });
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(context: context,
          heading: tr("errorDescription"),
          description:"",
          buttonName : tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String version = packageInfo.version;
    setState(() {
      appVersion = version;
    });
  }

//-----------------------------For Push Notification----------------------------
  void setFirebase() {
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();

    firebaseMessaging.fcmTokenCtlr.stream.listen((event) {
      setState(() {
        fcmToken = event.toString();
      });
      debugPrint("FCM Token: $fcmToken");
    });
  }

  void getDeviceIdAndDeviceType() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceId =
          iosDeviceInfo.identifierForVendor.toString(); // unique ID on iOS
      deviceType = "ios";
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      // deviceId = androidDeviceInfo.androidId.toString();// unique ID on Android
      deviceId = androidDeviceInfo.id.toString(); // unique ID on Android
      deviceType = "android";
    }
    setFirebase();
  }

  void setDeviceInformation() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callSetDeviceInformationApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callSetDeviceInformationApi() {
    Map<String, String> body = {
      "device_id": deviceId.trim(),
      "device_type": deviceType.trim(),
      "device_token": fcmToken.trim(),
    };
    debugPrint("input for Set Device Information ===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.setDeviceInformationUrl, body, language, apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);
      debugPrint(
          "server response for Set Device Information ===> $responseJson");
      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['message'] != null) {
            debugPrint(responseJson['message'].toString());
          }
        } else {
          if (responseJson['message'] != null) {
            debugPrint(responseJson['message'].toString());
          }
        }
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
    });
  }

  void showErrorModal(String message) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: message,
            description: "",
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }

  void internetCheckingForMethods() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadPersonalInformationApi();
    callLoadFetchAppUpdateDetailsApi();

    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
       showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }
}
