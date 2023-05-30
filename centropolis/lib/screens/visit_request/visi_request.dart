import 'dart:convert';
import 'package:centropolis/screens/visit_request/visit_reservations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import '../../../utils/custom_colors.dart';
import '../../models/visit_reservation_model.dart';
import '../../providers/user_provider.dart';
import '../../providers/visit_reservation_list_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import 'package:http/http.dart' as http;
import '../../widgets/common_button_with_icon.dart';
import 'visit_reservation_application.dart';

class VisitRequestScreen extends StatefulWidget {
  const VisitRequestScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _VisitRequestScreenState();
  }
}

class _VisitRequestScreenState extends State<VisitRequestScreen> {
  // List<dynamic> todayList = [
  //   {
  //     "id": 1,
  //     "name": "Hong Gil Dong",
  //     "businessType": "consulting",
  //     "type": "business",
  //     "dateTime": "2021.03.21 13:00",
  //     "status": "before visit"
  //   },
  //   {
  //     "id": 2,
  //     "name": "Hong Gil Dong",
  //     "businessType": "consulting",
  //     "type": "business",
  //     "dateTime": "2021.03.21 13:00",
  //     "status": "before visit"
  //   },
  //   {
  //     "id": 3,
  //     "name": "Hong Gil Dong",
  //     "businessType": "consulting",
  //     "type": "business",
  //     "dateTime": "2021.03.21 13:00",
  //     "status": "before visit"
  //   }
  // ];

  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 10;
  int totalPages = 0;
  bool isFirstLoadRunning = true;
  String todayDate = "";
  List<VisitReservationModel>? visitReservationListItem;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    getCurrentDate();
    loadVisitRequestList();
  }

  void getCurrentDate() {
    var date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.year}-${dateParse.month}-${dateParse.day}";

    setState(() {
      todayDate = formattedDate.toString();
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    visitReservationListItem = Provider.of<VisitReservationListProvider>(context).getVisitReservationList;


    return LoadingOverlay(
      opacity: 0.5,
      color: CustomColors.textColor4,
      progressIndicator: const CircularProgressIndicator(
        color: CustomColors.blackColor,
      ),
      isLoading: isFirstLoadRunning,
      child: Scaffold(
        backgroundColor: CustomColors.whiteColor,
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.only(bottom: 70),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(
                    top: 15.0,
                    bottom: 20.0,
                    left: 16.0,
                    right: 16.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        tr("today"),
                        style: const TextStyle(
                          fontSize: 22,
                          color: CustomColors.textColorBlack2,
                          fontFamily: 'SemiBold',
                        ),
                        textAlign: TextAlign.center,
                      ),
                      InkWell(
                        onTap: () {
                          goToViewAllVisitorReservation();
                        },
                        child: SizedBox(
                          child: SvgPicture.asset(
                            'assets/images/ic_drawer.svg',
                            semanticsLabel: 'Back',
                            width: 25,
                            height: 25,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                visitReservationListItem!.isNotEmpty
                    ? Container(
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
                                  goToReservationDetailsScreen();
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
                                              // todayList[index]["name"],
                                              visitReservationListItem?[index].visitorName.toString() ?? "",
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  fontFamily: "Bold",
                                                  color:
                                                      CustomColors.textColor8),
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: setStatusBackgroundColor(visitReservationListItem?[index].status.toString()),
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              padding: const EdgeInsets.only(
                                                  top: 5,
                                                  bottom: 5,
                                                  left: 10,
                                                  right: 10),
                                              child: Text(
                                                // todayList[index]["status"],
                                                  visitReservationListItem?[index].displayStatus.toString() ?? "",
                                                style:  TextStyle(
                                                    fontSize: 12,
                                                    fontFamily: "Bold",
                                                    color: setStatusTextColor(visitReservationListItem?[index].status.toString())),
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                            margin:
                                                const EdgeInsets.only(top: 6),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                      // todayList[index]
                                                      //     ["businessType"],
                                            visitReservationListItem?[index].companyName.toString() ?? "",
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
                                                      // todayList[index]["type"],
                                                      visitReservationListItem?[index].visitedPersonCompanyName.toString() ?? "",
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
                                            margin:
                                                const EdgeInsets.only(top: 6),
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
                                                  // todayList[index]["dateTime"],
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
                        ))
                    : Container(
                        decoration: BoxDecoration(
                          color: CustomColors.backgroundColor,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        margin: const EdgeInsets.only(
                          top: 20,
                          left: 16,
                          right: 16,
                        ),
                        padding: const EdgeInsets.only(
                            top: 25, bottom: 25, left: 35, right: 35),
                        child: Text(
                          tr("thereAreNoScheduledVisitorReservations"),
                          style: const TextStyle(
                              fontSize: 14,
                              fontFamily: "Regular",
                              color: CustomColors.textColor5),
                        ),
                      )
              ],
            ),
            // ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Container(
          height: 46,
          margin: const EdgeInsets.only(left: 16, right: 16, top: 30),
          child: CommonButtonWithIcon(
            buttonName: tr("visitReservationApplication"),
            isEnable: true,
            buttonColor: CustomColors.buttonBackgroundColor,
            onCommonButtonTap: () {
              goToVisitReservationApplicationScreen();
            },
          ),
        ),
      ),
    );
  }

  void goToViewAllVisitorReservation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const VisitReservationsScreen(),
      ),
    );
  }

  void goToVisitReservationApplicationScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const VisitReservationApplication(),
      ),
    );
  }

  void goToReservationDetailsScreen() {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const ReservationDetailsScreen(),
    //   ),
    // );
  }

  void loadVisitRequestList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadVisitRequestListApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callLoadVisitRequestListApi() {
    setState(() {
      isFirstLoadRunning = true;
    });
    Map<String, String> body = {
      "start_date": todayDate,
      "pagination": "false",
    };

    debugPrint("Visit Request List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getVisitRequestListUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Visit Request List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          List<VisitReservationModel> companyList = List<VisitReservationModel>.from(responseJson['reservation_data'].map((x) => VisitReservationModel.fromJson(x)));
          Provider.of<VisitReservationListProvider>(context, listen: false).setItem(companyList);
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

  Color setStatusBackgroundColor(String? status) {
    if (status == "approved" || status == "request_for_approval" || status == "visit_completed") {
      return CustomColors.backgroundColor;
    }
    else if(status == "request_for_approval"){
      return CustomColors.backgroundColor3;
    }
    else if(status == "rejected"){
      return CustomColors.backgroundColor4;
    }
    else{
      return CustomColors.backgroundColor;
    }
  }

  Color setStatusTextColor(String? status) {
    if (status == "approved" || status == "request_for_approval" || status == "visit_completed") {
      return CustomColors.textColorBlack2;
    }
    else if(status == "request_for_approval"){
      return CustomColors.textColor9;
    }
    else if(status == "rejected"){
      return CustomColors.headingColor;
    }
    else{
      return CustomColors.backgroundColor;
    }
  }

}
