import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/air_conditioning_list_model.dart';
import '../../providers/air_conditioning_list_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/view_more.dart';
import 'air_conditioning_details.dart';

class AirConditioningList extends StatefulWidget {
  const AirConditioningList({super.key});

  @override
  State<AirConditioningList> createState() => _AirConditioningListState();
}

class _AirConditioningListState extends State<AirConditioningList> {
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 10;
  int totalPages = 0;
  int totalRecords = 0;
  bool isFirstLoadRunning = true;
  List<AirConditioningListModel>? airConditioningListItem;
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
    internetCheckingForMethods();
  }

  void internetCheckingForMethods() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callStatusListApi();
      firstTimeLoadAirConditioningList();

    } else {
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }


  @override
  Widget build(BuildContext context) {
    airConditioningListItem = Provider.of<AirConditioningListProvider>(context)
        .getairConditioningModelList;

    return WillPopScope(
      onWillPop: () async {
           Navigator.pop(context, true);
          return true;
        },
      child: LoadingOverlay(
        opacity: 0.5,
        color: CustomColors.whiteColor,
        progressIndicator: const CircularProgressIndicator(
          color: CustomColors.blackColor,
        ),
        isLoading: isFirstLoadRunning,
        child: Scaffold(
          backgroundColor: CustomColors.whiteColor,
          appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: SafeArea(
              child: Container(
                color: CustomColors.whiteColor,
                child: CommonAppBar(tr("coolingHeatingListTitle"), false, () {
                  //onBackButtonPress(context);
                  Navigator.pop(context, true);
                }, () {}),
              ),
            ),
          ),
          body: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
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
                              fontFamily: 'Medium',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          child: Text(
                            totalRecords.toString(),
                            style: const TextStyle(
                                fontFamily: 'Medium',
                                fontSize: 14,
                                color: CustomColors.textColor9),
                          ),
                        ),
                        Text(
                          tr("items"),
                          style: const TextStyle(
                              fontFamily: 'Medium',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                      ],
                    ),
                    sortingDropdownWidget(),
                  ],
                ),
                airConditioningListItem == null ||
                        airConditioningListItem!.isEmpty
                    ? Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 20),
                          padding: const EdgeInsets.all(24),
                          child: Text(
                            tr("airConditioningEmptyText"),
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
                            itemCount: airConditioningListItem?.length,
                            itemBuilder: ((context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          AirConditioningDetails(
                                              inquiryId:
                                                  airConditioningListItem?[index]
                                                          .inquiryId
                                                          .toString() ??
                                                      "",
                                              fromPage: "VOC"),
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
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.circle,
                                            size: 8,
                                            color: airConditioningListItem?[index]
                                                        .type
                                                        .toString()
                                                        .toLowerCase() ==
                                                    "heating"
                                                ? CustomColors.headingColor
                                                : CustomColors.coolingColor,
                                          ),
                                          const SizedBox(
                                            width: 4,
                                          ),
                                          Text(
                                            airConditioningListItem?[index]
                                                    .displayType
                                                    .toString()
                                                    .capitalize() ??
                                                "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontFamily: 'SemiBold',
                                                fontSize: 12,
                                                color:
                                                    CustomColors.textColorBlack2),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              airConditioningListItem?[index]
                                                      .description
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
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          if (airConditioningListItem != null &&
                                              airConditioningListItem![index]
                                                  .status
                                                  .toString()
                                                  .isNotEmpty)
                                            Container(
                                              decoration: BoxDecoration(
                                                color: setStatusBackgroundColor(
                                                    airConditioningListItem?[
                                                            index]
                                                        .status
                                                        .toString()
                                                        .toLowerCase()),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              padding: const EdgeInsets.only(
                                                  top: 5.0,
                                                  bottom: 5.0,
                                                  left: 10.0,
                                                  right: 10.0),
                                              child: Text(
                                                airConditioningListItem?[index]
                                                        .displayStatus
                                                        .toString() ??
                                                    "",
                                                style: TextStyle(
                                                  fontSize: 12,
                                                  fontFamily: "SemiBold",
                                                  color: setStatusTextColor(
                                                      airConditioningListItem?[
                                                              index]
                                                          .status
                                                          .toString()
                                                          .toLowerCase()),
                                                ),
                                              ),
                                            ),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      IntrinsicHeight(
                                        child: Row(
                                          children: [
                                            Flexible(
                                              child: Text(
                                                airConditioningListItem?[index]
                                                        .requestedFloors
                                                        .toString()
                                                        .toUpperCase() ??
                                                    "",
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: const TextStyle(
                                                    fontFamily: 'Regular',
                                                    fontSize: 12,
                                                    color: CustomColors.textColor3),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            const Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 2),
                                              child: VerticalDivider(
                                                thickness: 1,
                                                color: CustomColors.borderColor,
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Text(
                                              "${airConditioningListItem?[index].registeredDate.toString() ?? ""} ${airConditioningListItem?[index].startTime.toString() ?? ""}",
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
        ),
      ),
    );
  }

  void firstTimeLoadAirConditioningList() {
    setState(() {
      isFirstLoadRunning = true;
      page = 1;
    });
    Provider.of<AirConditioningListProvider>(context, listen: false)
        .setEmptyList();
    loadAirConditioningList();
  }

  void loadAirConditioningList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callAirConditioningListApi();
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callAirConditioningListApi() {
    setState(() {
      isFirstLoadRunning = true;
    });
    Map<String, String> body = {
      "page": page.toString(),
      "limit": limit.toString(),
      "status": currentSelectedSortingFilter != null &&
              currentSelectedSortingFilter!.isNotEmpty
          ? currentSelectedSortingFilter.toString().trim()
          : "",
    };

    debugPrint("AirConditioning List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getAirConditioningListUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for AirConditioning List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          totalPages = responseJson['total_pages'];
          totalRecords = responseJson['total_records'];
          List<AirConditioningListModel> airConditioningList =
              List<AirConditioningListModel>.from(responseJson['inquiry_data']
                  .map((x) => AirConditioningListModel.fromJson(x)));
          if (page == 1) {
            Provider.of<AirConditioningListProvider>(context, listen: false)
                .setItem(airConditioningList);
          } else {
            Provider.of<AirConditioningListProvider>(context, listen: false)
                .addItem(airConditioningList);
          }
        } else {
          if (responseJson['message'] != null) {
            // showCustomToast(fToast, context, responseJson['message'].toString(), "");
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
      loadAirConditioningList();
    }
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
            fontFamily: 'Medium',
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

          firstTimeLoadAirConditioningList();
        },
        dropdownStyleData: DropdownStyleData(
          offset: const Offset(100, 0),
          //maxHeight: 200,
          width: 150,
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
              left: 8),
          child: SvgPicture.asset(
            "assets/images/ic_drop_down_arrow.svg",
            width: 6,
            height: 6,
            color: CustomColors.textColorBlack2,
          ),
        )),
        buttonStyleData: const ButtonStyleData(height: 35),
        menuItemStyleData: const MenuItemStyleData(
          overlayColor:
              MaterialStatePropertyAll(CustomColors.dropdownHoverColor),
          padding: EdgeInsets.only(left: 16, top: 8, bottom: 8),
        ),
      ),
    );
  }

  // void loadStatusList() async {
  //   final InternetChecking internetChecking = InternetChecking();
  //   if (await internetChecking.isInternet()) {
  //     callStatusListApi();
  //   } else {
  //     showCustomToast(fToast, context, tr("noInternetConnection"), "");
  //   }
  // }

  void callStatusListApi() {
    setState(() {
      isFirstLoadRunning = true;
    });
    Map<String, String> body = {};
    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.lightOutCoolingHeatingStatusUrl,
        body,
        language.toString(),
        apiKey);
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
            // showCustomToast(fToast, context, responseJson['message'].toString(), "");
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

  Color setStatusBackgroundColor(String? status) {
    if (status == "rejected") {
      return CustomColors.backgroundColor3;
    } else {
      return CustomColors.backgroundColor;
    }
  }

  Color setStatusTextColor(String? status) {
    if (status == "rejected") {
      return CustomColors.textColor9;
    } else {
      return CustomColors.textColorBlack2;
    }
  }
}
