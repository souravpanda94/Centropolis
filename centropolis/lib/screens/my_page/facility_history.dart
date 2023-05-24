import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/sleeping_room_history_model.dart';
import '../../providers/sleeping_room_history_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/view_more.dart';
import 'facility_history_details.dart';

class FacilityHistory extends StatefulWidget {
  const FacilityHistory({super.key});

  @override
  State<FacilityHistory> createState() => _FacilityHistoryState();
}

class _FacilityHistoryState extends State<FacilityHistory> {
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 10;
  int totalPages = 0;
  int totalRecords = 0;
  bool isFirstLoadRunning = true;
  List<SleepingRoomHistoryModel>? sleepingRoomHistoryItem;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    firstTimeLoadSleepingRoomHistoryList();
  }

  @override
  Widget build(BuildContext context) {
    sleepingRoomHistoryItem = Provider.of<SleepingRoomHistoryProvider>(context)
        .getSleepingHistoryModelList;

    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.whiteColor,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isFirstLoadRunning,
      child: sleepingRoomHistoryItem!.isEmpty
          ? Container(
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              padding: const EdgeInsets.all(24),
              child: Text(
                tr("noReservationHistory"),
                textAlign: TextAlign.center,
                style: const TextStyle(
                    fontFamily: 'Regular',
                    fontSize: 14,
                    color: CustomColors.textColor5),
              ),
            )
          : Container(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 33),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            tr("total"),
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: Text(
                              "38",
                              style: TextStyle(
                                  fontFamily: 'Regular',
                                  fontSize: 14,
                                  color: CustomColors.textColor9),
                            ),
                          ),
                          Text(
                            tr("items"),
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            tr("all"),
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColor5),
                          ),
                          const SizedBox(
                            width: 11,
                          ),
                          SvgPicture.asset(
                              "assets/images/ic_drop_down_arrow.svg",
                              color: CustomColors.textColor5)
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 9,
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: sleepingRoomHistoryItem?.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => FacilityHistoryDetails(
                                      id: sleepingRoomHistoryItem![index]
                                          .reservationId
                                          .toString()),
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: CustomColors.whiteColor,
                                  border: Border.all(
                                    color: CustomColors.borderColor,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(4))),
                              padding: const EdgeInsets.all(16),
                              margin: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        sleepingRoomHistoryItem![index].name ??
                                            "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: 'SemiBold',
                                            fontSize: 14,
                                            color: CustomColors.textColor8),
                                      ),
                                      if (sleepingRoomHistoryItem![index]
                                          .status
                                          .toString()
                                          .isNotEmpty)
                                        Container(
                                          decoration: BoxDecoration(
                                            color: sleepingRoomHistoryItem![
                                                                index]
                                                            .status
                                                            .toString() ==
                                                        "Before Approval" ||
                                                    sleepingRoomHistoryItem![
                                                                index]
                                                            .status
                                                            .toString() ==
                                                        "Before Use"
                                                ? CustomColors.backgroundColor3
                                                : sleepingRoomHistoryItem![
                                                                index]
                                                            .status
                                                            .toString() ==
                                                        "Approved"
                                                    ? CustomColors
                                                        .backgroundColor
                                                    : sleepingRoomHistoryItem![
                                                                    index]
                                                                .status
                                                                .toString() ==
                                                            "Used"
                                                        ? CustomColors
                                                            .backgroundColor
                                                        : sleepingRoomHistoryItem![
                                                                        index]
                                                                    .status
                                                                    .toString() ==
                                                                "Rejected"
                                                            ? CustomColors
                                                                .redColor
                                                            : CustomColors
                                                                .textColorBlack2,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          padding: const EdgeInsets.only(
                                              top: 5.0,
                                              bottom: 5.0,
                                              left: 10.0,
                                              right: 10.0),
                                          child: Text(
                                            sleepingRoomHistoryItem![index]
                                                    .status ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "SemiBold",
                                              color: sleepingRoomHistoryItem![
                                                                  index]
                                                              .status
                                                              .toString() ==
                                                          "Before Approval" ||
                                                      sleepingRoomHistoryItem![
                                                                  index]
                                                              .status
                                                              .toString() ==
                                                          "Before Use"
                                                  ? CustomColors.textColor9
                                                  : sleepingRoomHistoryItem![
                                                                  index]
                                                              .status
                                                              .toString() ==
                                                          "Approved"
                                                      ? CustomColors
                                                          .textColorBlack2
                                                      : sleepingRoomHistoryItem![
                                                                      index]
                                                                  .status
                                                                  .toString() ==
                                                              "Used"
                                                          ? CustomColors
                                                              .textColor3
                                                          : sleepingRoomHistoryItem![
                                                                          index]
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
                                    height: 18,
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                      children: [
                                        Text(
                                          sleepingRoomHistoryItem![index]
                                                  .reservationDate ??
                                              "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 12,
                                              color: CustomColors.textColor3),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const VerticalDivider(
                                          thickness: 1,
                                          color: CustomColors.borderColor,
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          sleepingRoomHistoryItem![index]
                                                  .usageTime ??
                                              "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 12,
                                              color: CustomColors.textColor3),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        const Text(
                                          "~",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 12,
                                              color: CustomColors.textColor3),
                                        ),
                                        const SizedBox(
                                          width: 8,
                                        ),
                                        Text(
                                          sleepingRoomHistoryItem![index]
                                                  .usageHours ??
                                              "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 12,
                                              color: CustomColors.textColor3),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
                  ),
                  if (page < totalPages)
                    ViewMoreWidget(
                      onViewMoreTap: () {
                        loadMore();
                      },
                    )
                ],
              ),
            ),
    );
  }

  void firstTimeLoadSleepingRoomHistoryList() {
    setState(() {
      isFirstLoadRunning = true;
    });
    loadSleepingRoomHistoryList();
  }

  void loadSleepingRoomHistoryList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callSleepingRoomHistoryListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callSleepingRoomHistoryListApi() {
    Map<String, String> body = {
      "page": page.toString(),
      "limit": limit.toString()
    };

    debugPrint("SleepingRoom History List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getSleepingRoomHistoryListUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for SleepingRoom History List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          totalPages = responseJson['total_pages'];
          totalRecords = responseJson['total_records'];
          List<SleepingRoomHistoryModel> sleepingRoomHistoryList =
              List<SleepingRoomHistoryModel>.from(responseJson['inquiry_data']
                  .map((x) => SleepingRoomHistoryModel.fromJson(x)));
          if (page == 1) {
            Provider.of<SleepingRoomHistoryProvider>(context, listen: false)
                .setItem(sleepingRoomHistoryList);
          } else {
            Provider.of<SleepingRoomHistoryProvider>(context, listen: false)
                .addItem(sleepingRoomHistoryList);
          }
        } else {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
        setState(() {
          isFirstLoadRunning = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      if (mounted) {
        setState(() {
          isFirstLoadRunning = false;
        });
      }
    });
  }

  void loadMore() {
    if (page < totalPages) {
      setState(() {
        page++;
      });
      loadSleepingRoomHistoryList();
    }
  }
}
