import 'dart:io';

import 'package:centropolis/utils/custom_colors.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_exit_app/flutter_exit_app.dart';
import 'package:store_redirect/store_redirect.dart';

import '../../widgets/bottom_navigation.dart';
import '../../widgets/common_button.dart';
import '../../widgets/common_button_with_border.dart';

class AppUpdateScreen extends StatefulWidget {
  final bool forceUpdateFlag;
  final String latestVersion;
  const AppUpdateScreen(
      {super.key, required this.forceUpdateFlag, required this.latestVersion});

  @override
  State<AppUpdateScreen> createState() => _AppUpdateScreenState();
}

class _AppUpdateScreenState extends State<AppUpdateScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.whiteColor,
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: double.infinity,
            color: CustomColors.whiteColor,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/centropolis_logo.png',
                  height: 69,
                  fit: BoxFit.fill,
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  "${tr("latestVersion")} ${widget.latestVersion}",
                  style: const TextStyle(
                      fontFamily: 'Regular',
                      fontSize: 14,
                      color: CustomColors.greyColor1),
                ),
                Container(
                  width: double.infinity,
                  color: CustomColors.whiteColor,
                  margin: const EdgeInsets.symmetric(vertical: 40),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 18),
                  child: Text(
                    tr("appUpdateContent"),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontFamily: 'Regular',
                        fontSize: 14,
                        height: 1.5,
                        color: CustomColors.greyColor1),
                  ),
                ),
                CommonButton(
                  onCommonButtonTap: () {
                    // update to latest version play store link
                    appUpdateButtonTap();
                  },
                  buttonColor: CustomColors.buttonBackgroundColor,
                  buttonName: tr("updateNow"),
                  isIconVisible: false,
                ),
                const SizedBox(
                  height: 16,
                ),
                CommonButtonWithBorder(
                    onCommonButtonTap: () {
                      if (widget.forceUpdateFlag) {
                        // exit app
                        // closeApp();
                        appClose();
                      } else {
                        //skip
                        Navigator.pop(context);
                        // goToHomeScreen();
                      }
                    },
                    buttonName:
                        widget.forceUpdateFlag ? tr("exitApp") : tr("skip"),
                    buttonColor: CustomColors.whiteColor,
                    buttonBorderColor: CustomColors.buttonBackgroundColor,
                    buttonTextColor: CustomColors.buttonBackgroundColor),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // void closeApp() {
  //   if (Platform.isAndroid) {
  //     SystemNavigator.pop();
  //   } else if (Platform.isIOS) {
  //     FlutterExitApp.exitApp(iosForceExit: true);
  //   }
  // }


  void appUpdateButtonTap() {
    StoreRedirect.redirect(
        androidAppId: "com.centropolis.centropolis",
        iOSAppId: "6449706077");
  }

  void appClose() {
    if (Platform.isAndroid) {
      SystemNavigator.pop();
    } else if (Platform.isIOS) {
      FlutterExitApp.exitApp(iosForceExit: true);
    }
  }

  void goToHomeScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const BottomNavigationScreen(0, 0),
      ),
    );
  }



}
