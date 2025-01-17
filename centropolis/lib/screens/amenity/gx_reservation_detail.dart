import 'dart:convert';

import 'package:centropolis/utils/firebase_analytics_events.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/gx_fitness_reservation_model.dart';
import '../../models/user_info_model.dart';
import '../../providers/user_info_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_modal.dart';
import '../my_page/web_view_ui.dart';

class GXReservationDetail extends StatefulWidget {
  final GxFitnessReservationModel gxReservationItem;
  const GXReservationDetail({super.key, required this.gxReservationItem});

  @override
  State<GXReservationDetail> createState() => _GXReservationDetailState();
}

class _GXReservationDetailState extends State<GXReservationDetail> {
  bool isChecked = false;
  late String language, apiKey;
  late FToast fToast;
  bool isLoading = false;
  String companyName = "";
  String name = "";
  String email = "";
  String mobile = "";
  String reservationRulesLink = "";
  bool isLoadingRequired = false;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    // email = user.userData['email_key'].toString();
    // mobile = user.userData['mobile'].toString();
    //name = user.userData['user_name'].toString();
    //companyName = user.userData['company_name'].toString();
    setWebViewLink();
    loadPersonalInformation();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context, true);
        return true;
      },
      child: LoadingOverlay(
        opacity: 0.5,
        color: CustomColors.textColor4,
        progressIndicator: const CircularProgressIndicator(
          color: CustomColors.blackColor,
        ),
        isLoading: isLoading,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: SafeArea(
              child: Container(
                color: CustomColors.whiteColor,
                child: CommonAppBar(tr("gXReservation"), false, () {
                  //onBackButtonPress(context);
                  Navigator.pop(context, isLoadingRequired);
                }, () {}),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              color: CustomColors.whiteColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    color: CustomColors.whiteColor,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("programInformation"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 16,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          padding: const EdgeInsets.all(16),
                          decoration: const BoxDecoration(
                              color: CustomColors.backgroundColor,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                tr("programName"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                widget.gxReservationItem.title
                                    .toString()
                                    .toUpperCase(),
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    color: CustomColors.textColorBlack2),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                tr("dayOfTheWeek"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                widget.gxReservationItem.programDaysData
                                    .toString(),
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    color: CustomColors.textColorBlack2),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                tr("time"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                widget.gxReservationItem.startTime ?? "",
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    color: CustomColors.textColorBlack2),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                tr("usageAmount"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "${tr("krw")} ${formatNumberStringWithComma(widget.gxReservationItem.totalPrice.toString())} ${tr("perMonth")}",
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    color: CustomColors.textColorBlack2),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                tr("dateOfUse"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "${widget.gxReservationItem.startDate.toString()} ~ ${widget.gxReservationItem.endDate.toString()}",
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    color: CustomColors.textColorBlack2),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                tr("applicationPeriod"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "${widget.gxReservationItem.applicationStartDate.toString()} ~ ${widget.gxReservationItem.applicationEndDate.toString()}",
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    color: CustomColors.textColorBlack2),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                tr("application/NumberOfPeople"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                "${widget.gxReservationItem.appliedNop.toString()} / ${widget.gxReservationItem.totalNop.toString()}",
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    color: CustomColors.textColorBlack2),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text(
                                tr("instructor"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Text(
                                widget.gxReservationItem.instructor ?? "",
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    color: CustomColors.textColorBlack2),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                    color: CustomColors.backgroundColor,
                  ),
                  Container(
                    color: CustomColors.whiteColor,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          tr("reservationInformation"),
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 16,
                              color: CustomColors.textColor8),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr("nameLounge"),
                              style: const TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 14,
                                  color: CustomColors.textColorBlack2),
                            ),
                            Text(
                              name,
                              style: const TextStyle(
                                  fontFamily: 'Regular',
                                  fontSize: 14,
                                  color: CustomColors.textColorBlack2),
                            )
                          ],
                        ),
                        const Padding(
                          padding: EdgeInsets.symmetric(vertical: 16),
                          child: Divider(
                            thickness: 1,
                            height: 1,
                            color: CustomColors.backgroundColor2,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              tr("tenantCompanyLounge"),
                              style: const TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 14,
                                  color: CustomColors.textColorBlack2),
                            ),
                            Text(
                              companyName,
                              style: const TextStyle(
                                  fontFamily: 'Regular',
                                  fontSize: 14,
                                  color: CustomColors.textColorBlack2),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 10,
                    width: MediaQuery.of(context).size.width,
                    color: CustomColors.backgroundColor,
                  ),
                  Container(
                    alignment: FractionalOffset.bottomCenter,
                    color: CustomColors.whiteColor,
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 15,
                                width: 15,
                                child: Transform.scale(
                                  scale: 0.8,
                                  child: Checkbox(
                                    checkColor: CustomColors.whiteColor,
                                    activeColor:
                                        CustomColors.buttonBackgroundColor,
                                    side: const BorderSide(
                                        color: CustomColors.greyColor,
                                        width: 1),
                                    value: isChecked,
                                    onChanged: (value) {
                                      setState(() {
                                        isChecked = value!;
                                        if (isChecked) {
                                        } else {}
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 9,
                              ),
                              language == "en"
                                  ? InkWell(
                                      onTap: () {
                                        showGeneralDialog(
                                            context: context,
                                            barrierColor:
                                                Colors.black12.withOpacity(0.6),
                                            // Background color
                                            barrierDismissible: false,
                                            barrierLabel: 'Dialog',
                                            transitionDuration: const Duration(
                                                milliseconds: 400),
                                            pageBuilder: (_, __, ___) {
                                              return WebViewUiScreen(
                                                  tr("gXReservation"),
                                                  reservationRulesLink);
                                            });
                                      },
                                      child: Text.rich(
                                        TextSpan(
                                          text: tr("agree"),
                                          style: const TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 14,
                                              color:
                                                  CustomColors.textColorBlack2),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: tr("gxReservationRules"),
                                                style: const TextStyle(
                                                  fontFamily: 'Regular',
                                                  fontSize: 14,
                                                  color: CustomColors
                                                      .buttonBackgroundColor,
                                                  decoration:
                                                      TextDecoration.underline,
                                                )),
                                          ],
                                        ),
                                      ),
                                    )
                                  : InkWell(
                                      onTap: () {
                                        showGeneralDialog(
                                            context: context,
                                            barrierColor:
                                                Colors.black12.withOpacity(0.6),
                                            // Background color
                                            barrierDismissible: false,
                                            barrierLabel: 'Dialog',
                                            transitionDuration: const Duration(
                                                milliseconds: 400),
                                            pageBuilder: (_, __, ___) {
                                              return WebViewUiScreen(
                                                  tr("gXReservation"),
                                                  reservationRulesLink);
                                            });
                                      },
                                      child: Text.rich(
                                        TextSpan(
                                          text: tr("gxReservationRules"),
                                          style: const TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 14,
                                              decoration:
                                                  TextDecoration.underline,
                                              color: CustomColors
                                                  .buttonBackgroundColor),
                                          children: <TextSpan>[
                                            TextSpan(
                                                text: tr("agree"),
                                                style: const TextStyle(
                                                  fontFamily: 'Regular',
                                                  fontSize: 14,
                                                  color: CustomColors
                                                      .textColorBlack2,
                                                  decoration:
                                                      TextDecoration.none,
                                                )),
                                          ],
                                        ),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 24, bottom: 32),
                          child: CommonButton(
                            onCommonButtonTap: () {
                              reservationValidationCheck();
                            },
                            buttonColor: CustomColors.buttonBackgroundColor,
                            buttonName: tr("apply"),
                            isIconVisible: false,
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void reservationValidationCheck() {
    if (!isChecked) {
      showErrorModal(tr("pleaseConsentToCollect"));
    } else {
      networkCheckForReservation();
    }
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

  void networkCheckForReservation() async {
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callReservationApi();
    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callReservationApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "program_id": widget.gxReservationItem.id.toString().trim(), //required
      "email": email.trim(), //required
      "mobile": mobile.trim(), //required
    };

    debugPrint("gx reservation input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.gxReservationUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for gx reservation ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          setState(() {
            isLoadingRequired = true;
          });
          if (responseJson['title'] != null) {
            showReservationModal(
                responseJson['title'].toString().replaceAll(".", ""),
                responseJson['message']);
          } else {
            showReservationModal(responseJson['message'], "");
          }
          setFirebaseEventForGXReservation(gxId: responseJson['reservation_id'] ?? "");
        } else {
          if (responseJson['message'] != null) {
            debugPrint("Server error response ${responseJson['message']}");
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
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
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  void showReservationModal(String title, String desc) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: title,
            description: desc,
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
              Navigator.pop(context, isLoadingRequired);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
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
            companyName = userInfoModel.companyName.toString();
            name = userInfoModel.name.toString();
            email = userInfoModel.email.toString();
            mobile = userInfoModel.mobile.toString();
          });
        } else {
          if (responseJson['message'] != null) {
            debugPrint("Server error response ${responseJson['message']}");
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
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
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  void setWebViewLink() {
    if (language == "en") {
      setState(() {
        reservationRulesLink = WebViewLinks.gxUrlEng;
      });
    } else {
      setState(() {
        reservationRulesLink = WebViewLinks.gxUrlKo;
      });
    }
  }
}
