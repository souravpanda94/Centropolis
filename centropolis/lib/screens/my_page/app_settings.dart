import 'dart:convert';
import 'package:centropolis/screens/my_page/privacy_policy_and_terms_of_use_screen.dart';
import 'package:centropolis/screens/my_page/web_view_ui.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/firebase_analytics_events.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/bottom_navigation.dart';
import '../../widgets/common_app_bar.dart';
import 'package:http/http.dart' as http;

class AppSettingsScreen extends StatefulWidget {
  const AppSettingsScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _AppSettingsScreenState();
  }
}

class _AppSettingsScreenState extends State<AppSettingsScreen> {
  late String apiKey, userId, deviceId, language;
  late FToast fToast;
  String appVersion = "";
  bool isSwitched = false;
  String isPushAllow = "n";
  var textValue = 'Switch is OFF';
  bool isLoading = false;
  String privacyPolicyLink = "";
  String termsOfUseLink = "";

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
    isPushAllow = user.userData['push_notification'].toString();
    user.addListener(() {
      isPushAllow = user.userData['push_notification'].toString();
    });
    debugPrint("===========isPushAllow =======> $isPushAllow");
    setWebViewLink();

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
    setPushNotification();
  }

  void setSwitchButtonsValue() {
    debugPrint("isPushAllow =======> $isPushAllow");
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
                padding: const EdgeInsets.only(
                  top: 15.0,
                  bottom: 15.0,
                  left: 16.0,
                  right: 16.0,
                ),
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
                              fontSize: 14,
                              color: CustomColors.blackColor,
                              fontFamily: 'SemiBold',
                            ),
                            textAlign: TextAlign.left,
                          ),
                          FlutterSwitch(
                            height: 22.0,
                            width: 40.0,
                            padding: 2.0,
                            toggleSize: 19.0,
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
                    InkWell(
                      onTap: () {
                        if (language == "ko") {
                          context.setLocale(const Locale('en'));
                          setFirebaseEventForLanguageChange(language: "en");
                        } else {
                          context.setLocale(const Locale('ko'));
                          setFirebaseEventForLanguageChange(language: "ko");
                        }
                        goToHomeScreen();
                      },
                      child: Container(
                        margin: const EdgeInsets.only(top: 6.0),
                        padding: const EdgeInsets.only(top: 7.0, bottom: 7.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr("changeLanguage"),
                              style: const TextStyle(
                                fontSize: 14,
                                color: CustomColors.blackColor,
                                fontFamily: 'SemiBold',
                              ),
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              language == "en" ? "KOR" : "ENG",
                              style: const TextStyle(
                                fontSize: 14,
                                color: CustomColors.textColor9,
                                fontFamily: 'SemiBold',
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ],
                        ),
                      ),
                    )
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
                        // showPrivacyPolicyAndTermsServiceFullDialog(
                        //     tr("privacyPolicy"), WebViewLinks.privacyPolicyUrl);

                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>  PrivacyPolicyAndTermsOfUseScreen(tr("privacyPolicy")),
                        //   ),
                        // );

                        showGeneralDialog(
                            context: context,
                            barrierColor: Colors.black12.withOpacity(0.6),
                            // Background color
                            barrierDismissible: false,
                            barrierLabel: 'Dialog',
                            transitionDuration:
                                const Duration(milliseconds: 400),
                            pageBuilder: (_, __, ___) {
                              return WebViewUiScreen(
                                  tr("privacyPolicy"), privacyPolicyLink);
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 25.0,
                          bottom: 15.0,
                        ),
                        // color: Colors.purple,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            tr("privacyPolicy"),
                            style: const TextStyle(
                              fontSize: 14,
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
                        // showPrivacyPolicyAndTermsServiceFullDialog(
                        //     tr("termsOfUse"), WebViewLinks.termsOfUseUrl);
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(
                        //     builder: (context) =>  PrivacyPolicyAndTermsOfUseScreen(tr("termsOfUse")),
                        //   ),
                        // );

                        showGeneralDialog(
                            context: context,
                            barrierColor: Colors.black12.withOpacity(0.6),
                            // Background color
                            barrierDismissible: false,
                            barrierLabel: 'Dialog',
                            transitionDuration:
                                const Duration(milliseconds: 400),
                            pageBuilder: (_, __, ___) {
                              return WebViewUiScreen(
                                  tr("termsOfUse"), termsOfUseLink);
                            });
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                          top: 15.0,
                          bottom: 25.0,
                        ),
                        // color: Colors.yellow,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            tr("termsOfUse"),
                            style: const TextStyle(
                              fontSize: 14,
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
                margin: const EdgeInsets.only(top: 10.0, bottom: 100),
                padding: const EdgeInsets.only(
                    top: 25.0, bottom: 25.0, left: 16.0, right: 16.0),
                color: CustomColors.whiteColor,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      tr("versionInformation"),
                      style: const TextStyle(
                        fontSize: 14,
                        color: CustomColors.blackColor,
                        fontFamily: 'SemiBold',
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          tr("version"),
                          style: const TextStyle(
                            fontSize: 12,
                            color: CustomColors.textColor3,
                            fontFamily: 'Regular',
                          ),
                          textAlign: TextAlign.left,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Text(
                          appVersion,
                          style: const TextStyle(
                            fontSize: 14,
                            color: CustomColors.textColor3,
                            fontFamily: 'Regular',
                          ),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showPrivacyPolicyAndTermsServiceFullDialog(
      String pageTitle, String url) {
    debugPrint("url =====> $url");
    showGeneralDialog(
        context: context,
        barrierColor: Colors.black12.withOpacity(0.6),
        // Background color
        barrierDismissible: false,
        barrierLabel: 'Dialog',
        transitionDuration: const Duration(milliseconds: 400),
        pageBuilder: (_, __, ___) {
          return WebViewUiScreen(pageTitle, url);
        });
  }

  void goToHomeScreen() {
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(context).popUntil((route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigationScreen(0, 0),
      ),
    );
  }

  // ----------set push notification section-----------
  void setPushNotification() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callPushNotificationApi();
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callPushNotificationApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {"push_alarm": isPushAllow.trim()};
    debugPrint("input for set push notification ===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.setPushNotificationUrl, body, language, apiKey.trim());
    response.then((response) {
      var responseJson = json.decode(response.body);
      debugPrint(
          "server response for set push notification ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          String onOffStatus = "";
          if (responseJson['message'] != null) {
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(context: context,
                heading :responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          }
          var user = Provider.of<UserProvider>(context, listen: false);
          user.userData['push_notification'] = isPushAllow.toString();
          user.doAddUser(user.userData);
          if(isPushAllow.toString() == "y"){
            onOffStatus = "on";
          }else if(isPushAllow.toString() == "n"){
            onOffStatus = "off";
          }
          setFirebaseEventForPushNotificationSetup(status: onOffStatus);
        } else {
          // showCustomToast(
          //     fToast, context, responseJson['message'].toString(), "");
          showErrorCommonModal(context: context,
              heading :responseJson['message'].toString(),
              description: "",
              buttonName: tr("check"));
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

  void setWebViewLink() {
    if (language == "en") {
      setState(() {
        privacyPolicyLink = WebViewLinks.privacyPolicyUrlEng;
        termsOfUseLink = WebViewLinks.termsOfUseUrlEng;
      });
    } else {
      setState(() {
        privacyPolicyLink = WebViewLinks.privacyPolicyUrlKo;
        termsOfUseLink = WebViewLinks.termsOfUseUrlKo;
      });
    }
  }
}
