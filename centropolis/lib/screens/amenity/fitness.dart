import 'dart:convert';

import 'package:centropolis/widgets/fitness_congestion.dart';
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
import 'fitness_reservation.dart';

class FitnessScreen extends StatefulWidget {
  const FitnessScreen({super.key});

  @override
  State<FitnessScreen> createState() => _FitnessScreenState();
}

class _FitnessScreenState extends State<FitnessScreen> {
  late String language, apiKey;
  late FToast fToast;
  bool isLoading = false;
  String congestionType = "full";

  @override
  void initState() {
    super.initState();
    language = tr("lang");
    fToast = FToast();
    fToast.init(context);
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    loadFitnessCongestion();
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
                      "assets/images/fitness.png",
                      height: 320,
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
                        const Text(
                          "Fitness",
                          style: TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.buttonBackgroundColor),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          tr("fitness"),
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
                          tr("fitnessOperatingTime"),
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
                        fitnessRow(tr("fitnessFacilityInfoText1")),
                        fitnessRow(tr("fitnessFacilityInfoText2")),
                        fitnessRow(tr("fitnessFacilityInfoText3")),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          tr("fitnessFacilityInfo"),
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.headingColor),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          tr("tenantBenefits"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 14,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        fitnessRow(tr("fitnessTenantBenefitsText1")),
                        fitnessRow(tr("fitnessTenantBenefitsText2")),
                        fitnessRow(tr("fitnessTenantBenefitsText3")),
                        fitnessRow(tr("fitnessTenantBenefitsText4")),
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
                          tr("fitnessInquiry"),
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          tr("fitnessCongestion"),
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
                  child: CommonButton(
                    onCommonButtonTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const FitnessReservation(position: 0),
                        ),
                      );
                    },
                    buttonColor: CustomColors.buttonBackgroundColor,
                    buttonName: tr("makeFitnessAppointment"),
                    isIconVisible: true,
                  ),
                ),
              )
            ],
          )),
    );
  }

  fitnessRow(text) {
    return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 7, right: 10),
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

  void loadFitnessCongestion() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callFitnessCongestionApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callFitnessCongestionApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {};

    debugPrint("Fitness Congestion input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.finessCongestionUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Fitness Congestion ===> $responseJson");

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
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
        setState(() {
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isLoading = false;
      });
    });
  }
}
