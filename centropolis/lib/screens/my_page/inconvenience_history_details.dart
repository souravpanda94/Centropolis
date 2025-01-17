import 'dart:convert';

import 'package:centropolis/widgets/common_button_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/firebase_analytics_events.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../models/complaints_received_detail_model.dart';
import '../../providers/complaints_received_detail_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../widgets/common_button.dart';
import '../../widgets/rating_modal.dart';
import '../voc/complaints_received.dart';

class InconvenienceHistoryDetails extends StatefulWidget {
  final String inquiryId;
  const InconvenienceHistoryDetails({super.key, required this.inquiryId});

  @override
  State<InconvenienceHistoryDetails> createState() =>
      _InconvenienceHistoryDetailsState();
}

class _InconvenienceHistoryDetailsState
    extends State<InconvenienceHistoryDetails> {
  late String language, apiKey;
  late FToast fToast;
  bool isLoading = false;
  ComplaintsReceivedDetailsModel? complaintsReceivedDetails;
  bool isLoadingRequired = false;
  double ratingValue = 0.0;

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

    if (complaintsReceivedDetails?.rating != "null" &&
        complaintsReceivedDetails?.rating != null &&
        complaintsReceivedDetails!.rating.toString().trim().isNotEmpty) {
      ratingValue = double.parse(complaintsReceivedDetails!.rating!);
    } else {
      ratingValue = 0.0;
    }
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
                child: CommonAppBar(tr("complaintsReceivedTitle"), false, () {
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
                                complaintsReceivedDetails?.displayStatus
                                        .toString() ??
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
                            Text(tr("complaintReceivedName"),
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
                        complaintsReceivedDetails?.floor
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
                  // margin:
                  //     complaintsReceivedDetails?.status.toString().toLowerCase() ==
                  //             "answered"
                  //         ? null
                  //         : const EdgeInsets.only(bottom: 120),
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
                            "${ImageLinks.baseUrlForImage}${complaintsReceivedDetails?.attachment.toString() ?? ""}",
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
                        const SizedBox(
                          height: 8,
                        ),
                        if (complaintsReceivedDetails?.repliedFilePath != null &&
                            complaintsReceivedDetails!.repliedFilePath
                                .toString()
                                .trim()
                                .isNotEmpty)
                          Container(
                            margin: const EdgeInsets.only(top: 8),
                            width: MediaQuery.of(context).size.width,
                            child: Image.network(
                              "${ImageLinks.baseUrlForImage}${complaintsReceivedDetails?.repliedFilePath.toString() ?? ""}",
                              fit: BoxFit.fill,
                              height: 194,
                            ),
                          )
                      ],
                    ),
                  ),
                if (complaintsReceivedDetails?.status.toString().toLowerCase() ==
                    "answered")
                  Container(
                    color: CustomColors.backgroundColor,
                    width: MediaQuery.of(context).size.width,
                    height: 8,
                  ),
                // if (complaintsReceivedDetails?.repliedFilePath != null &&
                //     complaintsReceivedDetails!.repliedFilePath
                //         .toString()
                //         .trim()
                //         .isNotEmpty)
                //   Container(
                //     color: CustomColors.whiteColor,
                //     padding: const EdgeInsets.all(16),
                //     width: MediaQuery.of(context).size.width,
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.start,
                //       children: [
                //         Text(
                //           tr("inconvenienceRepliedImage"),
                //           maxLines: 1,
                //           overflow: TextOverflow.ellipsis,
                //           style: const TextStyle(
                //               fontFamily: 'SemiBold',
                //               fontSize: 16,
                //               color: CustomColors.textColor8),
                //         ),
                //         Container(
                //           margin: const EdgeInsets.only(top: 8),
                //           width: MediaQuery.of(context).size.width,
                //           child: Image.network(
                //             "${ImageLinks.baseUrlForImage}${complaintsReceivedDetails?.repliedFilePath.toString() ?? ""}",
                //             fit: BoxFit.fill,
                //             height: 194,
                //           ),
                //         )
                //       ],
                //     ),
                //   ),
                // if (complaintsReceivedDetails?.repliedFilePath != null &&
                //     complaintsReceivedDetails!.repliedFilePath
                //         .toString()
                //         .trim()
                //         .isNotEmpty)
                //   Container(
                //     color: CustomColors.backgroundColor,
                //     width: MediaQuery.of(context).size.width,
                //     height: 8,
                //   ),
                Container(
                  color: CustomColors.whiteColor,
                  padding: const EdgeInsets.all(16),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        tr("inquiryRating"),
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
                      IgnorePointer(
                        child: RatingBar(
                          itemSize: 32,
                          wrapAlignment: WrapAlignment.center,
                          initialRating: ratingValue,
                          direction: Axis.horizontal,
                          allowHalfRating: false,
                          itemCount: 5,
                          ratingWidget: RatingWidget(
                            full: Image.asset(
                              "assets/images/full_star.png",
                              height: 32,
                              width: 32,
                            ),
                            half: Image.asset(
                              "assets/images/half_star.png",
                              height: 32,
                              width: 32,
                            ),
                            empty: Image.asset(
                              "assets/images/empty_star.png",
                              height: 32,
                              width: 32,
                            ),
                          ),
                          itemPadding:
                              const EdgeInsets.symmetric(horizontal: 4.0),
                          onRatingUpdate: (double value) {},
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
                  width: MediaQuery.of(context).size.width,
                  color: CustomColors.whiteColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (complaintsReceivedDetails?.canRate
                              .toString()
                              .trim()
                              .toLowerCase() ==
                          "y")
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: CustomColors.whiteColor,
                          padding:
                              const EdgeInsets.only(left: 16, top: 16, right: 16),
                          child: CommonButton(
                            onCommonButtonTap: () {
                              showRatingModal();
                            },
                            buttonColor: CustomColors.buttonBackgroundColor,
                            buttonName: tr("rateUs"),
                            isIconVisible: false,
                          ),
                        ),
                      if (complaintsReceivedDetails?.canReply
                              .toString()
                              .trim()
                              .toLowerCase() ==
                          "y")
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: CustomColors.whiteColor,
                          padding:
                              const EdgeInsets.only(left: 16, top: 16, right: 16),
                          child: CommonButtonWithBorder(
                              onCommonButtonTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ComplaintsReceived(
                                            parentInquirId:
                                                complaintsReceivedDetails
                                                        ?.inquiryId
                                                        .toString() ??
                                                    "",
                                          )),
                                ).then((value) {
                                  if (value) {
                                    setState(() {
                                      isLoadingRequired = true;
                                    });
                                    loadComplaintsReceivedDetails();
                                  }
                                });
                              },
                              buttonBorderColor:
                                  CustomColors.buttonBackgroundColor,
                              buttonColor: CustomColors.whiteColor,
                              buttonName: tr("addInquiry"),
                              buttonTextColor:
                                  CustomColors.buttonBackgroundColor),
                        ),
                      if (complaintsReceivedDetails?.canComplete
                              .toString()
                              .trim()
                              .toLowerCase() ==
                          "y")
                        Container(
                          width: MediaQuery.of(context).size.width,
                          color: CustomColors.whiteColor,
                          padding:
                              const EdgeInsets.only(left: 16, top: 16, right: 16),
                          child: CommonButtonWithBorder(
                              onCommonButtonTap: () {
                                networkCheckForResolveInquiry();
                              },
                              buttonBorderColor:
                                  CustomColors.buttonBackgroundColor,
                              buttonColor: CustomColors.whiteColor,
                              buttonName: tr("resolveInquiry"),
                              buttonTextColor:
                                  CustomColors.buttonBackgroundColor),
                        ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        color: CustomColors.whiteColor,
                        padding: const EdgeInsets.only(
                            left: 16, top: 16, right: 16, bottom: 40),
                        child: CommonButtonWithBorder(
                            onCommonButtonTap: () {
                              Navigator.pop(context, isLoadingRequired);
                            },
                            buttonBorderColor: CustomColors.dividerGreyColor,
                            buttonColor: CustomColors.whiteColor,
                            buttonName: tr("toList"),
                            buttonTextColor: CustomColors.textColor5),
                      )
                    ],
                  ),
                )
              ],
            ),
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
      //showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
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
            debugPrint("Server error response ${responseJson['message']}");
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
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
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  Color setStatusBackgroundColor(String? status) {
    return CustomColors.backgroundColor;
  }

  Color setStatusTextColor(String? status) {
    if (status.toString().toLowerCase() == "completed") {
      return CustomColors.textColor3;
    } else {
      return CustomColors.textColorBlack2;
    }
  }

  void showRatingModal() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return RatingModal(
            heading: tr('rateUs'),
            description: tr('rateUsDescription'),
            firstButtonName: tr('cancel'),
            secondButtonName: tr('rateUsSubmit'),
            onFirstBtnTap: () {
              Navigator.pop(context);
            },
            onSecondBtnTap: (complaintRating) {
              debugPrint("complaintRating :: $complaintRating");
              if (complaintRating != 0.0) {
                networkCheckForSaveComplaintRating(complaintRating);
              }
            },
          );
        });
  }

  void networkCheckForSaveComplaintRating(complaintRating) async {
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callSaveComplaintRatingApi(complaintRating);
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callSaveComplaintRatingApi(complaintRating) {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "complaint_id": widget.inquiryId.toString().trim(),
      "rating": complaintRating.toString().trim()
    };

    debugPrint("SaveComplaintRating input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.saveComplaintRatingUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for SaveComplaintRating ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          Navigator.pop(context);
          loadComplaintsReceivedDetails();
          showErrorCommonModal(
              context: context,
              heading: responseJson['message'].toString(),
              description: "",
              buttonName: tr("check"));
          setFirebaseEventForInconvenienceRating(
              inconvenienceId: widget.inquiryId.toString().trim(),
              rating: complaintRating.toString().trim());
        } else {
          if (responseJson['message'] != null) {
            debugPrint("Server error response ${responseJson['message']}");
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
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
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }

  void networkCheckForResolveInquiry() async {
    hideKeyboard();
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callResolveInquiryApi();
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callResolveInquiryApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "complaint_id": widget.inquiryId.toString().trim(),
    };

    debugPrint("ResolveInquiry input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.resolveInquiryRatingUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for ResolveInquiry ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          loadComplaintsReceivedDetails();
          setState(() {
            isLoadingRequired = true;
          });
          showErrorCommonModal(
              context: context,
              heading: responseJson['message'].toString(),
              description: "",
              buttonName: tr("check"));

          setFirebaseEventForInconvenienceResolveInquiry(
              inconvenienceId: widget.inquiryId.toString().trim(),
              );
        } else {
          if (responseJson['message'] != null) {
            debugPrint("Server error response ${responseJson['message']}");
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
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
      showErrorCommonModal(
          context: context,
          heading: tr("errorDescription"),
          description: "",
          buttonName: tr("check"));
      setState(() {
        isLoading = false;
      });
    });
  }
}
