import 'dart:convert';
import 'package:centropolis/screens/voc/light_out_details.dart';
import 'package:centropolis/utils/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../models/air_conditioning_list_model.dart';
import '../models/inconvenience_list_model.dart';
import '../models/light_out_list_model.dart';
import '../providers/incovenience_list_provider.dart';
import '../providers/user_provider.dart';
import '../screens/voc/air_conditioning_details.dart';
import '../screens/voc/inconvenience_details.dart';
import '../../utils/utils.dart';
import '../services/api_service.dart';
import '../utils/custom_urls.dart';
import '../utils/internet_checking.dart';

class VocCommonHome extends StatefulWidget {
  final String image;
  final String title;
  final String subTitle;
  final String emptyTxt;
  final String category;
  final Function onDrawerClick;
  final List<IncovenienceListModel>? inconvenienceList;
  final List<LightOutListModel>? lightoutList;
  final List<AirConditioningListModel>? airConditioningList;
  const VocCommonHome({
    super.key,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.emptyTxt,
    required this.onDrawerClick,
    required this.category,
    this.inconvenienceList,
    this.lightoutList,
    this.airConditioningList,
  });

  @override
  State<VocCommonHome> createState() => _VocCommonHomeState();
}

class _VocCommonHomeState extends State<VocCommonHome> {
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 3;
  int totalPages = 3;
  int totalRecords = 3;
  bool isFirstLoadRunning = true;
  List<IncovenienceListModel>? incovenienceListItem;
  bool isFromDetail = false;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    firstTimeLoadInconvenienceList();
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("isFromDetail ::: $isFromDetail");
    if (isFromDetail) {
      incovenienceListItem = Provider.of<InconvenienceListProvider>(context)
          .getInconvenienceModelList;
    } else {
      incovenienceListItem = widget.inconvenienceList;
    }

