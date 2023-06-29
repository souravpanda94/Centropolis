import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../models/user_info_model.dart';
import '../providers/user_info_provider.dart';
import '../providers/user_provider.dart';
import '../screens/amenity/tenant_service.dart';
import '../screens/home/home.dart';
import '../screens/home/notifications.dart';
import '../screens/my_page/app_settings.dart';
import '../screens/my_page/conference_history_details.dart';
import '../screens/my_page/facility_history_details.dart';
import '../screens/my_page/fitnesss_tab_history_details.dart';
import '../screens/my_page/gx_history_details.dart';
import '../screens/my_page/inconvenience_history_details.dart';
import '../screens/my_page/lounge_history_details.dart';
import '../screens/my_page/my_page.dart';
import '../screens/my_page/paid_locker_history_details.dart';
import '../screens/my_page/paid_pt_history_details.dart';
import '../screens/visit_request/visi_request.dart';
import '../screens/voc/air_conditioning_details.dart';
import '../screens/voc/light_out_details.dart';
import '../screens/voc/voc_application.dart';
import '../services/api_service.dart';
import '../services/notification_service.dart';
import '../utils/custom_colors.dart';
import '../utils/custom_urls.dart';
import '../utils/internet_checking.dart';
import '../utils/push_data_singleton.dart';
import '../utils/utils.dart';
import 'home_page_app_bar.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
FirebaseMessaging messaging = FirebaseMessaging.instance;

class BottomNavigationScreen extends StatefulWidget {
  final int tabIndex;
  final int amenityTabIndex;

  const BottomNavigationScreen(this.tabIndex, this.amenityTabIndex, {Key? key})
      : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BottomNavigationScreenState();
  }
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  late String apiKey, language;
  late FToast fToast;
  bool isLoading = false;
  int selectedPage = 0;
  int unreadNotificationCount = 0;
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    selectedPage = widget.tabIndex;
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
    initConnectivity();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();

    firebaseMessaging.streamCtlr.stream.listen((event) {
      Map pushObject = json.decode(event);
      var notificationData = PushDataSingleton();
      notificationData.doAddPushData(pushObject);
      if (kDebugMode) {
        print("pushNotification: ============== $pushObject");
      }

      // if (pushObject.isNotEmpty) {
      //   Map data = notificationData.pushData;
      //   String notificationId = data['value'].toString();
      //   debugPrint("======================> initState $notificationId");

      //   if (notificationId == '0') {
      //     checkInternetConnection(isTokenValidApi, context);
      //   }

      //   if (mounted) {
      //     // Provider.of<NotificationListProvider>(context, listen: false)
      //     //     .isNotificationAlert(id, title, date, description, status, false);
      //     //Provider.of<NotificationListProvider>(context, listen: false).reloadNotificationAPI();
      //   }
      // }
    });
    initializeNotifications();
    setupInteractedMessage();
    loadPersonalInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      appBar: selectedPage == 0
          ? null
          : PreferredSize(
              preferredSize: AppBar().preferredSize,
              child: SafeArea(
                child: Container(
                  color: CustomColors.whiteColor,
                  child: HomePageAppBar(
                      title: setTitle(selectedPage),
                      selectedPage: selectedPage,
                      unreadNotificationCount: unreadNotificationCount,
                      onSettingBtnTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AppSettingsScreen(),
                          ),
                        );
                      },
                      onNotificationBtnTap: () {
                        debugPrint("notification tap");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                          ),
                        );
                      }),
                ),
              ),
            ),
      body: Container(
        color: CustomColors.backgroundColor,
        child: <Widget>[
          const HomeScreen(),
          TenantServiceScreen(widget.amenityTabIndex),
          const VisitRequestScreen(),
          const VocApplicationScreen(),
          const MyPageScreen()
        ].elementAt(selectedPage),
      ),
      bottomNavigationBar: SizedBox(
        height: 70,
        child: BottomNavigationBar(
          backgroundColor: CustomColors.whiteColor,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  selectedPage == 0
                      ? "assets/images/ic_home_red.svg"
                      : "assets/images/ic_home.svg",
                  width: 18,
                  height: 18,
                ),
                label: tr("home"),
                backgroundColor: CustomColors.whiteColor),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  selectedPage == 1
                      ? "assets/images/ic_tenant_service_red.svg"
                      : "assets/images/ic_tenant_service.svg",
                  semanticsLabel: 'Back',
                  width: 18,
                  height: 18,
                ),
                label: tr("amenity"),
                backgroundColor: CustomColors.whiteColor),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  selectedPage == 2
                      ? "assets/images/ic_visit_reservation_red.svg"
                      : "assets/images/ic_visit_reservation.svg",
                  semanticsLabel: 'Back',
                  width: 18,
                  height: 18,
                ),
                label: tr("visitRequest"),
                backgroundColor: CustomColors.whiteColor),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  selectedPage == 3
                      ? "assets/images/ic_voc_red.svg"
                      : "assets/images/ic_voc.svg",
                  semanticsLabel: 'Back',
                  width: 18,
                  height: 18,
                ),
                label: tr("voc"),
                backgroundColor: CustomColors.whiteColor),
            BottomNavigationBarItem(
                icon: SvgPicture.asset(
                  selectedPage == 4
                      ? "assets/images/ic_my_page_red.svg"
                      : "assets/images/ic_my_page.svg",
                  semanticsLabel: 'Back',
                  width: 18,
                  height: 18,
                ),
                label: tr("myPage"),
                backgroundColor: CustomColors.whiteColor),
          ],
          type: BottomNavigationBarType.fixed,
          currentIndex: selectedPage,
          selectedItemColor: CustomColors.textColor9,
          selectedLabelStyle: const TextStyle(
            height: 2,
            fontSize: 12.0,
            fontFamily: 'Regular',
            color: CustomColors.textColor9,
          ),
          unselectedItemColor: CustomColors.textColor3,
          unselectedLabelStyle: const TextStyle(
              fontSize: 12.0,
              height: 2,
              fontFamily: 'Regular',
              color: CustomColors.textColor3),
          onTap: _onItemTapped,
          elevation: 5,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      selectedPage = index;
    });
  }

  setTitle(int selectedIndex) {
    if (selectedIndex == 1) {
      return tr("amenity");
    } else if (selectedIndex == 2) {
      return tr("visitRequest");
    } else if (selectedIndex == 3) {
      return tr("voc");
    } else if (selectedIndex == 4) {
      return tr("myPageHeading");
    } else {
      return "";
    }
  }

  void loadPersonalInformation() async {
    final InternetChecking internetChecking = InternetChecking();
    if (await internetChecking.isInternet()) {
      callLoadPersonalInformationApi();
    } else {
      showCustomToast(fToast, context, tr("noInternetConnection"), "");
    }
  }

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
            unreadNotificationCount = userInfoModel.unreadNotificationCount!;
          });
        } else {
          if (responseJson['message'] != null) {
            showCustomToast(
                fToast, context, responseJson['message'].toString(), "");
          }
        }
      }
      setState(() {
        isLoading = false;
      });
    }).catchError((onError) {
      debugPrint("catchError ================> $onError");
      setState(() {
        isLoading = false;
      });
    });
  }

