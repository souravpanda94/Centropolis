import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/air_conditioning_detail_model.dart';
import '../../providers/air_conditioning_detail_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';

class AirConditioningDetails extends StatefulWidget {
  final String inquiryId, appBarTitle;
  const AirConditioningDetails(
      {super.key, required this.inquiryId, required this.appBarTitle});

  @override
  State<AirConditioningDetails> createState() => _AirConditioningDetailsState();
}

class _AirConditioningDetailsState extends State<AirConditioningDetails> {
  late String language, apiKey;
  late FToast fToast;
  bool isLoading = false;
  AirConditioningDetailModel? airConditioningDetailModel;

  @override
  void initState() {
    super.initState();
    language = tr("lang");
    fToast = FToast();
    fToast.init(context);
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    loadAirConditioningDetails();
  }

  @override
  Widget build(BuildContext context) {
    airConditioningDetailModel =
        Provider.of<AirConditioningDetailsProvider>(context)
            .getAirConditioningDetailModel;
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: PreferredSize(
        preferredSize: AppBar().preferredSize,
        child: SafeArea(
          child: Container(
            color: CustomColors.whiteColor,
            child: CommonAppBar(widget.appBarTitle, false, () {
              onBackButtonPress(context);
            }, () {}),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: CustomColors.whiteColor,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(tr("tenantCompanyInformation"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 16,
                                color: CustomColors.textColor8)),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      if (airConditioningDetailModel != null &&
                          airConditioningDetailModel!.status
                              .toString()
                              .isNotEmpty)
                        Container(
                          decoration: BoxDecoration(
                            color: setStatusBackgroundColor(
                                airConditioningDetailModel?.status
                                        .toString()
                                        .toLowerCase() ??
                                    ""),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.only(
                              top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                          child: Text(
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            airConditioningDetailModel?.displayStatus
                                    .toString() ??
                                "",
                            style: TextStyle(
                              fontSize: 12,
                              fontFamily: "SemiBold",
                              color: setStatusTextColor(
                                  airConditioningDetailModel?.status
                                          .toString()
                                          .toLowerCase() ??
                                      ""),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    padding: const EdgeInsets.all(16),
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: CustomColors.backgroundColor,
                        borderRadius: BorderRadius.all(Radius.circular(4))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(tr("nameLounge"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8)),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          airConditioningDetailModel?.name.toString() ?? "",
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(tr("lightOutDetailCompany"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8)),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          airConditioningDetailModel?.companyName.toString() ??
                              "",
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(tr("email"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8)),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          airConditioningDetailModel?.email.toString() ?? "",
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(tr("contactNo"),
                            style: const TextStyle(
                                fontFamily: 'SemiBold',
                                fontSize: 14,
                                color: CustomColors.textColor8)),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          formatNumberStringWithDash(
                              airConditioningDetailModel?.contact.toString() ??
                                  ""),
                          style: const TextStyle(
                              fontFamily: 'Regular',
                              fontSize: 14,
                              color: CustomColors.textColorBlack2),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: CustomColors.backgroundColor,
              width: MediaQuery.of(context).size.width,
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
                    tr("applicationFloor"),
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
                  Text(
                    airConditioningDetailModel?.requestedFloor
                            .toString()
                            .toUpperCase() ??
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
            ),
            Container(
              color: CustomColors.backgroundColor,
              width: MediaQuery.of(context).size.width,
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
                    tr("airConditioning/Heading"),
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
                  Text(
                    airConditioningDetailModel?.type.toString() ?? "",
                    style: const TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 14,
                        color: CustomColors.textColor8),
                  ),
                ],
              ),
            ),
            Container(
              color: CustomColors.backgroundColor,
              width: MediaQuery.of(context).size.width,
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
                    tr("dateOfApplication"),
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
                  Text(
                    "${airConditioningDetailModel?.requestDate.toString() ?? ""}  |  ${airConditioningDetailModel?.startTime.toString() ?? ""}  |  ${airConditioningDetailModel?.usageHours.toString() ?? ""} ${tr("krwDetail")}",
                    style: const TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 14,
                        color: CustomColors.textColor8),
                  )
                  // IntrinsicHeight(
                  //   child: Row(
                  //     children: [
                  //       Expanded(
                  //         child: Text(
                  //           airConditioningDetailModel?.requestDate
                  //                   .toString() ??
                  //               "",
                  //           style: const TextStyle(
                  //               fontFamily: 'Regular',
                  //               fontSize: 14,
                  //               color: CustomColors.textColor8),
                  //         ),
                  //       ),
                  //       const Expanded(
                  //         child: Padding(
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: 6, vertical: 4),
                  //           child: VerticalDivider(
                  //             thickness: 1,
                  //             color: CustomColors.textColor3,
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Text(
                  //           airConditioningDetailModel?.startTime.toString() ??
                  //               "",
                  //           style: const TextStyle(
                  //               fontFamily: 'Regular',
                  //               fontSize: 14,
                  //               color: CustomColors.textColor8),
                  //         ),
                  //       ),
                  //       const Expanded(
                  //         child: Padding(
                  //           padding: EdgeInsets.symmetric(
                  //               horizontal: 6, vertical: 4),
                  //           child: VerticalDivider(
                  //             thickness: 1,
                  //             color: CustomColors.textColor3,
                  //           ),
                  //         ),
                  //       ),
                  //       Expanded(
                  //         child: Text(
                  //           "${airConditioningDetailModel?.usageHours.toString() ?? ""} hours (--KRW)",
                  //           style: const TextStyle(
                  //               fontFamily: 'Regular',
                  //               fontSize: 14,
                  //               color: CustomColors.textColor8),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            Container(
              color: CustomColors.backgroundColor,
              width: MediaQuery.of(context).size.width,
              height: 8,
            ),
            Container(
              color: CustomColors.whiteColor,
              padding: const EdgeInsets.all(16),
              margin: const EdgeInsets.only(bottom: 140),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    tr("otherRequests"),
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
                  Text(
                    airConditioningDetailModel?.detail.toString() ?? "",
                    style: const TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 14,
                        color: CustomColors.textColor8),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void loadAirConditioningDetails() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callAirConditioningDetailsApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callAirConditioningDetailsApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {
      "inquiry_id": widget.inquiryId.toString().trim()
    };

    debugPrint("AirConditioning details input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.airConditioningDetailUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for AirConditioning details ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          AirConditioningDetailModel airConditioningDetailModel =
              AirConditioningDetailModel.fromJson(responseJson);

          Provider.of<AirConditioningDetailsProvider>(context, listen: false)
              .setItem(airConditioningDetailModel);
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
