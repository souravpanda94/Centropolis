import 'dart:convert';
import 'package:centropolis/widgets/common_button_with_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../models/conference_history_detail_model.dart';
import '../../providers/conference_history_details_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_modal.dart';

class ConferenceHistoryDetails extends StatefulWidget {
  final String? conferenceId;
  const ConferenceHistoryDetails(
    this.conferenceId, {
    super.key,
  });

  @override
  State<ConferenceHistoryDetails> createState() =>
      _ConferenceHistoryDetailsState();
}

class _ConferenceHistoryDetailsState extends State<ConferenceHistoryDetails> {
  late String language, apiKey;
  late FToast fToast;
  bool isLoading = false;
  ConferenceHistoryDetailModel? conferenceHistoryDetails;
  bool isLoadingRequired = false;

  @override
  void initState() {
    super.initState();
    language = tr("lang");
    fToast = FToast();
    fToast.init(context);
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    loadConferenceHistoryDetails();
  }

  @override
  Widget build(BuildContext context) {
    conferenceHistoryDetails =
        Provider.of<ConferenceHistoryDetailsProvider>(context)
            .getConferenceHistoryDetailModel;

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
              child: CommonAppBar(tr("conferenceRoomReservation"), false, () {
                //onBackButtonPress(context);
                Navigator.pop(context, isLoadingRequired);
              }, () {}),
            ),
          ),
        ),
        body: conferenceHistoryDetails != null
            ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: CustomColors.whiteColor,
                      padding: const EdgeInsets.all(16),
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tr("reservationInformation"),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 16,
                                    color: CustomColors.textColor8),
                              ),
                              if (conferenceHistoryDetails?.status.toString() !=
                                  "")
                                Container(
                                  decoration: BoxDecoration(
                                    color: setStatusBackgroundColor(
                                        conferenceHistoryDetails?.status
                                            .toString()),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  padding: const EdgeInsets.only(
                                      top: 5.0,
                                      bottom: 5.0,
                                      left: 10.0,
                                      right: 10.0),
                                  child: Text(
                                    conferenceHistoryDetails?.displayStatus ??
                                        "",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontFamily: "SemiBold",
                                      color: setStatusTextColor(
                                          conferenceHistoryDetails?.status
                                              .toString()),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tr("nameLounge"),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColorBlack2),
                              ),
                              Text(
                                conferenceHistoryDetails?.name ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    color: CustomColors.textColorBlack2),
                              ),
                            ],
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Divider(
                              color: CustomColors.backgroundColor2,
                              thickness: 1,
                              height: 1,
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                tr("tenantCompanyLounge"),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColorBlack2),
                              ),
                              Text(
                                conferenceHistoryDetails?.companyName ?? "",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontFamily: 'Regular',
                                    fontSize: 14,
                                    color: CustomColors.textColorBlack2),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
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
                            tr("reservationDate"),
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
                          IntrinsicHeight(
                            child: Row(
                              children: [
                                Text(
                                  conferenceHistoryDetails?.reservationDate ??
                                      "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColor8),
                                ),
                                const Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 3, vertical: 4),
                                  child: VerticalDivider(
                                    color: CustomColors.textColor3,
                                    thickness: 1,
                                  ),
                                ),
                                Text(
                                  conferenceHistoryDetails?.usageTime ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.textColor8),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(
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
                            tr("preferredConferenceRoom"),
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
                            conferenceHistoryDetails?.conferenceRoom ?? "",
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
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
                            tr("meetingPackage"),
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
                            conferenceHistoryDetails?.packageName ??
                                tr("noPackage"),
                            style: const TextStyle(
                                fontFamily: 'Regular',
                                fontSize: 14,
                                color: CustomColors.textColor8),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
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
                            tr("enterRentalInformation"),
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
                            conferenceHistoryDetails?.description ?? "",
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
              )
            : Container(
                width: MediaQuery.of(context).size.width,
                margin:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
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
        bottomSheet: conferenceHistoryDetails?.canCancel
                    .toString()
                    .toLowerCase()
                    .trim() ==
                "y"
            ? Container(
                width: MediaQuery.of(context).size.width,
                color: CustomColors.whiteColor,
                padding: const EdgeInsets.only(
                    left: 16, top: 16, right: 16, bottom: 40),
                child: CommonButtonWithBorder(
                    onCommonButtonTap: () {
                      if (conferenceHistoryDetails?.canCancelButtonEnabled
                              .toString()
                              .toLowerCase()
                              .trim() ==
                          "y") {
                        networkCheckForCancelReservation();
                      }
                    },
                    buttonBorderColor: CustomColors.dividerGreyColor,
                    buttonColor: CustomColors.whiteColor,
                    buttonName: tr("cancelReservation"),
                    buttonTextColor: conferenceHistoryDetails
                                ?.canCancelButtonEnabled
                                .toString()
                                .toLowerCase()
                                .trim() ==
                            "n"
                        ? CustomColors.textColor5.withOpacity(0.3)
                        : CustomColors.textColor5),
              )
            : null,
      ),
    );
  }

  void loadConferenceHistoryDetails() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callConferenceHistoryDetailsApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callConferenceHistoryDetailsApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {
      "conference_id": widget.conferenceId.toString().trim()
    };

    debugPrint("Conference History details input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.conferenceHistoryDetailsUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for Conference History details ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          ConferenceHistoryDetailModel conferenceHistoryDetailModel =
              ConferenceHistoryDetailModel.fromJson(responseJson);

          Provider.of<ConferenceHistoryDetailsProvider>(context, listen: false)
              .setItem(conferenceHistoryDetailModel);
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

  void networkCheckForCancelReservation() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callCancelReservationApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callCancelReservationApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "conference_id": widget.conferenceId!.toString()
    };

    debugPrint("conferencce cancel reservation input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.cancelConferenceReservationUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for conferencce cancel reservation ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          setState(() {
            isLoadingRequired = true;
          });
          showReservationModal(responseJson['message']);
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

  Color setStatusBackgroundColor(String? status) {
    if (status.toString().toLowerCase() == "rejected" ||
        status.toString().toLowerCase() == "cancelled") {
      return CustomColors.backgroundColor3;
    } else {
      return CustomColors.backgroundColor;
    }
  }

  Color setStatusTextColor(String? status) {
    if (status.toString().toLowerCase() == "rejected" ||
        status.toString().toLowerCase() == "cancelled") {
      return CustomColors.textColor9;
    } else if (status.toString().toLowerCase() == "used") {
      return CustomColors.textColor3;
    } else {
      return CustomColors.textColorBlack2;
    }
  }
}