//-----------------------------For Push Notification----------------------------
  Future<void> setupInteractedMessage() async {
    // Get any messages which caused the application to open from
    // a terminated state.
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    // If the message also contains a data property with a "type" of "chat",
    // navigate to a chat screen
    if (kDebugMode) {
      print("===============>>>>   $initialMessage");
    }
    if (initialMessage != null) {
      _handleMessage(initialMessage);
    }

    // Also handle any interaction when the app is in the background via a
    // Stream listener
    FirebaseMessaging.onMessageOpenedApp.listen(_handleMessage);
  }

  void _handleMessage(RemoteMessage message) async {
    final streamCtlr = StreamController<String>.broadcast();
    streamCtlr.sink.add(jsonEncode(message.data));
    debugPrint("click _handleMessage");
    debugPrint("Push notification data ===========>  ${message.data}");

    var notificationData = PushDataSingleton();
    debugPrint("Home screen notificationData iOS: ${message.data}");
    // debugPrint("Home screen notificationData for data: ${message.data}");
    // debugPrint("Home screen notificationData for notification: ${message.notification}");

    notificationData.doAddPushData(message.data);
    debugPrint(
        "notification detail handle message ====>  ${notificationData.pushData}");

    if (notificationData.pushData.isNotEmpty) {
      Map data = notificationData.pushData;
      var type = data['notification_type'];
      var relId = data['rel_id'];
      int id = int.parse(relId.toString());
      // String pushNotificationType = "";

      debugPrint("notification type ====>  $type");

      if (type == 'add_sleeping_reservation' ||
          type == 'cancel_sleeping_reservation' ||
          type == 'reject_sleeping_reservation') {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FacilityHistoryDetails(id: id.toString()),
            ));
      } else if (type == "add_fitness_reservation" ||
          type == "cancel_fitness_reservation" ||
          type == "reject_fitness_reservation") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FitnessTabHistoryDetails(reservationId: id.toString()),
          ),
        );
      } else if (type == "reply_complaint") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                InconvenienceHistoryDetails(inquiryId: id.toString()),
          ),
        );
      } else if (type == "add_lounge_reservation" ||
          type == "reject_lounge_reservation" ||
          type == "cancel_lounge_reservation" ||
          type == "payment_pending_lounge_reservation") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoungeHistoryDetails(id.toString()),
          ),
        );
      } else if (type == "add_locker_reservation" ||
          type == "reject_locker_reservation" ||
          type == "cancel_locker_reservation") {
        //locker details

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PaidLockerHistoryDetails(reservationId: id.toString()),
          ),
        );
      } else if (type == "reject_pt_reservation" ||
          type == "cancel_pt_reservation" ||
          type == "add_pt_reservation") {
        //pt details

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PaidPTHistoryDetails(reservationId: id.toString()),
          ),
        );
      } else if (type == "reject_conference_reservation" ||
          type == "add_conference_reservation" ||
          type == "cancel_conference_reservation") {
        //conference details

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConferenceHistoryDetails(id.toString()),
          ),
        );
      } else if (type == "reply_lights_out_inquiry" ||
          type == "approve_lights_out_inquiry") {
        //lights out inquiry details

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LightsOutDetails(id: id.toString()),
          ),
        );
      } else if (type == "reply_ac_inquiry" || type == "approve_ac_inquiry") {
        //ac inquiry details

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AirConditioningDetails(inquiryId: id.toString()),
          ),
        );
      } else if (type == "add_gx_reservation" ||
          type == "cancel_gx_reservation" ||
          type == "reject_gx_reservation") {
        // gx program details

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                GXHistoryDetails(reservationId: id.toString()),
          ),
        );
      } else {
        debugPrint("from background #### 1111");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigationScreen(0, 0),
          ),
        );
      }
    }
    // notificationReadApiCall(id, pushNotificationType);
  }

  initializeNotifications() async {
    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@drawable/ic_notification');
    DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
            onDidReceiveLocalNotification: onDidReceiveLocalNotification);
    InitializationSettings initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: onSelectNotification,
    );

    if (Platform.isIOS) {
      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      if (kDebugMode) {
        print('User granted permission: ${settings.authorizationStatus}');
      }
    }
  }

  void onDidReceiveLocalNotification(
      int? id, String? title, String? body, String? payload) async {
    debugPrint('onDidReceiveLocalNotification payload ::::::: $payload');
    // display a dialog with the notification details, tap ok to go to another page
    var notificationData = PushDataSingleton();
    debugPrint(
        "notification detail select notification (onDidReceiveLocalNotification) ====>  ${notificationData.pushData}");
  }

  // void onSelectNotification(String? payload) async {
  onSelectNotification(NotificationResponse notificationResponse) async {
    var notificationData = PushDataSingleton();
    debugPrint(
        "notification detail select notification ====>  ${notificationData.pushData}");

    if (notificationData.pushData.isNotEmpty) {
      Map data = notificationData.pushData;
      var type = data['notification_type'];
      var relId = data['rel_id'];
      int id = int.parse(relId.toString());
      debugPrint("notification type ====>  $type");

      if (type == 'add_sleeping_reservation' ||
          type == 'cancel_sleeping_reservation' ||
          type == 'reject_sleeping_reservation') {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FacilityHistoryDetails(id: id.toString()),
            ));
      } else if (type == "add_fitness_reservation" ||
          type == "cancel_fitness_reservation" ||
          type == "reject_fitness_reservation") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                FitnessTabHistoryDetails(reservationId: id.toString()),
          ),
        );
      } else if (type == "reply_complaint") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                InconvenienceHistoryDetails(inquiryId: id.toString()),
          ),
        );
      } else if (type == "add_lounge_reservation" ||
          type == "reject_lounge_reservation" ||
          type == "cancel_lounge_reservation" ||
          type == "payment_pending_lounge_reservation") {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LoungeHistoryDetails(id.toString()),
          ),
        );
      } else if (type == "add_locker_reservation" ||
          type == "reject_locker_reservation" ||
          type == "cancel_locker_reservation") {
        //locker details

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PaidLockerHistoryDetails(reservationId: id.toString()),
          ),
        );
      } else if (type == "reject_pt_reservation" ||
          type == "cancel_pt_reservation" ||
          type == "add_pt_reservation") {
        //pt details

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                PaidPTHistoryDetails(reservationId: id.toString()),
          ),
        );
      } else if (type == "reject_conference_reservation" ||
          type == "add_conference_reservation" ||
          type == "cancel_conference_reservation") {
        //conference details

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConferenceHistoryDetails(id.toString()),
          ),
        );
      } else if (type == "reply_lights_out_inquiry" ||
          type == "approve_lights_out_inquiry") {
        //lights out inquiry details

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => LightsOutDetails(id: id.toString()),
          ),
        );
      } else if (type == "reply_ac_inquiry" || type == "approve_ac_inquiry") {
        //ac inquiry details

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                AirConditioningDetails(inquiryId: id.toString()),
          ),
        );
      } else if (type == "add_gx_reservation" ||
          type == "cancel_gx_reservation" ||
          type == "reject_gx_reservation") {
        // gx program details

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                GXHistoryDetails(reservationId: id.toString()),
          ),
        );
      } else {
        debugPrint("from background #### 1111");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const BottomNavigationScreen(0, 0),
          ),
        );
      }
    }

    // notificationReadApiCall(id, pushNotificationType);
  }

  Future<void> initConnectivity() async {
    late ConnectivityResult result;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      result = await _connectivity.checkConnectivity();
    } on PlatformException catch (e) {
      log('Couldn\'t check connectivity status', error: e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      _connectionStatus = result;
    });
    if (_connectionStatus.toString() == "ConnectivityResult.none") {
      if (Platform.isAndroid) {
        showCustomToast(fToast, context, tr("noInternetConnection"), "");
      }
    }
  }
}
