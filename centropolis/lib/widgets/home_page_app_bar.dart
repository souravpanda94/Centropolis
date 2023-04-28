import 'dart:ui';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../utils/constants.dart';
import '../utils/custom_colors.dart';

class HomePageAppBar extends StatelessWidget {
  final String title;
  final Function onScannerBtnTap;
  final Function onNotificationBtnTap;

  const HomePageAppBar(this.title, this.onScannerBtnTap,this.onNotificationBtnTap, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppBar(
            toolbarHeight: 54,
            centerTitle: true,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            elevation: 0,
            backgroundColor: CustomColors.whiteColor,
            title: Text(
              title,
              style: const TextStyle(
                color: CustomColors.textColor8,
                fontFamily: 'SemiBold',
                fontSize: 16.0,
                // fontWeight: AppTranslations.of(context).currentLanguage == "ko" ? FontWeight.w800 : FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            // leading: IconButton(
            //   icon: SvgPicture.asset(
            //     "assets/images/ic_scanner.svg",
            //     semanticsLabel: 'Back',
            //   ),
            //   onPressed: () {
            //     onScannerBtnTap();
            //   },
            // ),
            actions: [
              IconButton(
                icon: SvgPicture.asset(
                  "assets/images/ic_notification_with_indicator.svg",
                  semanticsLabel: 'Back',
                ),
                onPressed: () {
                  onNotificationBtnTap();
                },
              )
            ]),
        // const Divider(
        //   color: CustomColors.borderColor,
        //   height: 2,
        // ),
      ],
    );
  }
}
