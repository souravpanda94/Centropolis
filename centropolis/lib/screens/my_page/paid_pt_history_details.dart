import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/paid_pt_history_detail_model.dart';
import '../../providers/paid_pt_history_detail_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_button_with_border.dart';
import '../amenity/fitness_reservation.dart';
import '../amenity/paidPT_reservation.dart';

class PaidPTHistoryDetails extends StatefulWidget {
  final String reservationId;

  const PaidPTHistoryDetails({super.key, required this.reservationId});

  @override
  State<PaidPTHistoryDetails> createState() => _PaidPTHistoryDetailsState();
}

class _PaidPTHistoryDetailsState extends State<PaidPTHistoryDetails> {
  late String language, apiKey;
  late FToast fToast;
  bool isLoading = false;
  PaidPtHistoryDetailModel? paidPtHistoryDetailModel;

  @override
  void initState() {
    super.initState();
    language = tr("lang");
    fToast = FToast();
    fToast.init(context);
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    loadPaidPtHistoryDetails();
  }

  @override
  Widget build(BuildContext context) {
    paidPtHistoryDetailModel =
        Provider.of<PaidPtHistoryDetailsProvider>(context)
            .getPaidPtHistoryDetailModel;
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
              child: CommonAppBar(tr("ptReservationHistoryDetails"), false, () {
                onBackButtonPress(context);
              }, () {}),
            ),
          ),
        ),
        body: paidPtHistoryDetailModel != null
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
                              if (paidPtHistoryDetailModel != null &&
                                  paidPtHistoryDetailModel!.status
                                      .toString()
                                      .isNotEmpty)
                                Container(
                                  decoration: BoxDecoration(
                                    color: setStatusBackgroundColor(
                                        paidPtHistoryDetailModel!.status
                                            .toString()),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 5.0,
                                      bottom: 5.0,
                                      left: 10.0,
                                      right: 10.0),
                                  child: Text(
                                    paidPtHistoryDetailModel?.displayStatus
                                            .toString() ??
                                        "",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "SemiBold",
                                      color: setStatusTextColor(
                                          paidPtHistoryDetailModel!.status
                                              .toString()),
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
                                paidPtHistoryDetailModel?.name.toString() ?? "",
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
                                paidPtHistoryDetailModel?.companyName
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
                            tr("prefferedDateTime"),
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
                                  paidPtHistoryDetailModel?.reservationStartDate
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
                                      horizontal: 3, vertical: 4),
                                  child: VerticalDivider(
                                    color: CustomColors.textColor3,
                                    thickness: 1,
                                  ),
                                ),
                                Text(
                                  paidPtHistoryDetailModel?.usageTime
                                          .toString() ??
                                      "",
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
                            tr("numberOfUses"),
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
                            formatNumberStringWithComma(paidPtHistoryDetailModel
                                    ?.usageCount
                                    .toString() ??
                                ""),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                          ),
                        ],
                      ),
                    ),
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
        bottomSheet:
            paidPtHistoryDetailModel?.canEdit.toString().toLowerCase() == 'y'
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    color: CustomColors.whiteColor,
                    padding: const EdgeInsets.only(
                        left: 16, top: 16, right: 16, bottom: 50),
                    child: CommonButton(
                      onCommonButtonTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  FitnessReservation(
                                position: 2,
                                operationName: "edit",
                                reservationId: widget.reservationId,
                                paidPtHistoryDetailModel: paidPtHistoryDetailModel),
                          ),
                        );
                      },
                      buttonColor: CustomColors.buttonBackgroundColor,
                      buttonName: tr("edit"),
                      isIconVisible: false,
                    ),
                  )
                : const SizedBox(),
      ),
    );
  }

  void loadPaidPtHistoryDetails() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callPaidPtHistoryDetailsApi();
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callPaidPtHistoryDetailsApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {
      "reservation_id": widget.reservationId.toString().trim(),
      "reservation_category": "pt"
    };

    debugPrint("PaidPt History details input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.paidPtHistoryDetailUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for PaidPt History details ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          PaidPtHistoryDetailModel paidPtHistoryDetailModel =
              PaidPtHistoryDetailModel.fromJson(responseJson);

          Provider.of<PaidPtHistoryDetailsProvider>(context, listen: false)
              .setItem(paidPtHistoryDetailModel);
        } else {
          if (responseJson['message'] != null) {
            // showCustomToast(fToast, context, responseJson['message'].toString(), "");
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

  Color setStatusBackgroundColor(String? status) {
    if (status.toString().toLowerCase() == "rejected" ||
        status.toString().toLowerCase() == "cancelled") {
      return CustomColors.backgroundColor3;
    } else {
      return CustomColors.backgroundColor;
    }
  }

  Color setStatusTextColor(String? status) {
    if (status.toString().toLowerCase() == "rejected" ||
        status.toString().toLowerCase() == "cancelled") {
      return CustomColors.textColor9;
    } else if (status.toString().toLowerCase() == "used") {
      return CustomColors.textColor3;
    } else {
      return CustomColors.textColorBlack2;
    }
  }
}
