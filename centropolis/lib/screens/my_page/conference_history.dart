import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../models/amenity_history_model.dart';
import '../../providers/conference_history_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/view_more.dart';
import 'conference_history_details.dart';

class ConferenceHistory extends StatefulWidget {
  const ConferenceHistory({super.key});

  @override
  State<ConferenceHistory> createState() => _ConferenceHistoryState();
}

class _ConferenceHistoryState extends State<ConferenceHistory> {
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 10;
  int totalPages = 0;
  int totalRecords = 0;
  bool isFirstLoadRunning = true;
  List<AmenityHistoryModel>? conferenceListItem;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    firstTimeLoadConferenceHistoryList();
  }

  @override
  Widget build(BuildContext context) {
    conferenceListItem = Provider.of<ConferenceHistoryProvider>(context)
        .getConferenceHistoryModelList;

    return LoadingOverlay(
      opacity: 1.0,
      color: CustomColors.whiteColor,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isFirstLoadRunning,
      child: conferenceListItem!.isNotEmpty
          ? Container(
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
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 2),
                            child: Text(
                              totalRecords.toString(),
                              style: const TextStyle(
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
                  Flexible(
                    child: ListView.builder(
                        itemCount: conferenceListItem?.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      ConferenceHistoryDetails(
                                          conferenceListItem?[index]),
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
                                        conferenceListItem?[index].name ?? "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: 'SemiBold',
                                            fontSize: 14,
                                            color: CustomColors.textColor8),
                                      ),
                                      if (conferenceListItem?[index]
                                              .status
                                              .toString() !=
                                          "")
                                        Container(
                                          decoration: BoxDecoration(
                                            color: conferenceListItem?[index]
                                                            .status
                                                            .toString() ==
                                                        "Before Approval" ||
                                                    conferenceListItem?[index]
                                                            .status
                                                            .toString() ==
                                                        "Pending"
                                                ? CustomColors.backgroundColor3
                                                : conferenceListItem?[index]
                                                            .status
                                                            .toString() ==
                                                        "Approved"
                                                    ? CustomColors
                                                        .backgroundColor
                                                    : conferenceListItem?[index]
                                                                .status
                                                                .toString() ==
                                                            "Used"
                                                        ? CustomColors
                                                            .backgroundColor
                                                        : conferenceListItem?[
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
                                            conferenceListItem?[index].status ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "SemiBold",
                                              color: conferenceListItem?[index]
                                                              .status
                                                              .toString() ==
                                                          "Before Approval" ||
                                                      conferenceListItem?[index]
                                                              .status
                                                              .toString() ==
                                                          "Pending"
                                                  ? CustomColors.textColor9
                                                  : conferenceListItem?[index]
                                                              .status
                                                              .toString() ==
                                                          "Approved"
                                                      ? CustomColors
                                                          .textColorBlack2
                                                      : conferenceListItem?[
                                                                      index]
                                                                  .status
                                                                  .toString() ==
                                                              "Used"
                                                          ? CustomColors
                                                              .textColor3
                                                          : conferenceListItem?[
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
                                          // list[index]["date"],
                                          conferenceListItem?[index]
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
                                          tr("participants"),
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
                                          // list[index]["participants"]
                                          "9 participants",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
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
            )
          : Container(
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
            ),
    );
  }

  void firstTimeLoadConferenceHistoryList() {
    setState(() {
      isFirstLoadRunning = true;
    });
    loadConferenceHistoryList();
  }

  void loadConferenceHistoryList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callConferenceHistoryListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callConferenceHistoryListApi() {
    Map<String, String> body = {
      "page": page.toString(),
      "limit": limit.toString()
    };

    debugPrint("Conference History List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getConferenceHistoryListUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for Conference History List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          totalPages = responseJson['total_pages'];
          totalRecords = responseJson['total_records'];
          List<AmenityHistoryModel> executiveLoungeHistoryList =
              List<AmenityHistoryModel>.from(responseJson['inquiry_data']
                  .map((x) => AmenityHistoryModel.fromJson(x)));
          if (page == 1) {
            Provider.of<ConferenceHistoryProvider>(context, listen: false)
                .setItem(executiveLoungeHistoryList);
          } else {
            Provider.of<ConferenceHistoryProvider>(context, listen: false)
                .addItem(executiveLoungeHistoryList);
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
      setState(() {
        isFirstLoadRunning = false;
      });
    });
  }

  void loadMore() {
    debugPrint("page ================> $page");
    debugPrint("totalPages ================> $totalPages");

    if (page < totalPages) {
      debugPrint("load more called");

      setState(() {
        page++;
      });
      loadConferenceHistoryList();
    }
  }
}
