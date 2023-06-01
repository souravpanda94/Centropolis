import 'dart:convert';

import 'package:centropolis/widgets/common_button_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/gx_history_detail_model.dart';
import '../../providers/gx_history_detail_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';

class GXHistoryDetails extends StatefulWidget {
  final String reservationId;
  const GXHistoryDetails({super.key, required this.reservationId});

  @override
  State<GXHistoryDetails> createState() => _GXHistoryDetailsState();
}

class _GXHistoryDetailsState extends State<GXHistoryDetails> {
  late String language, apiKey;
  late FToast fToast;
  bool isLoading = false;
  GXHistoryDetailModel? gxHistoryDetailModel;

  @override
  void initState() {
    super.initState();
    language = tr("lang");
    fToast = FToast();
    fToast.init(context);
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    loadGXHistoryDetails();
  }

  @override
  Widget build(BuildContext context) {
    gxHistoryDetailModel =
        Provider.of<GXHistoryDetailsProvider>(context).getGXHistoryDetailModel;

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
              child: CommonAppBar(tr("gxReservation"), false, () {
                onBackButtonPress(context);
              }, () {}),
            ),
          ),
        ),
        body: gxHistoryDetailModel != null
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: CustomColors.whiteColor,
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(tr("programInformation"),
                              style: const TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 16,
                                  color: CustomColors.textColor8)),
                          Container(
                            margin: const EdgeInsets.only(top: 16),
                            padding: const EdgeInsets.all(16),
                            width: MediaQuery.of(context).size.width,
                            decoration: const BoxDecoration(
                                color: CustomColors.backgroundColor,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4))),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(tr("programName"),
                                    style: const TextStyle(
                                        fontFamily: 'SemiBold',
                                        fontSize: 14,
                                        color: CustomColors.textColor8)),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  gxHistoryDetailModel?.programName
                                          .toString() ??
                                      "",
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColorBlack2),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(tr("dayOfTheWeek"),
                                    style: const TextStyle(
                                        fontFamily: 'SemiBold',
                                        fontSize: 14,
                                        color: CustomColors.textColor8)),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  gxHistoryDetailModel?.dayOfWeek?.join(",") ??
                                      "",
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColorBlack2),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(tr("time"),
                                    style: const TextStyle(
                                        fontFamily: 'SemiBold',
                                        fontSize: 14,
                                        color: CustomColors.textColor8)),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  gxHistoryDetailModel?.startTime.toString() ??
                                      "",
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColorBlack2),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(tr("usageAmount"),
                                    style: const TextStyle(
                                        fontFamily: 'SemiBold',
                                        fontSize: 14,
                                        color: CustomColors.textColor8)),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "KRW ${gxHistoryDetailModel?.usageAmount.toString() ?? ""} per month (excluding tax)",
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColorBlack2),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(tr("dateOfUse"),
                                    style: const TextStyle(
                                        fontFamily: 'SemiBold',
                                        fontSize: 14,
                                        color: CustomColors.textColor8)),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  gxHistoryDetailModel?.dateOfUse.toString() ??
                                      "",
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColorBlack2),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(tr("applicationPeriod"),
                                    style: const TextStyle(
                                        fontFamily: 'SemiBold',
                                        fontSize: 14,
                                        color: CustomColors.textColor8)),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  gxHistoryDetailModel?.applicationPeriod
                                          .toString() ??
                                      "",
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColorBlack2),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                Text(tr("application/NumberOfPeople"),
                                    style: const TextStyle(
                                        fontFamily: 'SemiBold',
                                        fontSize: 14,
                                        color: CustomColors.textColor8)),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${gxHistoryDetailModel?.appliedNop.toString() ?? ""} / ${gxHistoryDetailModel?.noOfPeople.toString() ?? ""}",
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
                      color: CustomColors.whiteColor,
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 120),
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
                              if (gxHistoryDetailModel != null &&
                                  gxHistoryDetailModel!.status
                                      .toString()
                                      .isNotEmpty)
                                Container(
                                  decoration: BoxDecoration(
                                    color: gxHistoryDetailModel?.status
                                                    .toString() ==
                                                "Before Approval" ||
                                            gxHistoryDetailModel?.status
                                                    .toString() ==
                                                "Before Use"
                                        ? CustomColors.backgroundColor3
                                        : gxHistoryDetailModel?.status
                                                    .toString() ==
                                                "Approved"
                                            ? CustomColors.backgroundColor
                                            : gxHistoryDetailModel?.status
                                                        .toString() ==
                                                    "Used"
                                                ? CustomColors.backgroundColor
                                                : gxHistoryDetailModel?.status
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
                                    gxHistoryDetailModel?.status.toString() ??
                                        "",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "SemiBold",
                                      color: gxHistoryDetailModel?.status
                                                      .toString() ==
                                                  "Before Approval" ||
                                              gxHistoryDetailModel?.status
                                                      .toString() ==
                                                  "Before Use"
                                          ? CustomColors.textColor9
                                          : gxHistoryDetailModel?.status
                                                      .toString() ==
                                                  "Approved"
                                              ? CustomColors.textColorBlack2
                                              : gxHistoryDetailModel?.status
                                                          .toString() ==
                                                      "Used"
                                                  ? CustomColors.textColor3
                                                  : gxHistoryDetailModel?.status
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
                                gxHistoryDetailModel?.name.toString() ?? "",
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
                                gxHistoryDetailModel?.companyName.toString() ??
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
        bottomSheet: Container(
          width: MediaQuery.of(context).size.width,
          color: CustomColors.whiteColor,
          padding:
              const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 40),
          child: CommonButtonWithBorder(
              onCommonButtonTap: () {},
              buttonBorderColor:
                  gxHistoryDetailModel?.status.toString() == "Approved"
                      ? CustomColors.dividerGreyColor.withOpacity(0.3)
                      : CustomColors.dividerGreyColor,
              buttonColor: CustomColors.whiteColor,
              buttonName: tr("cancelReservation"),
              buttonTextColor:
                  gxHistoryDetailModel?.status.toString() == "Approved"
                      ? CustomColors.textColor5.withOpacity(0.3)
                      : CustomColors.textColor5),
        ),
      ),
    );
  }

  void loadGXHistoryDetails() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callGXHistoryDetailsApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callGXHistoryDetailsApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {
      "reservation_id": widget.reservationId.toString().trim(),
      "reservation_category": "gx"
    };

    debugPrint("GX History details input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.gxHistoryDetailUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for GX History details ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          GXHistoryDetailModel gxHistoryDetailModel =
              GXHistoryDetailModel.fromJson(responseJson);

          Provider.of<GXHistoryDetailsProvider>(context, listen: false)
              .setItem(gxHistoryDetailModel);
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
