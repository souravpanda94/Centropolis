import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/paid_locker_history_list_model.dart';
import '../../providers/paid_locker_history_list_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/view_more.dart';
import 'paid_locker_history_details.dart';

class PaidLockerReservationHistory extends StatefulWidget {
  const PaidLockerReservationHistory({super.key});

  @override
  State<PaidLockerReservationHistory> createState() =>
      _PaidLockerReservationHistoryState();
}

class _PaidLockerReservationHistoryState
    extends State<PaidLockerReservationHistory> {
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 10;
  int totalPages = 0;
  int totalRecords = 0;
  bool isFirstLoadRunning = true;
  List<PaidLockerHistoryListModel>? paidLockerHistoryListItem;
  String? currentSelectedSortingFilter;
  List<dynamic>? statusList = [];

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    loadStatusList();
    firstTimeLoadPaidLockerHistoryList();
  }

  @override
  Widget build(BuildContext context) {
    paidLockerHistoryListItem =
        Provider.of<PaidLockerHistoryListProvider>(context)
            .getPaidLockerHistoryList;
    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.whiteColor,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isFirstLoadRunning,
      child: Container(
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
                        paidLockerHistoryListItem?.length.toString() ?? "",
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
                sortingDropdownWidget(),
              ],
            ),
            paidLockerHistoryListItem == null ||
                    paidLockerHistoryListItem!.isEmpty
                ? Expanded(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 20),
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
                  )
                : Expanded(
                    child: ListView.builder(
                        itemCount: paidLockerHistoryListItem?.length,
                        itemBuilder: ((context, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      PaidLockerHistoryDetails(
                                          reservationId:
                                              paidLockerHistoryListItem?[index]
                                                      .id
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
                                      const Text(
                                        //paidLockerHistoryListItem?[index].status.toString() ?? "",
                                        "Locker",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontFamily: 'SemiBold',
                                            fontSize: 14,
                                            color: CustomColors.textColor8),
                                      ),
                                      if (paidLockerHistoryListItem != null &&
                                          paidLockerHistoryListItem![index]
                                              .status
                                              .toString()
                                              .isNotEmpty)
                                        Container(
                                          decoration: BoxDecoration(
                                            color: paidLockerHistoryListItem?[
                                                            index]
                                                        .status
                                                        .toString() ==
                                                    "Before Approval"
                                                ? CustomColors.backgroundColor3
                                                : paidLockerHistoryListItem?[
                                                                index]
                                                            .status
                                                            .toString() ==
                                                        "Approved"
                                                    ? CustomColors
                                                        .backgroundColor
                                                    : paidLockerHistoryListItem?[
                                                                    index]
                                                                .status
                                                                .toString() ==
                                                            "Used"
                                                        ? CustomColors
                                                            .backgroundColor
                                                        : paidLockerHistoryListItem?[
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
                                            paidLockerHistoryListItem?[index]
                                                    .status
                                                    .toString() ??
                                                "",
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontFamily: "SemiBold",
                                              color: paidLockerHistoryListItem?[
                                                              index]
                                                          .status
                                                          .toString() ==
                                                      "Before Approval"
                                                  ? CustomColors.textColor9
                                                  : paidLockerHistoryListItem?[
                                                                  index]
                                                              .status
                                                              .toString() ==
                                                          "Approved"
                                                      ? CustomColors
                                                          .textColorBlack2
                                                      : paidLockerHistoryListItem?[
                                                                      index]
                                                                  .status
                                                                  .toString() ==
                                                              "Used"
                                                          ? CustomColors
                                                              .textColor3
                                                          : paidLockerHistoryListItem?[
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
                                        paidLockerHistoryListItem?[index]
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
                                        paidLockerHistoryListItem?[index]
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
              ),
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
          statusList != null && statusList!.isNotEmpty
              ? statusList?.first["text"]
              : tr('all'),
          style: const TextStyle(
            color: CustomColors.textColor5,
            fontSize: 14,
            fontFamily: 'Regular',
          ),
        ),
        items: statusList
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
          firstTimeLoadPaidLockerHistoryList();
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

  void firstTimeLoadPaidLockerHistoryList() {
    setState(() {
      isFirstLoadRunning = true;
      page = 1;
    });
    Provider.of<PaidLockerHistoryListProvider>(context, listen: false)
        .setEmptyList();
    loadPaidLockerHistoryList();
  }

  void loadPaidLockerHistoryList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callPaidLockerHistoryListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callPaidLockerHistoryListApi() {
    Map<String, String> body = {
      "page": page.toString(),
      "limit": limit.toString(),
      "status": currentSelectedSortingFilter != null &&
              currentSelectedSortingFilter!.isNotEmpty
          ? currentSelectedSortingFilter.toString().trim()
          : "",
    };

    debugPrint("PaidLocker History List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.paidLockerHistoryListUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for PaidLocker History List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          totalPages = responseJson['total_pages'];
          totalRecords = responseJson['total_records'];
          List<PaidLockerHistoryListModel> paidLockerHistoryList =
              List<PaidLockerHistoryListModel>.from(responseJson['inquiry_data']
                  .map((x) => PaidLockerHistoryListModel.fromJson(x)));
          if (page == 1) {
            Provider.of<PaidLockerHistoryListProvider>(context, listen: false)
                .setItem(paidLockerHistoryList);
          } else {
            Provider.of<PaidLockerHistoryListProvider>(context, listen: false)
                .addItem(paidLockerHistoryList);
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
      loadPaidLockerHistoryList();
    }
  }

  void loadStatusList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callStatusListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callStatusListApi() {
    setState(() {
      isFirstLoadRunning = true;
    });
    Map<String, String> body = {};
    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.amenityHistoryStatusUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['data'] != null) {
            setState(() {
              statusList = responseJson['data'];
              Map<dynamic, dynamic> allMap = {"text": tr("all"), "value": ""};
              statusList?.insert(0, allMap);
            });
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
}
