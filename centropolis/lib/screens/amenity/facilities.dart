import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import 'package:http/http.dart' as http;

import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_button_with_icon.dart';
import '../../widgets/fitness_congestion.dart';
import 'sleeping_room_reservation.dart';

class FacilitiesScreen extends StatefulWidget {
  const FacilitiesScreen({super.key});

  @override
  State<FacilitiesScreen> createState() => _FacilitiesScreenState();
}

class _FacilitiesScreenState extends State<FacilitiesScreen> {
  late String language, apiKey;
  late FToast fToast;
  bool isLoading = false;
  String congestionType = "confusion";

  @override
  void initState() {
    super.initState();
    language = tr("lang");
    fToast = FToast();
    fToast.init(context);
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    loadSleepingRoomCongestion();
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
                      "assets/images/refresh.png",
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
                          tr("refreshMainHeading"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.buttonBackgroundColor),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          tr("facilities"),
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
                          tr("facilityOperatingTime"),
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          tr("facilityInformation"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        facilityRow(tr("facilityInfoText1")),
                        facilityRow(tr("facilityInfoText2")),
                        facilityRow(tr("facilityInfoText3")),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          tr("howToUse"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          tr("facilityUsage"),
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                        facilityRow(tr("facilityUsageText1")),
                        facilityRow(tr("facilityUsageText2")),
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
                          tr("facilityInquiry"),
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          tr("sleepingRoomCongestion"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        FitnessCongestion(
                          type: congestionType,
                        )
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SleepingRoomReservation(),
                        ),
                      );
                    },
                    buttonColor: CustomColors.buttonBackgroundColor,
                    buttonName: tr("makeSleepingRoomReservation"),
                  ),
                ),
              )
            ],
          )),
    );
  }

  facilityRow(text) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 7, right: 10, left: 8),
            child: Icon(
              Icons.circle,
              size: 5,
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                  fontFamily: 'Regular',
                  fontSize: 14,
                  color: CustomColors.textColorBlack2),
            ),
          )
        ]);
  }

  void loadSleepingRoomCongestion() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callSleepingRoomCongestionApi();
    } else {
       //showCustomToast(fToast, context, tr("noInternetConnection"), "");
       showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callSleepingRoomCongestionApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {};

    debugPrint("SleepingRoom Congestion input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.sleepingRoomUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for SleepingRoom Congestion ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          setState(() {
            if (responseJson['congestion_type'].toString() == "low") {
              congestionType = "spare";
            } else if (responseJson['congestion_type'].toString() == "medium") {
              congestionType = "commonly";
            } else if (responseJson['congestion_type'].toString() == "high") {
              congestionType = "confusion";
            } else {
              congestionType = "full";
            }
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
        setState(() {
          isLoading = false;
        });
      }
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
}
