import 'dart:convert';

import 'package:centropolis/widgets/common_button_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../models/complaints_received_detail_model.dart';
import '../../providers/complaints_received_detail_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';

class InconvenienceDetails extends StatefulWidget {
  final String inquiryId;
  const InconvenienceDetails({super.key, required this.inquiryId});

  @override
  State<InconvenienceDetails> createState() => _InconvenienceDetailsState();
}

class _InconvenienceDetailsState extends State<InconvenienceDetails> {
  late String language, apiKey;
  late FToast fToast;
  bool isLoading = false;
  ComplaintsReceivedDetailsModel? complaintsReceivedDetails;

  @override
  void initState() {
    super.initState();
    language = tr("lang");
    fToast = FToast();
    fToast.init(context);
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    loadComplaintsReceivedDetails();
  }

  @override
  Widget build(BuildContext context) {
    complaintsReceivedDetails =
        Provider.of<ComplaintsReceivedDetailsProvider>(context)
            .getComplaintsReceivedDetailModel;

    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.textColor4,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isLoading,
      child: Scaffold(
        backgroundColor: CustomColors.backgroundColor,
        appBar: PreferredSize(
          preferredSize: AppBar().preferredSize,
          child: SafeArea(
            child: Container(
              color: CustomColors.whiteColor,
              child: CommonAppBar(tr("complaintsReceived"), false, () {
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
                          child: Text(tr("applicantInformation"),
                              style: const TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 16,
                                  color: CustomColors.textColor8)),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        if (complaintsReceivedDetails != null &&
                            complaintsReceivedDetails!.status
                                .toString()
                                .isNotEmpty)
                          Container(
                            decoration: BoxDecoration(
                              color: setStatusBackgroundColor(
                                  complaintsReceivedDetails?.status
                                          .toString()
                                          .toLowerCase() ??
                                      ""),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            padding: const EdgeInsets.only(
                                top: 5.0, bottom: 5.0, left: 10.0, right: 10.0),
                            child: Text(
                              complaintsReceivedDetails?.status.toString() ??
                                  "",
                              style: TextStyle(
                                fontSize: 12,
                                fontFamily: "SemiBold",
                                color: setStatusTextColor(
                                    complaintsReceivedDetails?.status
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
                            complaintsReceivedDetails?.name.toString() ?? "",
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColorBlack2),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                          Text(tr("tenantCompanyLounge"),
                              style: const TextStyle(
                                  fontFamily: 'SemiBold',
                                  fontSize: 14,
                                  color: CustomColors.textColor8)),
                          const SizedBox(
                            height: 8,
                          ),
                          Text(
                            complaintsReceivedDetails?.companyName.toString() ??
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
                            complaintsReceivedDetails?.email.toString() ?? "",
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
                                complaintsReceivedDetails?.contact.toString() ??
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
                      tr("floor"),
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
                      complaintsReceivedDetails?.floor.toString() ?? "",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 14,
                          color: CustomColors.textColor8),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      tr("typeOfComplaint"),
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
                      complaintsReceivedDetails?.type.toString() ?? "",
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
                margin: complaintsReceivedDetails?.status
                            .toString()
                            .toLowerCase() ==
                        "answered"
                    ? null
                    : const EdgeInsets.only(bottom: 120),
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      complaintsReceivedDetails?.title.toString() ?? "",
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
                      complaintsReceivedDetails?.description.toString() ?? "",
                      style: const TextStyle(
                          fontFamily: 'Regular',
                          fontSize: 14,
                          color: CustomColors.textColor8),
                    ),
                    if (complaintsReceivedDetails?.attachment != null &&
                        complaintsReceivedDetails!.attachment
                            .toString()
                            .trim()
                            .isNotEmpty)
                      Container(
                        margin: const EdgeInsets.only(top: 8),
                        width: MediaQuery.of(context).size.width,
                        child: Image.network(
                          "${ApiEndPoint.baseImageFetchUrl}${complaintsReceivedDetails?.attachment.toString() ?? ""}",
                          fit: BoxFit.fill,
                          height: 194,
                        ),
                      )
                  ],
                ),
              ),
              Container(
                color: CustomColors.backgroundColor,
                width: MediaQuery.of(context).size.width,
                height: 8,
              ),
              if (complaintsReceivedDetails?.status.toString().toLowerCase() ==
                  "answered")
                Container(
                  color: CustomColors.whiteColor,
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 150),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr("inquiryAnswer"),
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
                        complaintsReceivedDetails?.response.toString() ?? "",
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
      ),
    );
  }

  void loadComplaintsReceivedDetails() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callComplaintsReceivedDetailsApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callComplaintsReceivedDetailsApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {
      "inquiry_id": widget.inquiryId.toString().trim()
    };

    debugPrint("Complaints Received details input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.complaintsReceivedDetailsUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for Complaints Received details ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          ComplaintsReceivedDetailsModel complaintsReceivedDetailModel =
              ComplaintsReceivedDetailsModel.fromJson(responseJson);

          Provider.of<ComplaintsReceivedDetailsProvider>(context, listen: false)
              .setItem(complaintsReceivedDetailModel);
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
    return CustomColors.backgroundColor;
  }

  Color setStatusTextColor(String? status) {
    if (status == "completed") {
      return CustomColors.textColor3;
    } else {
      return CustomColors.textColorBlack2;
    }
  }
}
