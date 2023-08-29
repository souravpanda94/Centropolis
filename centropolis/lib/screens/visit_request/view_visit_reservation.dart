import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:centropolis/screens/visit_request/visit_reservation_details.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../models/visit_reservation_model.dart';
import '../../providers/user_provider.dart';
import '../../providers/view_visit_reservation_list_provider.dart';
import '../../providers/visit_reservation_list_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/view_more.dart';

class ViewVisitReservationScreen extends StatefulWidget {
  const ViewVisitReservationScreen({super.key});

  @override
  State<ViewVisitReservationScreen> createState() =>
      _ViewVisitReservationScreenState();
}

class _ViewVisitReservationScreenState
    extends State<ViewVisitReservationScreen> {
  String? currentSelectedSortingFilter;

  // List<dynamic>? sortingList = [
  //   {"value": "", "text": "All"},
  //   {"value": "tenant_employee", "text": "Tenant Employee"},
  //   {"value": "tenant_lounge_employee", "text": "Executive Lounge"},
  //   {"value": "tenant_conference_employee", "text": "Conference Room"}
  // ];

  // List<dynamic> dataList = [
  //   {
  //     "id": 1,
  //     "name": "Hong Gil Dong",
  //     "businessType": "Centropolis",
  //     "type": "business discussion",
  //     "dateTime": "2021.03.21 13:00",
  //     "status": "In Progress"
  //   },
  //   {
  //     "id": 2,
  //     "name": "Hong Gil Dong",
  //     "businessType": "Centropolis",
  //     "type": "business discussion",
  //     "dateTime": "2021.03.21 13:00",
  //     "status": "In Progress"
  //   },
  //   {
  //     "id": 3,
  //     "name": "Hong Gil Dong",
  //     "businessType": "Centropolis",
  //     "type": "business discussion",
  //     "dateTime": "2021.03.21 13:00",
  //     "status": "Approved"
  //   },
  //   {
  //     "id": 4,
  //     "name": "Hong Gil Dong",
  //     "businessType": "Centropolis",
  //     "type": "business discussion",
  //     "dateTime": "2021.03.21 13:00",
  //     "status": "Approved"
  //   },
  //   {
  //     "id": 5,
  //     "name": "Hong Gil Dong",
  //     "businessType": "Centropolis",
  //     "type": "business discussion",
  //     "dateTime": "2021.03.21 13:00",
  //     "status": "Approved"
  //   },
  //   {
  //     "id": 6,
  //     "name": "Hong Gil Dong",
  //     "businessType": "Centropolis",
  //     "type": "business discussion",
  //     "dateTime": "2021.03.21 13:00",
  //     "status": "Rejected"
  //   },
  //   {
  //     "id": 7,
  //     "name": "Hong Gil Dong",
  //     "businessType": "Centropolis",
  //     "type": "business discussion",
  //     "dateTime": "2021.03.21 13:00",
  //     "status": "Rejected"
  //   }
  // ];
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 10;
  int totalPages = 0;
  bool isFirstLoadRunning = true;
  List<VisitReservationModel>? visitReservationListItem;
  List<dynamic>? filteredStatusList;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    loadVisitReservationList();
    debugPrint("apiKey ====> $apiKey");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    visitReservationListItem =
        Provider.of<ViewVisitReservationListProvider>(context)
            .getVisitReservationList;

    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.textColor4,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isFirstLoadRunning,
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        body: visitReservationListItem!.isNotEmpty
            ? SingleChildScrollView(
                child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                      top: 20.0,
                      left: 16,
                      right: 16,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              tr("total"),
                              style: const TextStyle(
                                fontSize: 14,
                                color: CustomColors.textColorBlack2,
                                fontFamily: 'SemiBold',
                              ),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              " ${visitReservationListItem?.length}",
                              style: const TextStyle(
                                fontSize: 14,
                                color: CustomColors.textColor9,
                                fontFamily: 'SemiBold',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                        sortingDropdownWidget()
                      ],
                    ),
                  ),
                  Container(
                      margin: const EdgeInsets.only(
                        left: 16,
                        right: 16,
                      ),
                      child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: visitReservationListItem?.length,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return InkWell(
                              onTap: () {
                                goToDetailsPage(visitReservationListItem![index]
                                    .visitId
                                    .toString());
                              },
                              child: Container(
                                  margin: const EdgeInsets.only(
                                      top: 5.0, bottom: 5.0),
                                  decoration: BoxDecoration(
                                    color: CustomColors.whiteColor,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                        color: CustomColors.borderColor,
                                        width: 1.0),
                                  ),
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            // dataList[index]["name"],
                                            visitReservationListItem?[index]
                                                    .visitorName
                                                    .toString() ??
                                                "",
                                            style: const TextStyle(
                                                fontSize: 14,
                                                fontFamily: "Bold",
                                                color: CustomColors.textColor8),
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: setStatusBackgroundColor(
                                                  visitReservationListItem?[
                                                          index]
                                                      .status
                                                      .toString()),
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            padding: const EdgeInsets.only(
                                                top: 5,
                                                bottom: 5,
                                                left: 10,
                                                right: 10),
                                            child: Text(
                                              // dataList[index]["status"],
                                              visitReservationListItem?[index]
                                                      .displayStatus
                                                      .toString() ??
                                                  "",
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "Bold",
                                                  color: setStatusTextColor(
                                                      visitReservationListItem?[
                                                              index]
                                                          .status
                                                          .toString())),
                                            ),
                                          )
                                        ],
                                      ),
                                      Container(
                                          margin: const EdgeInsets.only(top: 6),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    // dataList[index]["businessType"],
                                                    visitReservationListItem?[
                                                                index]
                                                            .companyName
                                                            .toString() ??
                                                        "",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "Regular",
                                                        color: CustomColors
                                                            .textColorBlack2),
                                                  ),
                                                  const Text(
                                                    "  |  ",
                                                    style: TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "Regular",
                                                        color: CustomColors
                                                            .borderColor),
                                                  ),
                                                  Text(
                                                    // dataList[index]["type"],
                                                    visitReservationListItem?[
                                                                index]
                                                            .visitedPersonCompanyName
                                                            .toString() ??
                                                        "",
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontFamily: "Regular",
                                                        color: CustomColors
                                                            .textColorBlack2),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          )),
                                      Container(
                                          margin: const EdgeInsets.only(top: 6),
                                          child: Row(
                                            children: [
                                              Text(
                                                tr("visitDate"),
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: "Regular",
                                                    color: CustomColors
                                                        .textColor3),
                                              ),
                                              Text(
                                                // dataList[index]["dateTime"],
                                                "${visitReservationListItem?[index].visitDate} ${visitReservationListItem?[index].visitTime}",
                                                style: const TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: "Regular",
                                                    color: CustomColors
                                                        .textColor3),
                                              ),
                                            ],
                                          )),
                                    ],
                                  )));
                        },
                      )),
                  if (page < totalPages)
                    ViewMoreWidget(
                      onViewMoreTap: () {
                        loadMore();
                      },
                    )
                ],
              ))
            : Center(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    tr("noDataFound"),
                    style: const TextStyle(
                        fontSize: 18,
                        fontFamily: "Bold",
                        color: CustomColors.textColor5),
                  ),
                ),
              ),
      ),
    );
  }

  void goToDetailsPage(String visitId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VisitReservationDetailsScreen(visitId),
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
        items: filteredStatusList
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
          loadVisitReservationList();
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

  void loadVisitReservationList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadVisitReservationListApi();
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callLoadVisitReservationListApi() {
    setState(() {
      isFirstLoadRunning = true;
    });
    Map<String, String> body = {
      "page": page.toString(),
      "limit": limit.toString(),
      "pagination": "true",
      "status": currentSelectedSortingFilter ?? ""
    };

    debugPrint("View Visit Request List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getVisitRequestListUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for View Visit Request List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          totalPages = responseJson['total_pages'];
          if (responseJson['filtered_status_list'] != null) {
            setState(() {
              filteredStatusList = responseJson['filtered_status_list'];
            });
          }

          if (responseJson['reservation_data'] != null) {
            List<VisitReservationModel> reservationListList =
                List<VisitReservationModel>.from(
                    responseJson['reservation_data']
                        .map((x) => VisitReservationModel.fromJson(x)));
            if (page == 1) {
              Provider.of<ViewVisitReservationListProvider>(context,
                      listen: false)
                  .setItem(reservationListList);
            } else {
              Provider.of<ViewVisitReservationListProvider>(context,
                      listen: false)
                  .addItem(reservationListList);
            }
          }
        } else {
          if (responseJson['message'] != null) {
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(context: context,
                heading :responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          }
        }
        setState(() {
          isFirstLoadRunning = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(context: context,
          heading: tr("errorDescription"),
          description:"",
          buttonName : tr("check"));
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
      loadVisitReservationList();
    }
  }

  Color setStatusBackgroundColor(String? status) {
    if (status == "approved" ||
        status == "request_for_approval" ||
        status == "visit_completed") {
      return CustomColors.backgroundColor;
    } else if (status == "request_for_approval") {
      return CustomColors.backgroundColor3;
    } else if (status == "rejected") {
      return CustomColors.backgroundColor4;
    } else {
      return CustomColors.backgroundColor;
    }
  }

  Color setStatusTextColor(String? status) {
    if (status == "approved" ||
        status == "request_for_approval" ||
        status == "visit_completed") {
      return CustomColors.textColorBlack2;
    } else if (status == "request_for_approval") {
      return CustomColors.textColor9;
    } else if (status == "rejected") {
      return CustomColors.headingColor;
    } else {
      return CustomColors.backgroundColor;
    }
  }
}
