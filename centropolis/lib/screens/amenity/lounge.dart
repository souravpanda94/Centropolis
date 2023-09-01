import 'dart:convert';

import 'package:centropolis/widgets/common_button_with_icon.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../models/user_info_model.dart';
import '../../providers/user_info_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';

import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_modal.dart';
import 'lounge_reservation.dart';
import 'package:http/http.dart' as http;

class LoungeScreen extends StatefulWidget {
  const LoungeScreen({super.key});

  @override
  State<LoungeScreen> createState() => _LoungeScreenState();
}

class _LoungeScreenState extends State<LoungeScreen> {
  late String language, apiKey;
  String accountType = "";
  late FToast fToast;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    loadPersonalInformation();
  }

  @override
  Widget build(BuildContext context) {
    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.textColor4,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isLoading,
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: [
              SingleChildScrollView(
                  child: Column(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      "assets/images/lounge.png",
                      height: 316,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Container(
                    color: CustomColors.whiteColor,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.only(
                        left: 16, right: 16, top: 24, bottom: 100),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Text(
                          tr("loungeMainHeading"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor9),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          tr("loungeTitle"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 22,
                              color: CustomColors.textColorBlack2),
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Text(
                          tr("operatingTime"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          tr("loungeOperatingTime"),
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          tr("availableMenu"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          tr("loungeAvailableMenu"),
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          tr("loungeRental"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          tr("loungeRentalHours"),
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          tr("inquiry"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          tr("loungeInquiry"),
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin:
                      const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                  child: CommonButtonWithIcon(
                    onCommonButtonTap: () {
                      if (accountType == "tenant_manager" ||
                          accountType == "tenant_lounge_employee") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const LoungeReservation(),
                          ),
                        );
                      } else {
                        showErrorModal(tr("accessDenied"));
                      }
                    },
                    buttonColor: CustomColors.buttonBackgroundColor,
                    buttonName: tr("makeALoungeReservation"),
                  ),
                ),
              )
            ],
          )),
    );
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
      setState(() {
        isLoading = false;
      });
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      if (mounted) {
        showErrorCommonModal(context: context,
          heading: tr("errorDescription"),
          description:"",
          buttonName : tr("check"));
      setState(() {
        isLoading = false;
      });

      }
       
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
}
