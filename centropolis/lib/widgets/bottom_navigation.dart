import 'dart:convert';
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
import '../screens/home/bar_code.dart';
import '../screens/home/home.dart';
import '../screens/home/notifications.dart';
import '../screens/my_page/app_settings.dart';
import '../screens/my_page/my_page.dart';
import '../screens/visit_request/visi_request.dart';
import '../screens/voc/voc_application.dart';
import '../services/api_service.dart';
import '../utils/custom_colors.dart';
import '../utils/custom_urls.dart';
import '../utils/internet_checking.dart';
import '../utils/utils.dart';
import 'home_page_app_bar.dart';

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

  // @override
  // void initState() {
  //
  //   super.initState();
  // }


  @override
  void initState() {
    super.initState();
    selectedPage = widget.tabIndex;
    fToast = FToast();
    fToast.init(context);
    language = tr("lang");
    var user = Provider.of<UserProvider>(context, listen: false);
    apiKey = user.userData['api_key'].toString();
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
                      unreadNotificationCount : unreadNotificationCount,
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
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: CustomColors.whiteColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                selectedPage == 0
                    ? "assets/images/ic_home_red.svg"
                    : "assets/images/ic_home.svg",
                width: 25,
                height: 25,
              ),
              label: tr("home"),
              backgroundColor: CustomColors.whiteColor),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                selectedPage == 1
                    ? "assets/images/ic_tenant_service_red.svg"
                    : "assets/images/ic_tenant_service.svg",
                semanticsLabel: 'Back',
                width: 25,
                height: 25,
              ),
              label: tr("amenity"),
              backgroundColor: CustomColors.whiteColor),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                selectedPage == 2
                    ? "assets/images/ic_visit_reservation_red.svg"
                    : "assets/images/ic_visit_reservation.svg",
                semanticsLabel: 'Back',
                width: 25,
                height: 25,
              ),
              label: tr("visitRequest"),
              backgroundColor: CustomColors.whiteColor),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                selectedPage == 3
                    ? "assets/images/ic_voc_red.svg"
                    : "assets/images/ic_voc.svg",
                semanticsLabel: 'Back',
                width: 25,
                height: 25,
              ),
              label: tr("voc"),
              backgroundColor: CustomColors.whiteColor),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                selectedPage == 4
                    ? "assets/images/ic_my_page_red.svg"
                    : "assets/images/ic_my_page.svg",
                semanticsLabel: 'Back',
                width: 25,
                height: 25,
              ),
              label: tr("myPage"),
              backgroundColor: CustomColors.whiteColor),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: selectedPage,
        selectedItemColor: CustomColors.textColor9,
        selectedLabelStyle: const TextStyle(
          fontSize: 12.0,
          fontFamily: 'Regular',
          color: CustomColors.textColor9,
        ),
        unselectedItemColor: CustomColors.textColor3,
        unselectedLabelStyle: const TextStyle(
            fontSize: 12.0,
            fontFamily: 'Regular',
            color: CustomColors.textColor3),
        onTap: _onItemTapped,
        elevation: 5,
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


}
