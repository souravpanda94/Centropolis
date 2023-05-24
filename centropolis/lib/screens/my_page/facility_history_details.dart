import 'dart:convert';

import 'package:centropolis/widgets/common_button_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/sleeping_room_history_detail_model.dart';
import '../../providers/sleeping_room_detail_history_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';

class FacilityHistoryDetails extends StatefulWidget {
  final String id;
  const FacilityHistoryDetails({super.key, required this.id});

  @override
  State<FacilityHistoryDetails> createState() => _FacilityHistoryDetails();
}

class _FacilityHistoryDetails extends State<FacilityHistoryDetails> {
  late String language, apiKey;
  late FToast fToast;
  bool isLoading = false;
  SleepingRoomHistoryDetailModel? sleepingRoomHistoryDetailModel;

  @override
  void initState() {
    super.initState();
    language = tr("lang");
    fToast = FToast();
    fToast.init(context);
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    loadSleepingRoomHistoryDetails();
  }

  @override
  Widget build(BuildContext context) {
    sleepingRoomHistoryDetailModel =
        Provider.of<SleepingRoomHistoryDetailsProvider>(context)
            .getSleepingRoomHistoryDetailModel;

    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(tr("sleepingRoomReservation"), false, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: LoadingOverlay(
        opacity: 0.5,
        color: CustomColors.whiteColor,
        progressIndicator: const CircularProgressIndicator(
          color: CustomColors.blackColor,
        ),
        isLoading: isLoading,
        child: sleepingRoomHistoryDetailModel != null
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
                              if (sleepingRoomHistoryDetailModel?.status
                                      .toString() !=
                                  "")
                                Container(
                                  decoration: BoxDecoration(
                                    color: sleepingRoomHistoryDetailModel
                                                    ?.status
                                                    .toString() ==
                                                "Before Approval" ||
                                            sleepingRoomHistoryDetailModel
                                                    ?.status
                                                    .toString() ==
                                                "Before Use"
                                        ? CustomColors.backgroundColor3
                                        : sleepingRoomHistoryDetailModel?.status
                                                    .toString() ==
                                                "Approved"
                                            ? CustomColors.backgroundColor
                                            : sleepingRoomHistoryDetailModel
                                                        ?.status
                                                        .toString() ==
                                                    "Used"
                                                ? CustomColors.backgroundColor
                                                : sleepingRoomHistoryDetailModel!
                                                            .status
                                                            .toString() ==
                                                        "Rejected"
                                                    ? CustomColors.redColor
                                                    : CustomColors
                                                        .textColorBlack2,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 5.0,
                                      bottom: 5.0,
                                      left: 10.0,
                                      right: 10.0),
                                  child: Text(
                                    sleepingRoomHistoryDetailModel?.status ??
                                        "",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "SemiBold",
                                      color: sleepingRoomHistoryDetailModel
                                                      ?.status
                                                      .toString() ==
                                                  "Before Approval" ||
                                              sleepingRoomHistoryDetailModel
                                                      ?.status
                                                      .toString() ==
                                                  "Before Use"
                                          ? CustomColors.textColor9
                                          : sleepingRoomHistoryDetailModel
                                                      ?.status
                                                      .toString() ==
                                                  "Approved"
                                              ? CustomColors.textColorBlack2
                                              : sleepingRoomHistoryDetailModel
                                                          ?.status
                                                          .toString() ==
                                                      "Used"
                                                  ? CustomColors.textColor3
                                                  : sleepingRoomHistoryDetailModel!
                                                              .status
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
                                sleepingRoomHistoryDetailModel?.name ?? "",
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
                                sleepingRoomHistoryDetailModel?.companyName ??
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
                                  sleepingRoomHistoryDetailModel
                                          ?.reservationDate ??
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
                                  sleepingRoomHistoryDetailModel?.usageTime ??
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
                            tr("seatNumber"),
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
                          const Text(
                            "22",
                            style: TextStyle(
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
            : Container(),
      ),
      bottomSheet: sleepingRoomHistoryDetailModel?.canCancel == "y"
          ? Container(
              width: MediaQuery.of(context).size.width,
              color: CustomColors.whiteColor,
              padding: const EdgeInsets.only(
                  left: 16, top: 16, right: 16, bottom: 40),
              child: CommonButtonWithBorder(
                  onCommonButtonTap: () {},
                  buttonBorderColor:
                      sleepingRoomHistoryDetailModel?.status == "Approved"
                          ? CustomColors.dividerGreyColor.withOpacity(0.3)
                          : CustomColors.dividerGreyColor,
                  buttonColor: CustomColors.whiteColor,
                  buttonName: tr("cancelReservation"),
                  buttonTextColor:
                      sleepingRoomHistoryDetailModel?.status == "Approved"
                          ? CustomColors.textColor5.withOpacity(0.3)
                          : CustomColors.textColor5),
            )
          : null,
    );
  }

  void loadSleepingRoomHistoryDetails() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callSleepingRoomHistoryDetailsApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callSleepingRoomHistoryDetailsApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {
      "sleeping_reservation_id": widget.id.toString().trim()
    };

    debugPrint("sleepingRoom History details input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.sleepingRoomHistoryDetailsUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for sleepingRoom History details ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          SleepingRoomHistoryDetailModel sleepingRoomHistoryDetailModel =
              SleepingRoomHistoryDetailModel.fromJson(responseJson);

          Provider.of<SleepingRoomHistoryDetailsProvider>(context,
                  listen: false)
              .setItem(sleepingRoomHistoryDetailModel);
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
