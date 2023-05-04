import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '../../providers/user_provider.dart';
import '../../utils/constants.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_modal.dart';

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppSettingsScreenState();
  }
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  late String apiKey, userId, deviceId, language, apartmentId;
  late FToast fToast;
  String appVersion = "";
  bool isSwitched = false;
  String isPushAllow = "n";
  var textValue = 'Switch is OFF';
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    userId = user.userData['user_id'].toString();
    apiKey = user.userData['api_key'].toString();
    deviceId = user.userData['device_id'].toString();
    apartmentId = user.userData['apartment_id'].toString();
    isPushAllow = user.userData['push_notification'].toString();
    user.addListener(() {
      isPushAllow = user.userData['push_notification'].toString();
    });

    setSwitchButtonsValue();
    getAppVersion();
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        isPushAllow = "y";
        textValue = 'Switch Button is ON';
      });
    } else {
      setState(() {
        isSwitched = false;
        isPushAllow = "n";
        textValue = 'Switch Button is OFF';
      });
    }
    // setPushNotification();
  }

  void setSwitchButtonsValue() {
    if (isPushAllow == "y") {
      setState(() {
        isSwitched = true;
      });
    } else {
      setState(() {
        isSwitched = false;
      });
    }
  }

  void getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    String appName = packageInfo.appName;
    String packageName = packageInfo.packageName;
    String version = packageInfo.version;
    String buildNumber = packageInfo.buildNumber;

    setState(() {
      appVersion = version;
    });
    debugPrint("appVersion  ==> $appVersion");
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.textColor3,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isLoading,
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              color: CustomColors.whiteColor,
              child: CommonAppBar(tr("appSettings"), false, () {
                onBackButtonPress(context);
              }, () {}),
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.only(top: 15.0, bottom: 15.0,left: 16.0, right: 16.0,),
                color: CustomColors.whiteColor,
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tr("pushNotification"),
                            style: const TextStyle(
                              fontSize: 16,
                              color: CustomColors.blackColor,
                              fontFamily: 'SemiBold',
                            ),
                            textAlign: TextAlign.left,
                          ),
                          FlutterSwitch(
                            height: 28.0,
                            width: 45.0,
                            padding: 2.0,
                            toggleSize: 24.0,
                            borderRadius: 15.0,
                            activeColor: CustomColors.textColor9,
                            inactiveColor: CustomColors.dividerGreyColor,
                            activeToggleColor: CustomColors.whiteColor,
                            value: isSwitched,
                            onToggle: toggleSwitch,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 6.0),
                      padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            tr("changeLanguage"),
                            style: const TextStyle(
                              fontSize: 16,
                              color: CustomColors.blackColor,
                              fontFamily: 'SemiBold',
                            ),
                            textAlign: TextAlign.left,
                          ),
                          const Text(
                            "ENG",
                            style: TextStyle(
                              fontSize: 14,
                              color: CustomColors.textColor9,
                              fontFamily: 'SemiBold',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),



              Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                  color: CustomColors.whiteColor,
                  child: Column(children: [
                    InkWell(
                      onTap: () {
                        showPrivacyPolicyAndTermsServiceFullDialog(
                            tr("privacyPolicy"), WebViewLinks.privacyPolicyUrl);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 25.0, bottom: 15.0,),
                        // color: Colors.purple,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            tr("privacyPolicy"),
                            style: const TextStyle(
                              fontSize: 16,
                              color: CustomColors.blackColor,
                              fontFamily: 'SemiBold',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () {
                        showPrivacyPolicyAndTermsServiceFullDialog(
                            tr("termsOfUse"), WebViewLinks.termsOfUseUrl);
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 25.0,),
                        // color: Colors.yellow,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            tr("termsOfUse"),
                            style: const TextStyle(
                              fontSize: 16,
                              color: CustomColors.blackColor,
                              fontFamily: 'SemiBold',
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                  ])),


              Container(
                margin: const EdgeInsets.only(top: 10.0,),
                padding: const EdgeInsets.only(top: 25.0, bottom: 25.0,left: 16.0, right: 16.0),
                color: CustomColors.whiteColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr("versionInformation"),
                      style: const TextStyle(
                        fontSize: 16,
                        color: CustomColors.blackColor,
                        fontFamily: 'SemiBold',
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      appVersion,
                      style: const TextStyle(
                        fontSize: 16,
                        color: CustomColors.textColor4,
                        fontFamily: 'Regular',
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),

              // const SizedBox(
              //   height: 30,
              //   child: Divider(
              //     color: CustomColors.borderColor,
              //     height: 1.0,
              //   ),
              // ),
              // InkWell(
              //   onTap: () {
              //     callLogout();
              //   },
              //   child: Container(
              //     margin: const EdgeInsets.only(left: 15.0, right: 15.0),
              //     padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
              //     child: Align(
              //       alignment: Alignment.centerLeft,
              //       child: Text(
              //         tr("logOut"),
              //         style: const TextStyle(
              //           fontSize: 16,
              //           color: CustomColors.blackColor,
              //           fontFamily: 'SemiBold',
              //         ),
              //         textAlign: TextAlign.left,
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 30,
              //   child: Divider(
              //     color: CustomColors.borderColor,
              //     height: 1.0,
              //   ),
              // ),
              // InkWell(
              //   onTap: () {
              //     showWithdrawalModal();
              //   },
              //   child: Container(
              //     margin: const EdgeInsets.only(left: 15.0, right: 15.0),
              //     padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
              //     child: Align(
              //       alignment: Alignment.centerLeft,
              //       child: Text(
              //         tr("withdrawal"),
              //         style: const TextStyle(
              //           fontSize: 16,
              //           color: CustomColors.blackColor,
              //           fontFamily: 'SemiBold',
              //         ),
              //         textAlign: TextAlign.left,
              //       ),
              //     ),
              //   ),
              // ),
              // const SizedBox(
              //   height: 30,
              //   child: Divider(
              //     color: CustomColors.borderColor,
              //     height: 1.0,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  void showPrivacyPolicyAndTermsServiceFullDialog(
      String pageTitle, String url) {
    // showGeneralDialog(
    //     context: context,
    //     barrierColor: Colors.black12.withOpacity(0.6),
    //     // Background color
    //     barrierDismissible: false,
    //     barrierLabel: 'Dialog',
    //     transitionDuration: const Duration(milliseconds: 400),
    //     pageBuilder: (_, __, ___) {
    //       return PrivacyPolicyAndTermsOfUseScreen(pageTitle, url);
    //     });
  }

  // ----------Withdrawal section-----------
  void showWithdrawalModal() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: tr("areYouSureYouWantToLeave"),
            description: tr("withdrawModalDescription"),
            buttonName: "",
            firstButtonName: tr("no"),
            secondButtonName: tr("toLeave"),
            onConfirmBtnTap: () {},
            onFirstBtnTap: () {
              Navigator.of(context).pop();
            },
            onSecondBtnTap: () {
              Navigator.of(context).pop();
              callWithdrawalConfirm();
            },
          );
        });
  }

  void callWithdrawalConfirm() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      // callWithdrawalApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  // void callWithdrawalApi() {
  //   hideKeyboard();
  //   setState(() {
  //     isLoading = true;
  //   });
  //   Map<String, String> body = {
  //     "user_id": base64Enecode(userId.trim()),
  //     "language": language.trim()
  //   };
  //   debugPrint("input for Withdrawal ===> $body");
  //
  //   Future<http.Response> response = WebService().callPostMethodWithRawData(
  //       ApiEndPoint.withdrawalUrl, body, apiKey.trim());
  //   response.then((response) {
  //     var responseJson = json.decode(response.body);
  //
  //     debugPrint("server response for Withdrawal ===> $responseJson");
  //
  //     if (responseJson != null) {
  //       // if (responseJson['token_status']) {
  //       if (response.statusCode == 200 && responseJson['success']) {
  //         if (responseJson['message'] != null) {
  //           showCustomToast(
  //               fToast, context, responseJson['message'].toString(), "");
  //         }
  //
  //         setFirebaseEvents(eventName: "hp_withdrawal");
  //
  //         removeLoginCredential(context);
  //       } else {
  //         if (responseJson['message'] != null) {
  //           showCustomToast(
  //               fToast, context, responseJson['message'].toString(), "");
  //         }
  //       }
  //       // } else {
  //       //   removeLoginCredential(context);
  //       // }
  //     }
  //
  //     setState(() {
  //       isLoading = false;
  //     });
  //   }).catchError((onError) {
  //     debugPrint("catchError ================> $onError");
  //     setState(() {
  //       isLoading = false;
  //     });
  //   });
  // }

  // ----------Logout section-----------
  void callLogout() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      // doLogout();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

