import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
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
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 10;
  int totalPages = 0;
  int totalRecords = 0;
  bool isFirstLoadRunning = true;
  List<ExecutiveLoungeHistoryModel>? executiveLoungeListItem;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    firstTimeLoadLoungeHistoryList();
  }

  @override
  Widget build(BuildContext context) {
    executiveLoungeListItem =
        Provider.of<ExecutiveLoungeHistoryProvider>(context)
            .getGxFitnessReservationList;

    return LoadingOverlay(
      opacity: 1.0,
      color: CustomColors.whiteColor,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isFirstLoadRunning,
      child: executiveLoungeListItem!.isNotEmpty
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
                        // controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: executiveLoungeListItem?.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoungeHistoryDetails(
                                      type: executiveLoungeListItem?[index]
                                              .status
                                              .toString() ??
                                          ""),
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
                                                    "before_use"
                                                // "Before Approval"
                                                ? CustomColors.backgroundColor3
                                                : executiveLoungeListItem?[
                                                                index]
                                                            .status
                                                            .toString() ==
                                                        "using"
                                                    ? CustomColors
                                                        .backgroundColor
                                                    : executiveLoungeListItem?[
                                                                    index]
                                                                .status
                                                                .toString() ==
                                                            "used"
                                                        ? CustomColors
                                                            .backgroundColor
                                                        : executiveLoungeListItem?[
                                                                        index]
                                                                    .status
                                                                    .toString() ==
                                                                "rejected"
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
                                                    .displayStatus ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "SemiBold",
                                              color: executiveLoungeListItem?[
                                                              index]
                                                          .status
                                                          .toString() ==
                                                      // "Before Approval"
                                                      "before_use"
                                                  ? CustomColors.textColor9
                                                  : executiveLoungeListItem?[
                                                                  index]
                                                              .status
                                                              .toString() ==
                                                          "using"
                                                      ? CustomColors
                                                          .textColorBlack2
                                                      : executiveLoungeListItem?[
                                                                      index]
                                                                  .status
                                                                  .toString() ==
                                                              "used"
                                                          ? CustomColors
                                                              .textColor3
                                                          : executiveLoungeListItem?[
                                                                          index]
                                                                      .status
                                                                      .toString() ==
                                                                  "rejected"
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
                  ),

                  if (page < totalPages)
                    ViewMoreWidget(
                      onViewMoreTap: () {
                        loadMore();
                      },
                    )
                  // if (isLoadMoreRunning) const AppLoading()
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
          totalRecords = responseJson['total_records'];
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
      loadLoungeHistoryList();
    }
  }
}
