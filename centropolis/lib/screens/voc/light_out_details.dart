import 'dart:convert';

import 'package:centropolis/widgets/common_button_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/light_out_detail_model.dart';
import '../../providers/light_out_detail_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_modal.dart';

class LightsOutDetails extends StatefulWidget {
  final String id, fromPage;
  const LightsOutDetails({super.key, required this.id, required this.fromPage});

  @override
  State<LightsOutDetails> createState() => _LightsOutDetailsState();
}

class _LightsOutDetailsState extends State<LightsOutDetails> {
  late String language, apiKey;
  late FToast fToast;
  bool isLoading = false;
  LightOutDetailModel? lightOutDetails;
  bool isLoadingRequired = false;

  @override
  void initState() {
    super.initState();
    language = tr("lang");
    fToast = FToast();
    fToast.init(context);
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    loadLightOutDetails();
  }

  @override
  Widget build(BuildContext context) {
    lightOutDetails =
        Provider.of<LightOutDetailsProvider>(context).getLightOutDetailModel;

    return WillPopScope(
       onWillPop: () async {
           Navigator.pop(context, true);
          return true;
        },
      child: LoadingOverlay(
        opacity: 0.5,
        color: CustomColors.textColor4,
        progressIndicator: const CircularProgressIndicator(
          color: CustomColors.blackColor,
        ),
        isLoading: isLoading,
        child: Scaffold(
          backgroundColor: CustomColors.whiteColor,
          appBar: PreferredSize(
            preferredSize: AppBar().preferredSize,
            child: SafeArea(
              child: Container(
                color: CustomColors.whiteColor,
                child: CommonAppBar(tr("lightOutSubtitle"), false, () {
                  //onBackButtonPress(context);
                  Navigator.pop(context, isLoadingRequired);
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
                          if (lightOutDetails != null &&
                              lightOutDetails!.status.toString().isNotEmpty)
                            Container(
                              decoration: BoxDecoration(
                                color: setStatusBackgroundColor(lightOutDetails
                                        ?.status
                                        .toString()
                                        .toLowerCase() ??
                                    ""),
                                borderRadius: BorderRadius.circular(4),
                              ),
                              padding: const EdgeInsets.only(
                                  top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                              child: Text(
                                lightOutDetails?.displayStatus.toString() ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "SemiBold",
                                  color: setStatusTextColor(lightOutDetails
                                          ?.status
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
                            Text(tr("CoolingHeatingName"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8)),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(
                              lightOutDetails?.name.toString() ?? "",
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
                              lightOutDetails?.companyName.toString() ?? "",
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
                              lightOutDetails?.email.toString() ?? "",
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
                                  lightOutDetails?.contact.toString() ?? ""),
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
                        lightOutDetails?.requestedFloors
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
                        tr("lightsOutDate"),
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
                        "${lightOutDetails?.applicationDate.toString() ?? ""}   |   ${lightOutDetails?.startTime.toString() ?? ""} ~ ${lightOutDetails?.endTime.toString() ?? ""}",
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
                  margin:
                      EdgeInsets.only(bottom: widget.fromPage == "VOC" ? 140 : 0),
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
                        lightOutDetails?.detail.toString() ?? "",
                        style: const TextStyle(
                            height: 1.5,
                            fontFamily: 'Regular',
                            fontSize: 14,
                            color: CustomColors.textColor8),
                      ),
                    ],
                  ),
                ),
                if (widget.fromPage == "MyPage")
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 8,
                        color: CustomColors.backgroundColor,
                      ),
                      Container(
                        color: CustomColors.whiteColor,
                        padding: const EdgeInsets.all(16),
                        margin: const EdgeInsets.only(bottom: 40),
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CommonButtonWithBorder(
                              onCommonButtonTap: () {
                                Navigator.pop(context, isLoadingRequired);
                              },
                              buttonName: tr("toList"),
                              buttonBorderColor:
                                  CustomColors.buttonBackgroundColor,
                              buttonTextColor: CustomColors.buttonBackgroundColor,
                            ),
                            if (lightOutDetails?.canChange
                                    .toString()
                                    .toLowerCase() ==
                                "y")
                              const SizedBox(
                                height: 16,
                              ),
                            if (lightOutDetails?.canChange
                                    .toString()
                                    .toLowerCase() ==
                                "y")
                              CommonButtonWithBorder(
                                onCommonButtonTap: () {
                                  if (lightOutDetails?.canChangeButtonEnabled
                                          .toString()
                                          .toLowerCase() ==
                                      "y") {
                                    networkCheckForStatusChange("rejected");
                                  }
                                },
                                buttonName: tr("reject"),
                                buttonBorderColor: lightOutDetails
                                            ?.canChangeButtonEnabled
                                            .toString()
                                            .toLowerCase() ==
                                        "y"
                                    ? CustomColors.buttonBackgroundColor
                                    : CustomColors.dividerGreyColor,
                                buttonTextColor: lightOutDetails
                                            ?.canChangeButtonEnabled
                                            .toString()
                                            .toLowerCase() ==
                                        "y"
                                    ? CustomColors.buttonBackgroundColor
                                    : CustomColors.dividerGreyColor,
                              ),
                            if (lightOutDetails?.canChange
                                    .toString()
                                    .toLowerCase() ==
                                "y")
                              const SizedBox(
                                height: 16,
                              ),
                            if (lightOutDetails?.canChange
                                    .toString()
                                    .toLowerCase() ==
                                "y")
                              CommonButtonWithBorder(
                                onCommonButtonTap: () {
                                  if (lightOutDetails?.canChangeButtonEnabled
                                          .toString()
                                          .toLowerCase() ==
                                      "y") {
                                    networkCheckForStatusChange(
                                        "waiting_for_approval");
                                  }
                                },
                                buttonName: tr("approve"),
                                buttonColor: lightOutDetails
                                            ?.canChangeButtonEnabled
                                            .toString()
                                            .toLowerCase() ==
                                        "y"
                                    ? CustomColors.buttonBackgroundColor
                                    : CustomColors.whiteColor,
                                buttonBorderColor: lightOutDetails
                                            ?.canChangeButtonEnabled
                                            .toString()
                                            .toLowerCase() ==
                                        "y"
                                    ? CustomColors.buttonBackgroundColor
                                    : CustomColors.dividerGreyColor,
                                buttonTextColor: lightOutDetails
                                            ?.canChangeButtonEnabled
                                            .toString()
                                            .toLowerCase() ==
                                        "y"
                                    ? CustomColors.whiteColor
                                    : CustomColors.dividerGreyColor,
                              ),
                          ],
                        ),
                      ),
                    ],
                  )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loadLightOutDetails() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLightOutDetailsApi();
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callLightOutDetailsApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {"inquiry_id": widget.id.toString().trim()};

    debugPrint("LightOut details input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.lightOutDetailUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for LightOut details ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          LightOutDetailModel lightOutDetailModel =
              LightOutDetailModel.fromJson(responseJson);

          Provider.of<LightOutDetailsProvider>(context, listen: false)
              .setItem(lightOutDetailModel);
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
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(context: context,
          heading: tr("errorDescription"),
          description:"",
          buttonName : tr("check"));
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

  void networkCheckForStatusChange(String status) async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callStatusChangeApi(status);
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(context: context,
          heading: tr("noInternet"),
         description : tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callStatusChangeApi(String status) {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "inquiry_id": lightOutDetails!.inquiryId.toString().trim(), //required
      "status": status.toString().trim(),
    };

    debugPrint("lightOutDetails StatusChange input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.lightOutChangeStatusUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for lightOutDetails StatusChange ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          setState(() {
            isLoadingRequired = true;
          });
          showReservationModal(responseJson['message']);
        }
        else {
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
          isLoading = false;
        });
      }
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      showErrorCommonModal(context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  void showReservationModal(String text) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return CommonModal(
            heading: text,
            description: "",
            buttonName: tr("check"),
            firstButtonName: "",
            secondButtonName: "",
            onConfirmBtnTap: () {
              Navigator.pop(context);
              Navigator.pop(context, isLoadingRequired);
            },
            onFirstBtnTap: () {},
            onSecondBtnTap: () {},
          );
        });
  }




}
