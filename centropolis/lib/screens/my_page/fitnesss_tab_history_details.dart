import 'dart:convert';

import 'package:centropolis/widgets/common_button_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/fitness_history_detail_model.dart';
import '../../providers/fitness_history_detail_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_modal.dart';

class FitnessTabHistoryDetails extends StatefulWidget {
  final String reservationId;
  const FitnessTabHistoryDetails({super.key, required this.reservationId});

  @override
  State<FitnessTabHistoryDetails> createState() =>
      _FitnessTabHistoryDetailsState();
}

class _FitnessTabHistoryDetailsState extends State<FitnessTabHistoryDetails> {
  late String language, apiKey;
  late FToast fToast;
  bool isLoading = false;
  FitnessHistoryDetailModel? fitnessHistoryDetailModel;
  bool isLoadingRequired = false;

  @override
  void initState() {
    super.initState();
    language = tr("lang");
    fToast = FToast();
    fToast.init(context);
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    loadFitnessHistoryDetails();
  }

  @override
  Widget build(BuildContext context) {
    fitnessHistoryDetailModel =
        Provider.of<FitnessHistoryDetailsProvider>(context)
            .getFitnessHistoryDetailModel;

    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.whiteColor,
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
              child: CommonAppBar(tr("fitnessReservation"), false, () {
                //onBackButtonPress(context);
                Navigator.pop(context, isLoadingRequired);
              }, () {}),
            ),
          ),
        ),
        body: fitnessHistoryDetailModel != null
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: CustomColors.whiteColor,
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tr("reservationInformation"),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 16,
                                    color: CustomColors.textColor8),
                              ),
                              if (fitnessHistoryDetailModel != null &&
                                  fitnessHistoryDetailModel!.status
                                      .toString()
                                      .isNotEmpty)
                                Container(
                                  decoration: BoxDecoration(
                                    color: fitnessHistoryDetailModel?.status
                                                    .toString() ==
                                                "Before Approval" ||
                                            fitnessHistoryDetailModel?.status
                                                    .toString() ==
                                                "Before Use"
                                        ? CustomColors.backgroundColor3
                                        : fitnessHistoryDetailModel?.status
                                                    .toString() ==
                                                "Approved"
                                            ? CustomColors.backgroundColor
                                            : fitnessHistoryDetailModel?.status
                                                        .toString() ==
                                                    "Used"
                                                ? CustomColors.backgroundColor
                                                : fitnessHistoryDetailModel
                                                            ?.status
                                                            .toString() ==
                                                        "Rejected"
                                                    ? CustomColors.redColor
                                                    : CustomColors
                                                        .backgroundColor,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 5.0,
                                      bottom: 5.0,
                                      left: 10.0,
                                      right: 10.0),
                                  child: Text(
                                    fitnessHistoryDetailModel?.status
                                            .toString() ??
                                        "",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "SemiBold",
                                      color: fitnessHistoryDetailModel?.status
                                                      .toString() ==
                                                  "Before Approval" ||
                                              fitnessHistoryDetailModel?.status
                                                      .toString() ==
                                                  "Before Use"
                                          ? CustomColors.textColor9
                                          : fitnessHistoryDetailModel?.status
                                                      .toString() ==
                                                  "Approved"
                                              ? CustomColors.textColorBlack2
                                              : fitnessHistoryDetailModel
                                                          ?.status
                                                          .toString() ==
                                                      "Used"
                                                  ? CustomColors.textColor3
                                                  : fitnessHistoryDetailModel
                                                              ?.status
                                                              .toString() ==
                                                          "Rejected"
                                                      ? CustomColors
                                                          .headingColor
                                                      : CustomColors
                                                          .textColorBlack2,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tr("nameLounge"),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColorBlack2),
                              ),
                              Text(
                                fitnessHistoryDetailModel?.name.toString() ??
                                    "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    color: CustomColors.textColorBlack2),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Divider(
                              color: CustomColors.backgroundColor2,
                              thickness: 1,
                              height: 1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tr("tenantCompanyLounge"),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColorBlack2),
                              ),
                              Text(
                                fitnessHistoryDetailModel?.companyName
                                        .toString() ??
                                    "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    color: CustomColors.textColorBlack2),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      color: CustomColors.whiteColor,
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr("reservationDate"),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 16,
                                color: CustomColors.textColor8),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Text(
                                  fitnessHistoryDetailModel?.reservationDate
                                          .toString() ??
                                      "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColor8),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 6, vertical: 4),
                                  child: VerticalDivider(
                                    color: CustomColors.textColor3,
                                    thickness: 1,
                                  ),
                                ),
                                Text(
                                  "${fitnessHistoryDetailModel?.startTime.toString() ?? ""} ~ ${fitnessHistoryDetailModel?.endTime.toString() ?? ""}",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColor8),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      color: CustomColors.whiteColor,
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            tr("lockerNumber"),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 16,
                                color: CustomColors.textColor8),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            fitnessHistoryDetailModel?.seat.toString() ?? "",
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                padding: const EdgeInsets.all(24),
                child: Text(
                  tr("noReservationHistory"),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      fontFamily: 'Regular',
                      fontSize: 14,
                      color: CustomColors.textColor5),
                ),
              ),
        bottomSheet: fitnessHistoryDetailModel?.canCancel
                    .toString()
                    .trim()
                    .toLowerCase() ==
                "y"
            ? Container(
                width: MediaQuery.of(context).size.width,
                color: CustomColors.whiteColor,
                padding: const EdgeInsets.only(
                    left: 16, top: 16, right: 16, bottom: 40),
                child: CommonButtonWithBorder(
                    onCommonButtonTap: () {
                      networkCheckForCancelReservation();
                    },
                    buttonBorderColor:
                        fitnessHistoryDetailModel?.status.toString() ==
                                "Approved"
                            ? CustomColors.dividerGreyColor.withOpacity(0.3)
                            : CustomColors.dividerGreyColor,
                    buttonColor: CustomColors.whiteColor,
                    buttonName: tr("cancelReservation"),
                    buttonTextColor:
                        fitnessHistoryDetailModel?.status.toString() ==
                                "Approved"
                            ? CustomColors.textColor5.withOpacity(0.3)
                            : CustomColors.textColor5),
              )
            : null,
      ),
    );
  }

  void loadFitnessHistoryDetails() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callFitnessHistoryDetailsApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callFitnessHistoryDetailsApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {
      "reservation_id": widget.reservationId.toString().trim(),
      "reservation_category": "fitness_center"
    };

    debugPrint("Fitness History details input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.fitnessHistoryDetailUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for Fitness History details ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          FitnessHistoryDetailModel paidLockerHistoryDetailModel =
              FitnessHistoryDetailModel.fromJson(responseJson);

          Provider.of<FitnessHistoryDetailsProvider>(context, listen: false)
              .setItem(paidLockerHistoryDetailModel);
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

  void networkCheckForCancelReservation() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callCancelReservationApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callCancelReservationApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "reservation_id": widget.reservationId.toString().trim(), //required
    };

    debugPrint("Fitness cancel reservation input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.fitnessHistoryDetailCancelReservationUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for Fitness cancel reservation ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          setState(() {
            isLoadingRequired = true;
          });
          showConfirmationModal(responseJson['message'].toString());
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

  void showConfirmationModal(String text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: text,
            description: "",
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
}