    return InkWell(
      onTap: () {
//onPressed.call();
      },
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Image.asset(
                widget.image,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width,
                height: 318,
              ),
              Container(
                margin: const EdgeInsets.only(top: 20, left: 15),
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(top: 2),
                child: Text(
                  widget.title,
                  style: const TextStyle(
                      fontFamily: 'SemiBold',
                      fontSize: 14,
                      color: CustomColors.textColor9),
                ),
              ),
              Container(
//height: 62,
                margin: const EdgeInsets.only(top: 8, left: 15, right: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 0, right: 8),
                        child: Text(
                          widget.subTitle,
                          maxLines: 2,
                          style: const TextStyle(
                              fontFamily: 'SemiBold',
                              fontSize: 22,
                              color: CustomColors.textColorBlack2),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        widget.onDrawerClick();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 3),
                        child: SizedBox(
                          child: SvgPicture.asset(
                            'assets/images/ic_list.svg',
                            semanticsLabel: 'Back',
                            width: 20,
                            height: 20,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              incovenienceListItem != null && incovenienceListItem!.isNotEmpty
                  ? inconvenienceListWidget(incovenienceListItem)
                  : widget.lightoutList != null &&
                          widget.lightoutList!.isNotEmpty
                      ? lightOutListWidget()
                      : widget.airConditioningList != null &&
                              widget.airConditioningList!.isNotEmpty
                          ? airConditioningListWidget()
                          : emptyViewWidget()
            ],
          ),
        ),
      ),
    );
  }

  inconvenienceListWidget(List<IncovenienceListModel>? incovenienceListItem) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
      child: ListView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: incovenienceListItem?.length,
          itemBuilder: ((context, index) {
            return InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InconvenienceDetails(
                        inquiryId:
                            incovenienceListItem?[index].inquiryId.toString() ??
                                ""),
                  ),
                ).then((value) {
                  if (value) {
                    setState(() {
                      isFromDetail = true;
                    });
                    firstTimeLoadInconvenienceList();
                  }
                });
              },
              child: Container(
                decoration: BoxDecoration(
                    color: CustomColors.whiteColor,
                    border: Border.all(
                      color: CustomColors.borderColor,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(4))),
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(
                            incovenienceListItem?[index].title ?? "",
                            maxLines: 2,
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
                        if (incovenienceListItem != null &&
                            incovenienceListItem![index]
                                .status
                                .toString()
                                .isNotEmpty)
                          Container(
                            decoration: BoxDecoration(
                              color: setStatusBackgroundColor(widget
                                  .inconvenienceList?[index].status
                                  .toString()
                                  .toLowerCase()),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                            child: Text(
                              incovenienceListItem[index].displayStatus ?? "",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "SemiBold",
                                color: setStatusTextColor(widget
                                    .inconvenienceList?[index].status
                                    .toString()
                                    .toLowerCase()),
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
                            incovenienceListItem?[index].type ?? "",
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
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2),
                            child: VerticalDivider(
                              thickness: 1,
                              color: CustomColors.borderColor,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            incovenienceListItem?[index].registeredDate ?? "",
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
    );
  }

  emptyViewWidget() {
    return Container(
      color: CustomColors.backgroundColor,
      margin: const EdgeInsets.only(top: 16, left: 16, right: 16, bottom: 100),
      alignment: Alignment.center,
      padding: const EdgeInsets.all(24),
      child: Text(
        widget.emptyTxt,
        textAlign: TextAlign.center,
        style: const TextStyle(
            fontFamily: 'Regular',
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: CustomColors.textColor5),
      ),
    );
  }

  lightOutListWidget() {
    return Container(
        margin:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: widget.lightoutList?.length,
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LightsOutDetails(
                          id: widget.lightoutList?[index].inquiryId
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
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              widget.lightoutList?[index].description ?? "",
//"Centropolis",
                              maxLines: 1,
                              style: const TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 16,
                                  color: CustomColors.textColor8),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          if (widget.lightoutList != null &&
                              widget.lightoutList![index].status
                                  .toString()
                                  .isNotEmpty)
                            Container(
                              decoration: BoxDecoration(
                                color: setStatusBackgroundColor(widget
                                    .lightoutList?[index].status
                                    .toString()
                                    .toLowerCase()),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 5.0,
                                  left: 10.0,
                                  right: 10.0),
                              child: Text(
                                widget.lightoutList?[index].displayStatus ?? "",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "SemiBold",
                                  color: setStatusTextColor(widget
                                      .lightoutList?[index].status
                                      .toString()
                                      .toLowerCase()),
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          children: [
                            Expanded(
                              child: Text(
                                widget.lightoutList?[index].requestedFloors
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
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: VerticalDivider(
                                thickness: 1,
                                color: CustomColors.borderColor,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${widget.lightoutList?[index].registeredDate ?? ""} ${widget.lightoutList?[index].startTime ?? ""}",
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
            })));
  }

  airConditioningListWidget() {
    return Container(
        margin:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 100),
        child: ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: widget.airConditioningList?.length,
            itemBuilder: ((context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AirConditioningDetails(
                          inquiryId: widget
                                  .airConditioningList?[index].inquiryId
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
                      borderRadius: const BorderRadius.all(Radius.circular(4))),
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            size: 8,
                            color: widget.airConditioningList?[index].type
                                        .toString()
                                        .trim()
                                        .toLowerCase() ==
                                    "heating"
                                ? CustomColors.headingColor
                                : CustomColors.coolingColor,
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            widget.airConditioningList?[index].displayType
                                    .toString()
                                    .capitalize() ??
                                "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 12,
                                color: CustomColors.textColorBlack2),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(
                              widget.airConditioningList?[index].description ??
                                  "",
//"Centropolis",
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
                          if (widget.airConditioningList != null &&
                              widget.airConditioningList![index].status
                                  .toString()
                                  .isNotEmpty)
                            Container(
                              decoration: BoxDecoration(
                                color: setStatusBackgroundColor(widget
                                    .airConditioningList?[index].status
                                    .toString()
                                    .toLowerCase()),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.only(
                                  top: 5.0,
                                  bottom: 5.0,
                                  left: 10.0,
                                  right: 10.0),
                              child: Text(
                                widget.airConditioningList?[index]
                                        .displayStatus ??
                                    "",
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "SemiBold",
                                  color: setStatusTextColor(widget
                                      .airConditioningList?[index].status
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
                            Expanded(
                              child: Text(
                                widget.airConditioningList?[index]
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
                              padding: EdgeInsets.symmetric(vertical: 2),
                              child: VerticalDivider(
                                thickness: 1,
                                color: CustomColors.borderColor,
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              "${widget.airConditioningList?[index].registeredDate ?? ""} ${widget.airConditioningList?[index].startTime ?? ""}",
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
            })));
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
    } else if (status == "completed") {
      return CustomColors.textColor3;
    } else {
      return CustomColors.textColorBlack2;
    }
  }

  void firstTimeLoadInconvenienceList() {
    if (mounted) {
      setState(() {
        isFirstLoadRunning = true;
        page = 1;
      });
      loadInconvenienceList();
    }
  }

  void loadInconvenienceList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callInconvenienceListApi();
    } else {
//showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callInconvenienceListApi() {
    Map<String, String> body = {
      "page": page.toString(),
      "limit": limit.toString()
    };

    debugPrint("Inconvenience List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getInconvenienceListUrl, body, language.toString(), apiKey);
    response.then((response) {
      if (mounted) {
        var responseJson = json.decode(response.body);

        debugPrint("server response for Inconvenience List ===> $responseJson");

        if (responseJson != null) {
          if (response.statusCode == 200 && responseJson['success']) {
            totalPages = responseJson['total_pages'];
            totalRecords = responseJson['total_records'];
            List<IncovenienceListModel> incovenienceList =
                List<IncovenienceListModel>.from(responseJson['inquiry_data']
                    .map((x) => IncovenienceListModel.fromJson(x)));

            Provider.of<InconvenienceListProvider>(context, listen: false)
                .setItem(incovenienceList);
          } else {
            if (responseJson['message'] != null) {
              debugPrint("Server error response ${responseJson['message']}");
// showCustomToast(
// fToast, context, responseJson['message'].toString(), "");
              showErrorCommonModal(
                  context: context,
                  heading: responseJson['message'].toString(),
                  description: "",
                  buttonName: tr("check"));
            }
          }
          setState(() {
            isFirstLoadRunning = false;
          });
        }
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");

      if (mounted) {
        showErrorCommonModal(
            context: context,
            heading: tr("errorDescription"),
            description: "",
            buttonName: tr("check"));
        setState(() {
          isFirstLoadRunning = false;
        });
      }
    });
  }
}