// void doLogout() {
//   hideKeyboard();
//   setState(() {
//     isLoading = true;
//   });
//   Map<String, String> body = {"language": language.trim()};
//   debugPrint("input for logout ===> $body");
//
//   // String logOutUrl =
//   //     "https://gscm-api.dvconsulting.org/api/v1/device/$deviceId";  // Test server
//
//   String logOutUrl = ApiEndPoint.logoutUrl + deviceId;
//
//   Future<http.Response> response =
//   WebService().callDeleteMethod(logOutUrl, body, apiKey.trim());
//   response.then((response) {
//     var responseJson = json.decode(response.body);
//
//     debugPrint("server response for logout ===> $responseJson");
//
//     if (responseJson != null) {
//       // if (responseJson['token_status']) {
//       if (response.statusCode == 200 && responseJson['success']) {
//         if (responseJson['message'] != null) {
//           showCustomToast(fToast, context, responseJson['message'].toString(), "");
//         }
//         setFirebaseEvents(eventName: "hp_logout");
//         removeLoginCredential(context);
//       } else {
//         if (responseJson['message'] != null) {
//           showCustomToast(
//               fToast, context, responseJson['message'].toString(), "");
//         }
//       }
//       // } else {
//       //   removeLoginCredential(context);
//       // }
//     }
//
//     setState(() {
//       isLoading = false;
//     });
//   }).catchError((onError) {
//     debugPrint("catchError ================> $onError");
//     setState(() {
//       isLoading = false;
//     });
//   });
// }
}
