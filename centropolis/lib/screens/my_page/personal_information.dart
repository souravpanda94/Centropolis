import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
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

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    userId = user.userData['user_id'].toString();
    apiKey = user.userData['api_key'].toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              color: CustomColors.whiteColor,
              child: CommonAppBar(tr("personalInformationSetting"), false, () {
                onBackButtonPress(context);
              }, () {}),
            ),
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10),
              padding: const EdgeInsets.only(left: 16, right: 16),
              color: CustomColors.whiteColor,
              child: Column(
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
                  Container(
                    margin: const EdgeInsets.only(top: 15.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 15.0, bottom: 12.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          tr("editPersonalInformation"),
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "SemiBold",
                            color: CustomColors.textColor5,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 12.0),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 13.0, bottom: 15.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          tr("changePassword"),
                          style: const TextStyle(
                            fontSize: 14,
                            fontFamily: "SemiBold",
                            color: CustomColors.textColor5,
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
                  children: [
                    InkWell(
                      onTap: () {
                        showWithdrawalModal();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 10.0),
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
                    ),
                    InkWell(
                      onTap: () {
                        showLogoutModal();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 12.0),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(top: 13.0, bottom: 15.0),
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
                ))
          ],
        )));
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

  void callWithdrawalApi() {
    hideKeyboard();
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "user_id": base64Enecode(userId.trim()),
      "language": language.trim()
    };
    debugPrint("input for Withdrawal ===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.withdrawalUrl, body, apiKey.trim());
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Withdrawal ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }

          removeLoginCredential(context);
        } else {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
      }

      setState(() {
        isLoading = false;
      });
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isLoading = false;
      });
    });
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
              Navigator.of(context).pop();
              callLogout();
            },
          );
        });
  }

  void callLogout() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      // doLogout();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void doLogout() {
    hideKeyboard();
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {"language": language.trim()};
    debugPrint("input for logout ===> $body");

    // String logOutUrl =
    //     "https://gscm-api.dvconsulting.org/api/v1/device/$deviceId";  // Test server

    // String logOutUrl = ApiEndPoint.logoutUrl + deviceId;

    Future<http.Response> response = WebService()
        .callDeleteMethod(ApiEndPoint.logoutUrl, body, apiKey.trim());
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for logout ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
          removeLoginCredential(context);
        } else {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
      }

      setState(() {
        isLoading = false;
      });
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isLoading = false;
      });
    });
  }
}
