import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../models/executive_lounge_history_model.dart';
import '../../providers/executive_lounge_history_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/app_loading.dart';
import '../../widgets/view_more.dart';
import 'lounge_history_details.dart';

class LoungeHistory extends StatefulWidget {
  const LoungeHistory({super.key});

  @override
  State<LoungeHistory> createState() => _LoungeHistoryState();
}

class _LoungeHistoryState extends State<LoungeHistory> {
  // List<dynamic> list = [
  //   {
  //     "name": "Hong Gil Dong",
  //     "type": "Before Approval",
  //     "date": "2023.00.00",
  //     "interval": "Afternoon 14:00 ~ 18:00 (4 hours)"
  //   },
  //   {
  //     "name": "Hong Gil Dong",
  //     "type": "Before Approval",
  //     "date": "2023.00.00",
  //     "interval": "All day 9:00 ~ 18:00 (9 hours)"
  //   },
  //   {
  //     "name": "Hong Gil Dong",
  //     "type": "Before Approval",
  //     "date": "2023.00.00",
  //     "interval": "AM 9:00 ~ 13:00 (4 hours)"
  //   },
  //   {
  //     "name": "Hong Gil Dong",
  //     "type": "Approved",
  //     "date": "2023.00.00",
  //     "interval": "14:00 ~ 18:00"
  //   },
  //   {
  //     "name": "Hong Gil Dong",
  //     "type": "Used",
  //     "date": "2023.00.00",
  //     "interval": "14:00 ~ 18:00)"
  //   },
  //   {
  //     "name": "Hong Gil Dong",
  //     "type": "Approved",
  //     "date": "2023.00.00",
  //     "interval": "14:00 ~ 18:00"
  //   },
  //   {
  //     "name": "Hong Gil Dong",
  //     "type": "Rejected",
  //     "date": "2023.00.00",
  //     "interval": "Afternoon 14:00 ~ 18:00 (4 hours)"
  //   },
  //   {
  //     "name": "Hong Gil Dong",
  //     "type": "Used",
  //     "date": "2023.00.00",
  //     "interval": "Afternoon 14:00 ~ 18:00 (4 hours)"
  //   },
  //   {
  //     "name": "Hong Gil Dong",
  //     "type": "Used",
  //     "date": "2023.00.00",
  //     "interval": "Afternoon 14:00 ~ 18:00 (4 hours)"
  //   },
  //   {
  //     "name": "Hong Gil Dong",
  //     "type": "Used",
  //     "date": "2023.00.00",
  //     "interval": "Afternoon 14:00 ~ 18:00 (4 hours)"
  //   },
  //   {
  //     "name": "Hong Gil Dong",
  //     "type": "Used",
  //     "date": "2023.00.00",
  //     "interval": "Afternoon 14:00 ~ 18:00 (4 hours)"
  //   },
  //   {
  //     "name": "Hong Gil Dong",
  //     "type": "Rejected",
  //     "date": "2023.00.00",
  //     "interval": "Afternoon 14:00 ~ 18:00 (4 hours)"
  //   },
  //   {
  //     "name": "Hong Gil Dong",
  //     "type": "Approved",
  //     "date": "2023.00.00",
  //     "interval": "Afternoon 14:00 ~ 18:00 (4 hours)"
  //   },
  // ];

  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 10;
  int totalPages = 0;
  bool isFirstLoadRunning = true;
  bool isLoadMoreRunning = false;
  ScrollController? scrollController;
  List<ExecutiveLoungeHistoryModel>? executiveLoungeListItem;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    scrollController = ScrollController()..addListener(loadMore);
    firstTimeLoadLoungeHistoryList();
  }

  @override
  Widget build(BuildContext context) {
    executiveLoungeListItem =
        Provider.of<ExecutiveLoungeHistoryProvider>(context)
            .getGxFitnessReservationList;

    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.textColor4,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isFirstLoadRunning,
      child: executiveLoungeListItem!.isNotEmpty
          ? SingleChildScrollView(
              child: Container(
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
                    ListView.builder(
                        controller: scrollController,
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: executiveLoungeListItem?.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () {
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => LoungeHistoryDetails(
                              //         type: list[index]["type"].toString()),
                              //   ),
                              // );
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
                                        // list[index]["name"],
                                        executiveLoungeListItem?[index].name ??
                                            "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: 'SemiBold',
                                            fontSize: 14,
                                            color: CustomColors.textColor8),
                                      ),
                                      if (executiveLoungeListItem?[index]
                                              .status
                                              .toString() !=
                                          "")
                                        Container(
                                          decoration: BoxDecoration(
                                            color: executiveLoungeListItem?[
                                                            index]
                                                        .status
                                                        .toString() ==
                                                    "Before Use"
                                                // "Before Approval"
                                                ? CustomColors.backgroundColor3
                                                : executiveLoungeListItem?[
                                                                index]
                                                            .status
                                                            .toString() ==
                                                        "Approved"
                                                    ? CustomColors
                                                        .backgroundColor
                                                    : executiveLoungeListItem?[
                                                                    index]
                                                                .status
                                                                .toString() ==
                                                            "Used"
                                                        ? CustomColors
                                                            .backgroundColor
                                                        : executiveLoungeListItem?[
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
                                            // list[index]["type"],
                                            executiveLoungeListItem?[index]
                                                    .status ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "SemiBold",
                                              color: executiveLoungeListItem?[
                                                              index]
                                                          .status
                                                          .toString() ==
                                                      // "Before Approval"
                                                      "Before Use"
                                                  ? CustomColors.textColor9
                                                  : executiveLoungeListItem?[
                                                                  index]
                                                              .status
                                                              .toString() ==
                                                          "Approved"
                                                      ? CustomColors
                                                          .textColorBlack2
                                                      : executiveLoungeListItem?[
                                                                      index]
                                                                  .status
                                                                  .toString() ==
                                                              "Used"
                                                          ? CustomColors
                                                              .textColor3
                                                          : executiveLoungeListItem?[
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
                                          executiveLoungeListItem?[index]
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
                                          // list[index]["interval"],
                                          executiveLoungeListItem?[index]
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

                    // if (isLoadMoreRunning) const ViewMoreWidget()
                    if (isLoadMoreRunning) const AppLoading()
                  ],
                ),
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

  void firstTimeLoadLoungeHistoryList() {
    setState(() {
      isFirstLoadRunning = true;
    });
    loadLoungeHistoryList();
  }

  void loadLoungeHistoryList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoungeHistoryListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callLoungeHistoryListApi() {
    Map<String, String> body = {
      "page": page.toString(),
      "limit": limit.toString()
    };

    debugPrint("Lounge History List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getLoungeHistoryListUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Lounge History List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          totalPages = responseJson['total_pages'];
          List<ExecutiveLoungeHistoryModel> executiveLoungeHistoryList =
              List<ExecutiveLoungeHistoryModel>.from(
                  responseJson['executive_lounge_data']
                      .map((x) => ExecutiveLoungeHistoryModel.fromJson(x)));
          if (page == 1) {
            Provider.of<ExecutiveLoungeHistoryProvider>(context, listen: false)
                .setItem(executiveLoungeHistoryList);
          } else {
            Provider.of<ExecutiveLoungeHistoryProvider>(context, listen: false)
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
          isLoadMoreRunning = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isFirstLoadRunning = false;
        isLoadMoreRunning = false;
      });
    });
  }

  void loadMore() {
    if (scrollController?.position.maxScrollExtent ==
            scrollController?.offset &&
        (scrollController?.position.extentAfter)! < 500) {
      if (page < totalPages) {
        debugPrint("load more called");

        setState(() {
          isLoadMoreRunning = true;
          page++;
        });
        loadLoungeHistoryList();
      }
    }
  }
}
