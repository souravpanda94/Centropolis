import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/gx_list_history_model.dart';
import '../../providers/gx_list_history_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/view_more.dart';
import 'gx_history_details.dart';

class GXReservationHistory extends StatefulWidget {
  const GXReservationHistory({super.key});

  @override
  State<GXReservationHistory> createState() => _GXReservationHistoryState();
}

class _GXReservationHistoryState extends State<GXReservationHistory> {
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 10;
  int totalPages = 0;
  int totalRecords = 0;
  bool isFirstLoadRunning = true;
  List<GXListHistoryModel>? gxHistoryListItem;
  String? currentSelectedSortingFilter;
  // For dropdown list attaching
  List<dynamic>? sortingList = [
    {"value": "", "text": "All"},
    {"value": "tenant_employee", "text": "Tenant Employee"},
    {"value": "tenant_lounge_employee", "text": "Executive Lounge"},
    {"value": "tenant_conference_employee", "text": "Conference Room"}
  ];

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    firstTimeLoadGXHistoryList();
  }

  // List<dynamic> list = [
  //   {
  //     "title": "YOGA CLASS",
  //     "type": "Before Approval",
  //     "startDate": "2023.00.00",
  //     "endDate": "2023-00-00"
  //   },
  //   {
  //     "title": "YOGA CLASS",
  //     "type": "Approved",
  //     "startDate": "2023.00.00",
  //     "endDate": "2023-00-00"
  //   },
  //   {
  //     "title": "YOGA CLASS",
  //     "type": "Before Approval",
  //     "startDate": "2023.00.00",
  //     "endDate": "2023-00-00"
  //   },
  //   {
  //     "title": "CORE TRAINING & STRETCHING",
  //     "type": "Before Approval",
  //     "startDate": "2023.00.00",
  //     "endDate": "2023-00-00"
  //   },
  //   {
  //     "title": "JUST 10 MINUTES",
  //     "type": "Approved",
  //     "startDate": "2023.00.00",
  //     "endDate": "2023-00-00"
  //   },
  //   {
  //     "title": "CORE TRAINING & STRETCHING",
  //     "type": "Approved",
  //     "startDate": "2023.00.00",
  //     "endDate": "2023-00-00"
  //   },
  //   {
  //     "title": "YOGA CLASS",
  //     "type": "Rejected",
  //     "startDate": "2023.00.00",
  //     "endDate": "2023-00-00"
  //   },
  //   {
  //     "title": "JUST 10 MINUTES",
  //     "type": "Used",
  //     "startDate": "2023.00.00",
  //     "endDate": "2023-00-00"
  //   },
  //   {
  //     "title": "CORE TRAINING & STRETCHING",
  //     "type": "Rejected",
  //     "startDate": "2023.00.00",
  //     "endDate": "2023-00-00"
  //   },
  //   {
  //     "title": "YOGA CLASS",
  //     "type": "Before Approval",
  //     "startDate": "2023.00.00",
  //     "endDate": "2023-00-00"
  //   },
  //   {
  //     "title": "CORE TRAINING & STRETCHING",
  //     "type": "Used",
  //     "startDate": "2023.00.00",
  //     "endDate": "2023-00-00"
  //   },
  // ];

  @override
  Widget build(BuildContext context) {
    gxHistoryListItem =
        Provider.of<GxListHistoryProvider>(context).getGxHistoryList;

    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.whiteColor,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isFirstLoadRunning,
      child: gxHistoryListItem == null || gxHistoryListItem!.isEmpty
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
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.only(left: 16, right: 16, top: 20),
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
                              gxHistoryListItem?.length.toString() ?? "",
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
                      sortingDropdownWidget()
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                        itemCount: gxHistoryListItem?.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GXHistoryDetails(
                                      type: gxHistoryListItem?[index]
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
                                      Expanded(
                                        child: Text(
                                          gxHistoryListItem?[index]
                                                  .title
                                                  .toString() ??
                                              "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'SemiBold',
                                              fontSize: 14,
                                              color: CustomColors.textColor8),
                                        ),
                                      ),
                                      if (gxHistoryListItem != null &&
                                          gxHistoryListItem![index]
                                              .status
                                              .toString()
                                              .isNotEmpty)
                                        Container(
                                          decoration: BoxDecoration(
                                            color: gxHistoryListItem?[index]
                                                            .status
                                                            .toString() ==
                                                        "Before Approval" ||
                                                    gxHistoryListItem?[index]
                                                            .status
                                                            .toString() ==
                                                        "Before Use"
                                                ? CustomColors.backgroundColor3
                                                : gxHistoryListItem?[index]
                                                            .status
                                                            .toString()
                                                            .toString() ==
                                                        "Approved"
                                                    ? CustomColors
                                                        .backgroundColor
                                                    : gxHistoryListItem?[index]
                                                                .status
                                                                .toString()
                                                                .toString() ==
                                                            "Used"
                                                        ? CustomColors
                                                            .backgroundColor
                                                        : gxHistoryListItem?[
                                                                        index]
                                                                    .status
                                                                    .toString() ==
                                                                "Rejected"
                                                            ? CustomColors
                                                                .redColor
                                                            : CustomColors
                                                                .backgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          padding: const EdgeInsets.only(
                                              top: 5.0,
                                              bottom: 5.0,
                                              left: 10.0,
                                              right: 10.0),
                                          child: Text(
                                            gxHistoryListItem?[index]
                                                    .status
                                                    .toString() ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "SemiBold",
                                              color: gxHistoryListItem?[index]
                                                              .status
                                                              .toString() ==
                                                          "Before Approval" ||
                                                      gxHistoryListItem?[index]
                                                              .status
                                                              .toString() ==
                                                          "Before Use"
                                                  ? CustomColors.textColor9
                                                  : gxHistoryListItem?[index]
                                                              .status
                                                              .toString() ==
                                                          "Approved"
                                                      ? CustomColors
                                                          .textColorBlack2
                                                      : gxHistoryListItem?[
                                                                      index]
                                                                  .status
                                                                  .toString() ==
                                                              "Used"
                                                          ? CustomColors
                                                              .textColor3
                                                          : gxHistoryListItem?[
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
                                  Row(
                                    children: [
                                      Text(
                                        gxHistoryListItem?[index]
                                                .startDate
                                                .toString() ??
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
                                        gxHistoryListItem?[index]
                                                .endDate
                                                .toString() ??
                                            "",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                            fontFamily: 'Regular',
                                            fontSize: 12,
                                            color: CustomColors.textColor3),
                                      ),
                                    ],
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

  sortingDropdownWidget() {
    return DropdownButtonHideUnderline(
      child: DropdownButton2(
        alignment: AlignmentDirectional.centerEnd,
        hint: Text(
          tr('all'),
          style: const TextStyle(
            color: CustomColors.textColor5,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: sortingList
            ?.map(
              (item) => DropdownMenuItem<String>(
                value: item["value"],
                child: Text(
                  item["text"],
                  style: const TextStyle(
                    color: CustomColors.textColor5,
                    fontSize: 12,
                    fontFamily: 'SemiBold',
                  ),
                ),
              ),
            )
            .toList(),
        value: currentSelectedSortingFilter,
        onChanged: (value) {
          setState(() {
            currentSelectedSortingFilter = value as String;
          });

          //call API for sorting
          //loadEmployeeList();
        },
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          isOverButton: false,
          elevation: 0,
          decoration: BoxDecoration(
              color: CustomColors.whiteColor,
              border: Border.all(color: CustomColors.borderColor, width: 1)),
        ),
        iconStyleData: IconStyleData(
            icon: Padding(
          padding: EdgeInsets.only(
              bottom: currentSelectedSortingFilter != null ? 6 : 0,
              top: currentSelectedSortingFilter != null ? 6 : 0,
              left: 0),
          child: SvgPicture.asset(
            "assets/images/ic_drop_down_arrow.svg",
            width: 8,
            height: 8,
            color: CustomColors.textColorBlack2,
          ),
        )),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.only(left: 16, top: 16, bottom: 16),
        ),
      ),
    );
  }

  void firstTimeLoadGXHistoryList() {
    setState(() {
      isFirstLoadRunning = true;
    });
    loadGXHistoryList();
  }

  void loadGXHistoryList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callGXHistoryListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callGXHistoryListApi() {
    Map<String, String> body = {
      "page": page.toString(),
      "limit": limit.toString()
    };

    debugPrint("gx History List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.gxHistoryListUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for gx History List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          totalPages = responseJson['total_pages'];
          totalRecords = responseJson['total_records'];
          List<GXListHistoryModel> gxHistoryList =
              List<GXListHistoryModel>.from(responseJson['inquiry_data']
                  .map((x) => GXListHistoryModel.fromJson(x)));
          if (page == 1) {
            Provider.of<GxListHistoryProvider>(context, listen: false)
                .setItem(gxHistoryList);
          } else {
            Provider.of<GxListHistoryProvider>(context, listen: false)
                .addItem(gxHistoryList);
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
    debugPrint("page ================> $page");
    debugPrint("totalPages ================> $totalPages");

    if (page < totalPages) {
      debugPrint("load more called");

      setState(() {
        page++;
      });
      loadGXHistoryList();
    }
  }
}
