import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../models/user_info_model.dart';
import '../../models/visit_reservation_detail_model.dart';
import '../../providers/user_info_provider.dart';
import '../../providers/user_provider.dart';
import '../../providers/visit_reservation_detail_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/firebase_analytics_events.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/common_app_bar.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_button_with_border.dart';
import '../../widgets/common_modal.dart';

enum StatusEnum { approval, rejection }

class VisitReservationDetailsScreen extends StatefulWidget {
  final String visitId;

  const VisitReservationDetailsScreen(
    this.visitId, {
    super.key,
  });

  @override
  State<VisitReservationDetailsScreen> createState() =>
      _VisitReservationDetailsScreenState();
}

class _VisitReservationDetailsScreenState
    extends State<VisitReservationDetailsScreen> {
  late String language, apiKey, userType;
  late FToast fToast;
  bool isLoading = false;
  VisitReservationDetailModel? visitReservationDetailModel;
  bool isLoadingRequired = false;
  String accountType = "";

  @override
  void initState() {
    super.initState();
    language = tr("lang");
    fToast = FToast();
    fToast.init(context);
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    userType = user.userData['user_type'].toString();
    internetCheckingForMethods();
  }

  StatusEnum? _statusType = StatusEnum.approval;
  String statusTypeValue = "approved";

  @override
  Widget build(BuildContext context) {
    visitReservationDetailModel =
        Provider.of<VisitReservationDetailsProvider>(context)
            .getVisitReservationHistoryDetailModel;
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
                  child: CommonAppBar(tr("visitor"), false, () {
                    //onBackButtonPress(context);
                    Navigator.pop(context, isLoadingRequired);
                  }, () {}),
                ),
              ),
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(
                        top: 25.0, left: 16.0, right: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            tr("personInChargeInformation"),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontSize: 16,
                                fontFamily: "SemiBold",
                                color: CustomColors.textColor8),
                          ),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: setStatusBackgroundColor(
                                visitReservationDetailModel?.status.toString()),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          padding: const EdgeInsets.only(
                              top: 5, bottom: 5, left: 10, right: 10),
                          child: Text(
                            visitReservationDetailModel?.displayStatus ?? "",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Bold",
                                color: setStatusTextColor(
                                    visitReservationDetailModel?.status
                                        .toString())),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 15.0, left: 16.0, right: 16.0),
                    decoration: BoxDecoration(
                      color: CustomColors.backgroundColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 22, left: 15, right: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(tr("nameOfPersonInCharge"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8)),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: Text(" *",
                                  style: TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.headingColor)),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              visitReservationDetailModel?.visitedPersonName ??
                                  "",
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Regular",
                                color: CustomColors.textColorBlack2,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("tenantCompany"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              visitReservationDetailModel
                                      ?.visitedPersonCompanyName ??
                                  "",
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Regular",
                                color: CustomColors.textColorBlack2,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("visitBuilding"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              visitReservationDetailModel?.displayBuilding ??
                                  "",
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Regular",
                                color: CustomColors.textColorBlack2,
                              ),
                            ),
                          ),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(tr("landingFloor"),
                                    style: const TextStyle(
                                        fontFamily: 'SemiBold',
                                        fontSize: 14,
                                        color: CustomColors.textColor8)),
                                const Padding(
                                  padding: EdgeInsets.only(bottom: 6),
                                  child: Text(" *",
                                      style: TextStyle(
                                          fontFamily: 'Regular',
                                          fontSize: 14,
                                          color: CustomColors.headingColor)),
                                ),
                              ],
                            )),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              visitReservationDetailModel?.floor
                                      .toString()
                                      .toUpperCase() ??
                                  "",
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Regular",
                                color: CustomColors.textColorBlack2,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 10.0,
                    color: CustomColors.backgroundColor,
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        tr("visitorInformationDetails"),
                        style: const TextStyle(
                            fontSize: 16,
                            fontFamily: "SemiBold",
                            color: CustomColors.textColor8),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                        top: 15.0, left: 16.0, right: 16.0),
                    decoration: BoxDecoration(
                      color: CustomColors.backgroundColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    padding: const EdgeInsets.only(
                        top: 20, bottom: 22, left: 15, right: 15),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(tr("visitorName"),
                                style: const TextStyle(
                                    fontFamily: 'SemiBold',
                                    fontSize: 14,
                                    color: CustomColors.textColor8)),
                            const Padding(
                              padding: EdgeInsets.only(bottom: 6),
                              child: Text(" *",
                                  style: TextStyle(
                                      fontFamily: 'Regular',
                                      fontSize: 14,
                                      color: CustomColors.headingColor)),
                            ),
                          ],
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              visitReservationDetailModel?.visitorName ?? "",
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Regular",
                                color: CustomColors.textColorBlack2,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("company"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              // const Padding(
                              //   padding: EdgeInsets.only(bottom: 6),
                              //   child: Text(" *",
                              //       style: TextStyle(
                              //           fontFamily: 'Regular',
                              //           fontSize: 14,
                              //           color: CustomColors.headingColor)),
                              // ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              visitReservationDetailModel?.visitorCompanyName ??
                                  "NA",
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Regular",
                                color: CustomColors.textColorBlack2,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("email"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              visitReservationDetailModel?.visitorEmail ?? "",
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Regular",
                                color: CustomColors.textColorBlack2,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("contactNo"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              formatNumberStringWithDash(
                                  visitReservationDetailModel?.visitorMobile
                                          .toString() ??
                                      ""),
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Regular",
                                color: CustomColors.textColorBlack2,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("dateOfVisit"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              visitReservationDetailModel?.visitDate ?? "",
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Regular",
                                color: CustomColors.textColorBlack2,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("visitTime"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              visitReservationDetailModel?.visitTime ?? "",
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Regular",
                                color: CustomColors.textColorBlack2,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(tr("purposeOfVisit"),
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8)),
                              const Padding(
                                padding: EdgeInsets.only(bottom: 6),
                                child: Text(" *",
                                    style: TextStyle(
                                        fontFamily: 'Regular',
                                        fontSize: 14,
                                        color: CustomColors.headingColor)),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.only(top: 5.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              visitReservationDetailModel
                                      ?.displayVisitPurpose ??
                                  "",
                              style: const TextStyle(
                                fontSize: 14,
                                fontFamily: "Regular",
                                color: CustomColors.textColorBlack2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 10.0,
                    color: CustomColors.backgroundColor,
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                  ),
                  if ((accountType == "tenant_manager" ||
                          accountType == "tenant_visitor_employee" ||
                          accountType == "tenant_executive_visitor_employee" ||
                          accountType ==
                              "tenant_conference_visitor_employee") &&
                      ((visitReservationDetailModel?.status ==
                          "request_for_approval")))
                    Container(
                      margin: const EdgeInsets.only(left: 16.0, right: 16.0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              tr("visitApproval"),
                              style: const TextStyle(
                                  fontSize: 16,
                                  fontFamily: "SemiBold",
                                  color: CustomColors.textColor8),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 15.0),
                            child: Row(
                              // mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                const SizedBox(
                                  width: 10.0,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _statusType = StatusEnum.approval;
                                        statusTypeValue = "approved";
                                      });
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(right: 10),
                                          child: SvgPicture.asset(
                                            _statusType == StatusEnum.approval
                                                ? 'assets/images/ic_radio_check.svg'
                                                : 'assets/images/ic_radio_uncheck.svg',
                                            semanticsLabel: 'Back',
                                            width: 20,
                                            height: 20,
                                          ),
                                        ),
                                        Text(
                                          tr("approval"),
                                          style: const TextStyle(
                                            color: CustomColors.textColor4,
                                            fontSize: 14,
                                            fontFamily: 'Medium',
                                          ),
                                        ),
                                      ],
                                    )),
                                const SizedBox(
                                  width: 50.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _statusType = StatusEnum.rejection;
                                      statusTypeValue = "rejected";
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 10),
                                        child: SvgPicture.asset(
                                          _statusType == StatusEnum.rejection
                                              ? 'assets/images/ic_radio_check.svg'
                                              : 'assets/images/ic_radio_uncheck.svg',
                                          semanticsLabel: 'Back',
                                          width: 20,
                                          height: 20,
                                        ),
                                      ),
                                      Text(
                                        tr("rejection"),
                                        style: const TextStyle(
                                          color: CustomColors.textColor4,
                                          fontSize: 14,
                                          fontFamily: 'Medium',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            margin: const EdgeInsets.only(top: 30, bottom: 30),
                            child: CommonButton(
                                onCommonButtonTap: () {
                                  networkCheckForVisitReservationStatusChange();
                                },
                                buttonColor: CustomColors.buttonBackgroundColor,
                                buttonName: tr("savevisitorDetail"),
                                isIconVisible: false),
                          ),
                        ],
                      ),
                    ),
                  if (accountType == "tenant_manager" &&
                      visitReservationDetailModel?.status == "approved")
                    Container(
                        margin: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 25),
                        height: 46,
                        child: CommonButtonWithBorder(
                          onCommonButtonTap: () {
                            setState(() {
                              statusTypeValue = "cancelled";
                            });
                            networkCheckForVisitReservationStatusChange();
                          },
                          buttonName: tr("cancelReservation"),
                          buttonColor: CustomColors.whiteColor,
                          buttonBorderColor: CustomColors.dividerGreyColor,
                          buttonTextColor: CustomColors.textColor5,
                        )),
                  if ((visitReservationDetailModel?.status == "rejected" ||
                          visitReservationDetailModel?.status ==
                              "visit_completed" ||
                          visitReservationDetailModel?.status == "using" ||
                          visitReservationDetailModel?.status == "cancelled") &&
                      accountType == "tenant_manager")
                    Container(
                        margin: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 25),
                        height: 46,
                        child: CommonButtonWithBorder(
                          onCommonButtonTap: () {
                            Navigator.pop(context, isLoadingRequired);
                          },
                          buttonName: tr("check"),
                          buttonColor: CustomColors.whiteColor,
                          buttonBorderColor: CustomColors.dividerGreyColor,
                          buttonTextColor: CustomColors.textColor5,
                        )),
                  if (accountType != "tenant_manager")
                    Container(
                        margin: const EdgeInsets.only(
                            left: 16.0, right: 16.0, bottom: 25),
                        height: 46,
                        child: CommonButtonWithBorder(
                          onCommonButtonTap: () {
                            Navigator.pop(context, isLoadingRequired);
                          },
                          buttonName: tr("check"),
                          buttonColor: CustomColors.whiteColor,
                          buttonBorderColor: CustomColors.dividerGreyColor,
                          buttonTextColor: CustomColors.textColor5,
                        ))
                ],
              ),
            )),
      ),
    );
  }

  void internetCheckingForMethods() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadPersonalInformationApi();
      callVisitReservationDetailsApi();
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  // void loadVisitReservationDetails() async {
  //   final InternetChecking internetChecking = InternetChecking();
  //   if (await internetChecking.isInternet()) {
  //     callVisitReservationDetailsApi();
  //   } else {
  //     showCustomToast(fToast, context, tr("noInternetConnection"), "");
  //   }
  // }

  void callVisitReservationDetailsApi() {
    setState(() {
      isLoading = true;
    });

    Map<String, String> body = {"visit_id": widget.visitId.toString().trim()};

    debugPrint("VisitReservation details input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.visitReservationDetailUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for VisitReservation details ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          VisitReservationDetailModel visitReservationDetailModel =
              VisitReservationDetailModel.fromJson(responseJson);

          Provider.of<VisitReservationDetailsProvider>(context, listen: false)
              .setItem(visitReservationDetailModel);
        } else {
          if (responseJson['message'] != null) {
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

  void networkCheckForVisitReservationStatusChange() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callVisitReservationStatusChangeApi();
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callVisitReservationStatusChangeApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "visit_id": widget.visitId.toString().trim(), //required
      "status": statusTypeValue.toString().trim() //required
    };

    debugPrint("VisitReservationStatusChange input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.visitReservationStatusChangeUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for VisitReservationStatusChange ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          setState(() {
            isLoadingRequired = true;
          });
          showConfirmationModal(responseJson['message'].toString());

          if (statusTypeValue == "cancelled") {
            setFirebaseEventForVisitReservation(
                eventName: "cp_cancel_reservation",
                visitReservationId: widget.visitId.toString().trim());
          } else if (statusTypeValue == "approved") {
            setFirebaseEventForChangeStatusForVisitReservation(
                visitReservationId: widget.visitId.toString().trim(),
                status: "approved");
          } else if (statusTypeValue == "rejected") {
            setFirebaseEventForChangeStatusForVisitReservation(
                visitReservationId: widget.visitId.toString().trim(),
                status: "rejected");
          }
        } else {
          if (responseJson['message'] != null) {
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

  void showConfirmationModal(String text) {
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
    if (status == "rejected" || status == "cancelled") {
      return CustomColors.backgroundColor3;
    } else {
      return CustomColors.backgroundColor;
    }
  }

  Color setStatusTextColor(String? status) {
    if (status == "visit_completed") {
      return CustomColors.textColor3;
    } else if (status == "rejected" || status == "cancelled") {
      return CustomColors.textColor9;
    } else {
      return CustomColors.textColorBlack2;
    }
  }

  // void loadPersonalInformation() async {
  //   final InternetChecking internetChecking = InternetChecking();
  //   if (await internetChecking.isInternet()) {
  //     callLoadPersonalInformationApi();
  //   } else {
  //     showCustomToast(fToast, context, tr("noInternetConnection"), "");
  //   }
  // }

  void callLoadPersonalInformationApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};

    debugPrint("Get personal info input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getPersonalInfoUrl, body, language, apiKey.trim());
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Get personal info ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          UserInfoModel userInfoModel = UserInfoModel.fromJson(responseJson);
          Provider.of<UserInfoProvider>(context, listen: false)
              .setItem(userInfoModel);

          setState(() {
            accountType = userInfoModel.accountType.toString();
          });
        } else {
          if (responseJson['message'] != null) {
            // showCustomToast(
            //     fToast, context, responseJson['message'].toString(), "");
            showErrorCommonModal(
                context: context,
                heading: responseJson['message'].toString(),
                description: "",
                buttonName: tr("check"));
          }
        }
      }
      setState(() {
        isLoading = false;
      });
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
