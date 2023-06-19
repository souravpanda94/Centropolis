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
    notificationListItem = Provider.of<NotificationProvider>(context).getNotificationList;


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
              child: AppBarForDialog(tr("notificationHistory"), () {
                onBackButtonPress(context);
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
                        return InkWell(
                          onTap: (){
                            goToDetailsScreen(notificationListItem?[index].notificationType.toString());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: CustomColors.whiteColor,
                                border: Border.all(
                                  color: CustomColors.borderColor,
                                ),
                                borderRadius:
                                const BorderRadius.all(Radius.circular(4))),
                            padding: const EdgeInsets.all(16),
                            margin: const EdgeInsets.only(bottom: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  // notificationList[index]["title"],
                                  notificationListItem?[index].title.toString() ?? "",
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                      fontFamily: 'SemiBold',
                                      fontSize: 14,
                                      color: CustomColors.textColor8),
                                ),
                                Container(
                                  margin:
                                  const EdgeInsets.symmetric(vertical: 16),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        flex: 3,
                                        child: Text(
                                          // notificationList[index]["subtitle"],
                                          notificationListItem?[index].content.toString() ?? "",
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                              fontFamily: 'Regular',
                                              fontSize: 14,
                                              color:
                                              CustomColors.textColorBlack2),
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
                                            color: CustomColors.textColorBlack2),
                                      ),
                                    ],
                                  ),
                                ),
                                Text(
                                  // notificationList[index]["datetime"],
                                  notificationListItem?[index].createdDate.toString() ?? "",
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
                        )
                          ;
                      })),
                ),

                if (page < totalPages)
                  ViewMoreWidget(
                    onViewMoreTap: () {
                      loadMore();
                    },
                  )
              ],
            ))),);
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
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
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
        ApiEndPoint.getNotificationListUrl,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for Notification List ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          totalPages = responseJson['total_pages'];
          List<NotificationModel> reservationListList =
          List<NotificationModel>.from(
              responseJson['inquiry_data']
                  .map((x) => NotificationModel.fromJson(x)));
          if (page == 1) {
            Provider.of<NotificationProvider>(context, listen: false)
                .setItem(reservationListList);
          } else {
            Provider.of<NotificationProvider>(context, listen: false)
                .addItem(reservationListList);
          }

          if(isFirstLoadRunning){
            setState(() {
              isFirstLoadRunning = false;
            });
            loadNotificationAllRead();
          }
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

  void goToDetailsScreen(String? notificationType) {
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => const FitnessReservation(position: 0),
    //   ),
    // );
  }

  void loadNotificationAllRead() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callNotificationAllReadApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

  void callNotificationAllReadApi() {
    setState(() {
      isLoading = true;
    });
    Map<String, String> body = {};

    debugPrint("Notification Read input===> $body");

    Future<http.Response> response = WebService().callPostMethodWithRawData(
        ApiEndPoint.serReadNotification,
        body,
        language.toString(),
        apiKey);
    response.then((response) {
      var responseJson = json.decode(response.body);

      debugPrint(
          "server response for Notification Read ===> $responseJson");

      if (responseJson != null) {
        if (response.statusCode == 200 && responseJson['success']) {
          if (responseJson['current_page'] != null) {
            debugPrint(
                "Notification Read ===> ${responseJson['current_page']}");
          }
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

}
