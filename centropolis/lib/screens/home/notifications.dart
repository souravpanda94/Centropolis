import 'dart:convert';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../../models/notification_model.dart';
import '../../providers/notification_provider.dart';
import '../../providers/user_provider.dart';
import '../../services/api_service.dart';
import '../../utils/custom_colors.dart';
import '../../utils/custom_urls.dart';
import '../../utils/internet_checking.dart';
import '../../utils/utils.dart';
import '../../widgets/app_bar_for_dialog.dart';
import '../../widgets/view_more.dart';
import '../my_page/conference_history_details.dart';
import '../my_page/facility_history_details.dart';
import '../my_page/fitnesss_tab_history_details.dart';
import '../my_page/gx_history_details.dart';
import '../my_page/inconvenience_history_details.dart';
import '../my_page/lounge_history_details.dart';
import '../my_page/paid_locker_history_details.dart';
import '../my_page/paid_pt_history_details.dart';
import '../visit_request/visit_reservation_details.dart';
import '../voc/air_conditioning_details.dart';
import '../voc/light_out_details.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late String language, apiKey, email, mobile, name, companyName;
  late FToast fToast;
  int page = 1;
  final int limit = 10;
  int totalPages = 0;
  bool isFirstLoadRunning = true;
  bool isLoading = true;
  List<NotificationModel>? notificationListItem;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    debugPrint("apiKey ==> $apiKey");
    firstTimeLoadNotificationList();
  }

  @override
  Widget build(BuildContext context) {
    notificationListItem =
        Provider.of<NotificationProvider>(context).getNotificationList;

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
            backgroundColor: CustomColors.backgroundColor,
            appBar: PreferredSize(
              preferredSize: AppBar().preferredSize,
              child: SafeArea(
                child: Container(
                  color: CustomColors.whiteColor,
                  child: AppBarForDialog(tr("notificationHistory"), () {
                    //onBackButtonPress(context);
                    Navigator.pop(context,true);
                  }),
                ),
              ),
            ),
            body: Container(
                margin: const EdgeInsets.only(top: 32, left: 16, right: 16),
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: notificationListItem?.length,
                          itemBuilder: ((context, index) {
                            // debugPrint(
                            //     "Notification Id -> ${notificationListItem?[index].id.toString()}");
                            // debugPrint(
                            //     "title -> ${notificationListItem?[index].title.toString()}");
                            // debugPrint(
                            //     "type -> ${notificationListItem?[index].notificationType.toString()}");
    
                            return InkWell(
                              onTap: () {
                                goToDetailsScreen(
                                    notificationListItem?[index]
                                        .notificationType
                                        .toString(),
                                    notificationListItem?[index].relId);
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      // notificationList[index]["title"],
                                      notificationListItem?[index]
                                              .title
                                              .toString() ??
                                          "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: 'SemiBold',
                                          fontSize: 15,
                                          color: CustomColors.textColor8),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 16),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            flex: 3,
                                            child: Text(
                                              // notificationList[index]["subtitle"],
                                              notificationListItem?[index]
                                                      .content
                                                      .toString() ??
                                                  "",
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  fontFamily: 'Regular',
                                                  fontSize: 14,
                                                  color: CustomColors
                                                      .textColorBlack2),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 8,
                                          ),
                                          Text(
                                            tr("contents"),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                                fontFamily: 'Regular',
                                                fontSize: 14,
                                                color:
                                                    CustomColors.textColorBlack2),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      // notificationList[index]["datetime"],
                                      notificationListItem?[index]
                                              .createdDate
                                              .toString() ??
                                          "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                          fontFamily: 'Regular',
                                          fontSize: 12,
                                          color: CustomColors.textColor3),
                                    ),
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
                ))),
      ),
    );
  }

  void firstTimeLoadNotificationList() {
    setState(() {
      isLoading = true;
    });
    loadNotificationList();
  }

  void loadNotificationList() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callNotificationListApi();
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callNotificationListApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {
      "page": page.toString(), //required
      "limit": limit.toString()
    };

    debugPrint("Notification List input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.getNotificationListUrl, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Notification List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          totalPages = responseJson['total_pages'];
          List<NotificationModel> reservationListList =
              List<NotificationModel>.from(responseJson['inquiry_data']
                  .map((x) => NotificationModel.fromJson(x)));
          if (page == 1) {
            Provider.of<NotificationProvider>(context, listen: false)
                .setItem(reservationListList);
          } else {
            Provider.of<NotificationProvider>(context, listen: false)
                .addItem(reservationListList);
          }

          if (isFirstLoadRunning) {
            setState(() {
              isFirstLoadRunning = false;
            });
            loadNotificationAllRead();
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

  void loadMore() {
    debugPrint("page ================> $page");
    debugPrint("totalPages ================> $totalPages");

    if (page < totalPages) {
      debugPrint("load more called");
      setState(() {
        page++;
      });
      loadNotificationList();
    }
  }

  void goToDetailsScreen(String? notificationType, int? relId) {
    if (notificationType == "add_sleeping_reservation" ||
        notificationType == "cancel_sleeping_reservation" ||
        notificationType == "reject_sleeping_reservation") {
      //sleeping room details

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => FacilityHistoryDetails(id: relId.toString()),
        ),
      );
    } else if (notificationType == "add_fitness_reservation" ||
        notificationType == "cancel_fitness_reservation" ||
        notificationType == "reject_fitness_reservation") {
      //fitness center details

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              FitnessTabHistoryDetails(reservationId: relId.toString()),
        ),
      );
    } else if (notificationType == "reply_complaint") {
      //complaint details

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              InconvenienceHistoryDetails(inquiryId: relId.toString()),
        ),
      );
    } else if (notificationType == "add_lounge_reservation" ||
        notificationType == "reject_lounge_reservation" ||
        notificationType == "cancel_lounge_reservation" ||
        notificationType == "payment_pending_lounge_reservation"
    ) {
      //lounge details

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LoungeHistoryDetails(relId.toString()),
        ),
      );
    } else if (notificationType == "add_locker_reservation" ||
        notificationType == "reject_locker_reservation" ||
        notificationType == "cancel_locker_reservation" ||
        notificationType == "reminder_pending_locker_reservation" ||
        notificationType == "payment_pending_lounge_reservation") {
      //locker details

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PaidLockerHistoryDetails(reservationId: relId.toString()),
        ),
      );
    } else if (notificationType == "reject_pt_reservation" ||
        notificationType == "cancel_pt_reservation" ||
        notificationType == "add_pt_reservation" ||
        notificationType == "reminder_pending_locker_reservation") {
      //pt details

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              PaidPTHistoryDetails(reservationId: relId.toString()),
        ),
      );
    } else if (notificationType == "reject_conference_reservation" ||
        notificationType == "add_conference_reservation" ||
        notificationType == "cancel_conference_reservation") {
      //conference details

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ConferenceHistoryDetails(relId.toString()),
        ),
      );
    } else if (notificationType == "reply_lights_out_inquiry" ||
        notificationType == "approve_lights_out_inquiry") {
      //lights out inquiry details

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              LightsOutDetails(id: relId.toString(), fromPage: "MyPage"),
        ),
      );
    } else if (notificationType == "reply_ac_inquiry" ||
        notificationType == "approve_ac_inquiry") {
      //ac inquiry details

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AirConditioningDetails(
              inquiryId: relId.toString(), fromPage: "MyPage"),
        ),
      );
    } else if (notificationType == "add_gx_reservation" ||
        notificationType == "cancel_gx_reservation" ||
        notificationType == "reject_gx_reservation") {
      // gx program details

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              GXHistoryDetails(reservationId: relId.toString()),
        ),
      );
    } else if (notificationType == "add_visitor_reservation" ||
        notificationType == "cancel_visitor_reservation" ||
        notificationType == "reject_visitor_reservation") {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => VisitReservationDetailsScreen(relId.toString()),
        ),
      );
    }
  }

  void loadNotificationAllRead() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callNotificationAllReadApi();
    } else {
      // showCustomToast(fToast, context, tr("noInternetConnection"), "");
      showErrorCommonModal(
          context: context,
          heading: tr("noInternet"),
          description: tr("connectionFailedDescription"),
          buttonName: tr("check"));
    }
  }

  void callNotificationAllReadApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};

    debugPrint("Notification Read input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.serReadNotification, body, language.toString(), apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint("server response for Notification Read ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['current_page'] != null) {
            debugPrint(
                "Notification Read ===> ${responseJson['current_page']}");
          }
        } else {
          if (responseJson['message'] != null) {
            // showCustomToast(fToast, context, responseJson['message'].toString(), "");
            debugPrint(
                "Notification Read false ===> ${responseJson['message']}");
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
}
