import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/constants.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_modal.dart';
import 'package:http/http.dart' as http;

import '../common_module/login.dart';
import 'change_password.dart';
import 'edit_personal_information.dart';

class PersonalInformationScreen extends StatefulWidget {
  const PersonalInformationScreen({super.key});

  @override
  State<PersonalInformationScreen> createState() =>
      _PersonalInformationScreenState();
}

class _PersonalInformationScreenState extends State<PersonalInformationScreen> {
  late String apiKey, userId, language;
  late FToast fToast;
  bool isLoading = false;
  String deviceId = '';
  String deviceType = '';

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    userId = user.userData['user_id'].toString();
    apiKey = user.userData['api_key'].toString();
    getDeviceIdAndDeviceType();
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
          backgroundColor: CustomColors.whiteColor,
          appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: SafeArea(
              child: Container(
                color: CustomColors.whiteColor,
                child:
                    CommonAppBar(tr("personalInformationSetting"), false, () {
                  onBackButtonPress(context);
                }, () {}),
              ),
            ),
          ),
          body: Container(
            height: MediaQuery.of(context).size.height,
            color: CustomColors.backgroundColor,
            child: SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(left: 16, right: 16, top: 10),
                  color: CustomColors.whiteColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            tr("myProfile"),
                            style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "SemiBold",
                              color: CustomColors.textColor5,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 1.0,
                        color: CustomColors.dividerGreyColor,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const EditPersonalInformationScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(top: 15.0),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 12.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                tr("editPersonalInformation"),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: "SemiBold",
                                  color: CustomColors.textColorBlack2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const ChangePasswordScreen(),
                            ),
                          );
                        },
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 12.0),
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 13.0, bottom: 15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                tr("changePassword"),
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: "SemiBold",
                                  color: CustomColors.textColorBlack2,
                                ),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 10),
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    color: CustomColors.whiteColor,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            showWithdrawalModal();
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(top: 15.0, bottom: 12.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                tr("withdrawal"),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: "SemiBold",
                                  color: CustomColors.textColor3,
                                ),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showLogoutModal();
                          },
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 12.0),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 13.0, bottom: 15.0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  tr("logOut"),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: "SemiBold",
                                    color: CustomColors.textColor3,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            )),
          )),
    );
  }

  // ----------Withdrawal section-----------
  void showWithdrawalModal() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: tr("withdrawAccount"),
            description: tr("withdrawalDetails"),
            buttonName: "",
            firstButtonName: tr("cancel"),
            secondButtonName: tr("check"),
            onConfirmBtnTap: () {},
            onFirstBtnTap: () {
              Navigator.of(context).pop();
            },
            onSecondBtnTap: () {
              callWithdrawalConfirm();
            },
          );
        });
  }

  void callWithdrawalConfirm() async {
    Navigator.of(context).pop();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callWithdrawalApi();
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callWithdrawalApi() {
    hideKeyboard();
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};
    debugPrint("input for Withdrawal ===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.withdrawalUrl, body, language, apiKey.trim());
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Withdrawal ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          // if (responseJson['message'] != null) {
          //   showCustomToast(
          //       fToast, context, responseJson['message'].toString(), "");
          // }

          showWithdrawalSuccessModal();
        } else {
          if (responseJson['message'] != null) {
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

  void showWithdrawalSuccessModal() {
    showGeneralDialog(
        context: context,
        barrierColor: Colors.black12.withOpacity(0.6),
        barrierDismissible: false,
        barrierLabel: 'Dialog',
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) {
          return WillPopScope(
              onWillPop: () {
                return Future.value(false);
              },
              child: CommonModal(
                heading: tr("withdrawnSuccessful"),
                description: tr("youAccountHasBeenSuccessfullyWithdrawn"),
                buttonName: tr("check"),
                firstButtonName: "",
                secondButtonName: "",
                onConfirmBtnTap: () {
                  Navigator.of(context).pop();
                  removeLoginCredential(context);
                },
                onFirstBtnTap: () {},
                onSecondBtnTap: () {},
              ));
        });

    // showDialog(
    //     barrierDismissible: false,
    //     context: context,
    //     builder: (BuildContext context) {
    //       return CommonModal(
    //         heading: tr("withdrawnSuccessful"),
    //         description: tr("youAccountHasBeenSuccessfullyWithdrawn"),
    //         buttonName: tr("check"),
    //         firstButtonName: "",
    //         secondButtonName: "",
    //         onConfirmBtnTap: () {
    //           Navigator.of(context).pop();
    //           removeLoginCredential(context);
    //         },
    //         onFirstBtnTap: () {
    //
    //         },
    //         onSecondBtnTap: () {
    //
    //         },
    //       );
    //     });
  }

  // ----------Logout section-----------
  void showLogoutModal() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: tr("logout"),
            description: tr("doYouWantToLogout"),
            buttonName: "",
            firstButtonName: tr("cancel"),
            secondButtonName: tr("check"),
            onConfirmBtnTap: () {},
            onFirstBtnTap: () {
              Navigator.of(context).pop();
            },
            onSecondBtnTap: () {
              callLogout();
              // removeLoginCredential(context);
            },
          );
        });
  }

  void removeLoginCredential(BuildContext context) {
    var user = Provider.of<UserProvider>(context, listen: false);
    user.doRemoveUser();
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  void callLogout() async {
    Navigator.of(context).pop();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      doLogout();
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void doLogout() {
    hideKeyboard();
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "device_id" : deviceId.trim()
    };
    debugPrint("input for logout ===> $body");


    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.logoutUrl, body, language, apiKey.trim());
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for logout ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['message'] != null) {
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showLogoutSuccesModal(responseJson['message'].toString(),);
          }
          
        } else {
          if (responseJson['message'] != null) {
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

  void showLogoutSuccesModal(String heading) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: heading,
            description: "",
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              removeLoginCredential(context);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }
}
